/// <summary>
/// Codeunit Gestionar compra presupuestada.
/// </summary>
codeunit 50100 "Gestionar compra presupuestada"
{

    internal procedure ProcesarPresupuesto(prPresupuesto: Record "Presupuesto compra")
    var
        NoEsPresupuesto: Label 'Esta linea no es de presupuesto.';
        lwFecha: Date;
        lwFechaFinal: Date;
        lrMovPresupuesto: Record "Mov. Presupuesto compra";
        PresupYaGenerado: Label 'Presupuesto ya generado.';
        lwIndice: Integer;
        ProcesoFinalizado: Label 'Proceso finalizado.';
    begin
        if prPresupuesto."Tipo presupuesto" = prPresupuesto."Tipo presupuesto"::Ahorro then
            Error(NoEsPresupuesto);

        lwFecha := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3));
        lwFechaFinal := DMY2Date(31, 12, Date2DMY(Today, 3));

        //. Miramos si ya tiene movimientos para este año
        lrMovPresupuesto.Reset();
        lrMovPresupuesto.SetRange("ID Presupuesto", prPresupuesto.ID);
        lrMovPresupuesto.SetFilter(Fecha, '<=%1', lwFechaFinal);
        if lrMovPresupuesto.FindFirst() then
            Error(PresupYaGenerado);

        for lwIndice := 1 to 12 do begin
            if lwIndice > 1 then
                lwFecha := CalcDate('<1M>', lwFecha);

            if lwFecha < lwFechaFinal then begin
                Clear(lrMovPresupuesto);
                lrMovPresupuesto."ID Presupuesto" := prPresupuesto.ID;
                lrMovPresupuesto.Fecha := lwFecha;
                lrMovPresupuesto.Importe := prPresupuesto."Importe mensual";
                lrMovPresupuesto.Concepto := prPresupuesto.Concepto;
                lrMovPresupuesto.Subconcepto := prPresupuesto.Subconcepto;
                lrMovPresupuesto."Fecha creacion" := CurrentDateTime;
                lrMovPresupuesto.Insert();
            end;
        end;
        Message(ProcesoFinalizado);
    end;

    /// <summary>
    /// _ProcesarCompras.
    /// </summary>
    local procedure _ProcesarCompras()
    var
        lrPresupCompra: Record "Presupuesto compra";
    begin
        lrPresupCompra.Reset();
        lrPresupCompra.SetRange("Tipo presupuesto", lrPresupCompra."Tipo presupuesto"::Ahorro);
        lrPresupCompra.SetRange(Caducado, false);
        lrPresupCompra.SetFilter("Fecha ult. operacion", '<%1', Today);
        if lrPresupCompra.FindSet() then
            repeat
                //. Solo una vez al mes
                if Date2DMY(lrPresupCompra."Fecha ult. operacion", 2) <> Date2DMY(Today, 2) then
                    if not lrPresupCompra."Objetivo alcanzado" then begin
                        _ProcesarCompraActiva(lrPresupCompra);

                        lrPresupCompra."Fecha ult. operacion" := Today;
                        lrPresupCompra."Meses ahorrados (Real)" += 1;
                        lrPresupCompra.Modify();
                    end
                    else begin
                        _ProcesarCompraObjetivoAlcanzado(lrPresupCompra);

                        lrPresupCompra."Fecha ult. operacion" := Today;
                        lrPresupCompra.Modify();
                    end;
            until lrPresupCompra.Next() = 0;

    end;

    /// <summary>
    /// _ProcesarCompraActiva.
    /// </summary>
    /// <param name="prPresupCompra">Record "Presupuesto compra".</param>
    local procedure _ProcesarCompraActiva(prPresupCompra: Record "Presupuesto compra")
    var
        lwFecha: Date;
        lrAsiento: Record Asiento;
        lrAsiento2: Record Asiento;
        lrAsiento3: Record Asiento;
    begin
        //. Para las compras activas hay que crear un nuevo registro
        //. Vamos moviendo lo ahorrado al siguiente mes
        lwFecha := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3));

        //. Creamos el asiento correspondiente a este mes
        lrAsiento.Init();
        lrAsiento.Validate(Banco, prPresupCompra.Banco);
        lrAsiento.Validate(Concepto, prPresupCompra.Concepto);
        lrAsiento.Validate(Subconcepto, prPresupCompra.Subconcepto);
        lrAsiento.Validate(Fecha, CalcDate('<+1M>', lwFecha));
        lrAsiento.Validate("Gasto/Ingreso", lrAsiento."Gasto/Ingreso"::Gasto);
        lrAsiento.Validate(Importe, prPresupCompra."Importe mensual");
        lrAsiento.Validate("Fecha entrada", Today);
        lrAsiento.Validate(Definitivo, false);
        lrAsiento.Validate(Observaciones, prPresupCompra.Descripcion);
        lrAsiento.Validate("ID Presupuesto", prPresupCompra.ID);
        lrAsiento.Insert(true);

        //. Acumulamos los movimientos de los meses anteriores sobre el actual para no tener demasiados movimientos
        lrAsiento2.Reset();
        lrAsiento2.SetRange("ID Presupuesto", prPresupCompra.ID);
        lrAsiento2.SetRange(Definitivo, false);
        lrAsiento2.SetFilter("Num. Asiento", '<>%1', lrAsiento."Num. Asiento");
        if lrAsiento2.FindSet() then
            repeat
                lrAsiento.Importe += lrAsiento2.Importe;
                lrAsiento."Importe signo" += lrAsiento2."Importe signo";
                lrAsiento.Modify();

                lrAsiento3 := lrAsiento2;
                lrAsiento3.Delete();
            until lrAsiento2.Next() = 0;
    end;

    /// <summary>
    /// _ProcesarCompraObjetivoAlcanzado.
    /// </summary>
    /// <param name="prPresupCompra">Record "Presupuesto compra".</param>
    local procedure _ProcesarCompraObjetivoAlcanzado(prPresupCompra: Record "Presupuesto compra")
    var
        lwFecha: Date;
        lrAsiento: Record Asiento;
    begin
        //. Para las compras que ya hemos alcanzado el objetivo solo hay que arrastrar lo ahorrado al mes siguiente
        lwFecha := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3));

        //. Buscamos el último asiento para esta compra
        lrAsiento.Reset();
        lrAsiento.SetRange("ID Presupuesto", prPresupCompra.ID);
        lrAsiento.SetRange(Definitivo, false);
        if lrAsiento.FindLast() then begin
            //. Lo movemos al mes siguiente
            lrAsiento.Validate(Fecha, CalcDate('<+1M>', lwFecha));
            lrAsiento.Modify();
        end;
    end;

    trigger OnRun()
    begin
        _ProcesarCompras();
    end;
}