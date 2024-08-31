/// <summary>
/// Codeunit Cargar Excel BBVA (ID 50102).
/// </summary>
codeunit 50102 "Gestion Excel Bancos"
{

    internal procedure LeerFicheroBBVA()
    var
        TempExcelBuf: Record "Excel Buffer" temporary;
        Instr: InStream;
        FileMgmt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        ProcesoFinalizadoTxt: Label 'Proceso finalizado';
    begin
        TempBlob.CreateInStream(Instr);
        FileMgmt.BLOBImportWithFilter(TempBlob, 'Seleccionar archivo extracto BBVA', '', '*.xlsx|*.XLSX', 'xlsx,XLSX');
        TempExcelBuf.OpenBookStream(Instr, 'Informe BBVA');
        TempExcelBuf.ReadSheet();
        if TempExcelBuf.IsEmpty then
            exit;

        RecorrerExcelBBVA(TempExcelBuf);

        Message(ProcesoFinalizadoTxt);
    end;

    internal procedure LeerFicheroSantander()
    var
        TempExcelBuf: Record "Excel Buffer" temporary;
        Instr: InStream;
        FileMgmt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        ProcesoFinalizadoTxt: Label 'Proceso finalizado';
    begin
        TempBlob.CreateInStream(Instr);
        FileMgmt.BLOBImportWithFilter(TempBlob, 'Seleccionar archivo extracto Santander', '', '*.xlsx|*.XLSX', 'xlsx,XLSX');
        TempExcelBuf.OpenBookStream(Instr, 'Movimientos');
        TempExcelBuf.ReadSheet();
        if TempExcelBuf.IsEmpty then
            exit;

        RecorrerExcelSantander(TempExcelBuf);

        Message(ProcesoFinalizadoTxt);
    end;

    internal procedure ProcesarRegistro(prTemporalImport: Record "Banco Temporal importacion"; pwVerbose: Boolean)
    var
        ProcesarRegistroQst: Label 'Continuar con el proceso de traspaso de este registo?';
        ConfirmMgmt: Codeunit "Confirm Management";
        lrAsiento: Record Asiento;
        lrBancoImport: Record "Banco Temporal importacion";
        lrSubconcepto: Record Subconcepto;
        lLookupSubconcepto: Page "Subconceptos Lookup";
        lwTextoAsiento: Text[250];
        lrTarjeta: Record Tarjeta;
    begin
        if pwVerbose then begin
            if not ConfirmMgmt.GetResponseOrDefault(ProcesarRegistroQst, true) then
                exit;
            //. Si la linea no tiene subconcepto, lo pedimos
            if prTemporalImport.Subconcepto = '' then begin
                Clear(lLookupSubconcepto);
                lLookupSubconcepto.LookupMode(true);
                if lLookupSubconcepto.RunModal() <> Action::LookupOK then
                    exit;
                lLookupSubconcepto.GetRecord(lrSubconcepto);
                prTemporalImport.Concepto := lrSubconcepto.Concepto;
                prTemporalImport.Subconcepto := lrSubconcepto."Codigo Subconcepto";
            end;
        end;

        lwTextoAsiento := prTemporalImport."Texto concepto";
        if prTemporalImport.Observaciones <> '' then
            lwTextoAsiento := lwTextoAsiento + ', ' + CopyStr(prTemporalImport.Observaciones, 1, MaxStrLen(lwTextoAsiento) - (StrLen(lwTextoAsiento) + 2));

        lrAsiento.Init();
        lrAsiento.Validate(Banco, prTemporalImport.Banco);
        lrAsiento.Validate(Fecha, prTemporalImport."Fecha valor");
        lrAsiento.Validate(Concepto, prTemporalImport.Concepto);
        lrAsiento.Validate(Subconcepto, prTemporalImport.Subconcepto);
        lrAsiento.Validate(Empresa, prTemporalImport.Empresa);
        lrAsiento.Validate(Observaciones, lwTextoAsiento);
        if prTemporalImport.Tarjeta <> '' then
            if lrTarjeta.Get(prTemporalImport.Banco, prTemporalImport.Tarjeta) then
                lrAsiento.Validate(Tarjeta, prTemporalImport.Tarjeta);

        if prTemporalImport.Importe < 0 then
            lrAsiento.Validate("Gasto/Ingreso", lrAsiento."Gasto/Ingreso"::Gasto)
        else
            lrAsiento.Validate("Gasto/Ingreso", lrAsiento."Gasto/Ingreso"::Ingreso);
        lrAsiento.Validate(Importe, Abs(prTemporalImport.Importe));
        lrAsiento.Insert(true);

        lrBancoImport := prTemporalImport;
        lrBancoImport.Delete();
    end;

    local procedure RecorrerExcelBBVA(var prExcelTemp: Record "Excel Buffer" temporary)
    var
        lrBBVAMov: Record "Banco Temporal importacion";
    begin
        prExcelTemp.SetFilter("Row No.", '>%1', 5);
        prExcelTemp.SetRange("Column No.", 2);
        if prExcelTemp.FindSet() then begin
            lrBBVAMov.Reset();
            lrBBVAMov.DeleteAll();
            repeat
                ProcesarLineaBBVA(prExcelTemp);
            until prExcelTemp.Next() = 0;
        end;
    end;

    local procedure ProcesarLineaBBVA(var prExcelTemp: Record "Excel Buffer" temporary)
    var
        lrBBVAMov: Record "Banco Temporal importacion";
        lrConvConcepto: Record "Conv. texto concepto banco";
        lrExcelLineaTMP: Record "Excel Buffer" temporary;
    begin
        lrExcelLineaTMP.Copy(prExcelTemp, true);
        lrBBVAMov.Init();
        lrBBVAMov.Banco := 'BBVA';

        //. Fecha valor
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 3) then
            if not Evaluate(lrBBVAMov."Fecha valor", lrExcelLineaTMP."Cell Value as Text") then
                lrBBVAMov."Fecha valor" := 0D;
        //. Concepto
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 4) then
            lrBBVAMov."Texto concepto" := CopyStr(lrExcelLineaTMP."Cell Value as Text", 1, MaxStrLen(lrBBVAMov."Texto concepto"));
        //. Movimiento
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 5) then
            lrBBVAMov.Movimiento := CopyStr(lrExcelLineaTMP."Cell Value as Text", 1, MaxStrLen(lrBBVAMov.Movimiento));
        //. Importe
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 6) then
            if not Evaluate(lrBBVAMov.Importe, lrExcelLineaTMP."Cell Value as Text") then
                lrBBVAMov.Importe := 0;
        //. Disponible
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 8) then
            if not Evaluate(lrBBVAMov.Disponible, lrExcelLineaTMP."Cell Value as Text") then
                lrBBVAMov.Disponible := 0;
        //. Observaciones
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 10) then
            lrBBVAMov.Observaciones := CopyStr(lrExcelLineaTMP."Cell Value as Text", 1, MaxStrLen(lrBBVAMov.Observaciones));

        if CopyStr(lrBBVAMov.Observaciones, 1, 4) = '4940' then
            lrBBVAMov.Tarjeta := CopyStr(lrBBVAMov.Observaciones, 1, 16);

        lrBBVAMov.Observaciones := CopyStr(lrBBVAMov.Observaciones, 17, StrLen(lrBBVAMov.Observaciones));

        //. Buscar la tabla de conversión
        lrConvConcepto.Reset();
        lrConvConcepto.SetRange(Banco, lrBBVAMov.Banco);
        //lrConvConcepto.SetRange("Texto concepto", lrBBVA."Texto concepto");
        if lrConvConcepto.FindSet() then
            repeat
                if StrPos(lrBBVAMov."Texto concepto", lrConvConcepto."Texto concepto") <> 0 then begin
                    lrBBVAMov.Concepto := lrConvConcepto.Concepto;
                    lrBBVAMov.Subconcepto := lrConvConcepto.Subconcepto;
                    lrBBVAMov.Empresa := lrConvConcepto.Empresa;
                end;
            until lrConvConcepto.Next() = 0;

        lrBBVAMov.Insert(true);
    end;

    local procedure RecorrerExcelSantander(var prExcelTemp: Record "Excel Buffer" temporary)
    var
        lrSantanderMov: Record "Banco Temporal importacion";
    begin
        prExcelTemp.SetFilter("Row No.", '>%1', 8);
        prExcelTemp.SetRange("Column No.", 1);
        if prExcelTemp.FindSet() then begin
            lrSantanderMov.Reset();
            lrSantanderMov.DeleteAll();
            repeat
                ProcesarLineaSantander(prExcelTemp);
            until prExcelTemp.Next() = 0;
        end;
    end;

    local procedure ProcesarLineaSantander(var prExcelTemp: Record "Excel Buffer" temporary)
    var
        lrSantanderMov: Record "Banco Temporal importacion";
        lrConvConcepto: Record "Conv. texto concepto banco";
        lrExcelLineaTMP: Record "Excel Buffer" temporary;
    begin
        lrExcelLineaTMP.Copy(prExcelTemp, true);

        lrSantanderMov.Init();
        lrSantanderMov.Banco := 'SANTANDER';

        //. Fecha movimiento
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 1) then
            if not Evaluate(lrSantanderMov."Fecha valor", lrExcelLineaTMP."Cell Value as Text") then
                lrSantanderMov."Fecha valor" := 0D;
        //. Concepto
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 3) then
            lrSantanderMov."Texto concepto" := CopyStr(lrExcelLineaTMP."Cell Value as Text", 1, MaxStrLen(lrSantanderMov."Texto concepto"));
        //. Importe
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 4) then
            if not Evaluate(lrSantanderMov.Importe, lrExcelLineaTMP."Cell Value as Text") then
                lrSantanderMov.Importe := 0;
        //. Disponible
        if lrExcelLineaTMP.Get(prExcelTemp."Row No.", 5) then
            if not Evaluate(lrSantanderMov.Disponible, lrExcelLineaTMP."Cell Value as Text") then
                lrSantanderMov.Disponible := 0;

        //. Buscar la tabla de conversión
        lrConvConcepto.Reset();
        lrConvConcepto.SetRange(Banco, lrSantanderMov.Banco);
        //lrConvConcepto.SetRange("Texto concepto", lrBBVA."Texto concepto");
        if lrConvConcepto.FindSet() then
            repeat
                if StrPos(lrSantanderMov."Texto concepto", lrConvConcepto."Texto concepto") <> 0 then begin
                    lrSantanderMov.Concepto := lrConvConcepto.Concepto;
                    lrSantanderMov.Subconcepto := lrConvConcepto.Subconcepto;
                    lrSantanderMov.Empresa := lrConvConcepto.Empresa;
                end;
            until lrConvConcepto.Next() = 0;

        lrSantanderMov.Insert(true);
    end;
}