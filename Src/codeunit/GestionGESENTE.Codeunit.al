/// <summary>
/// Codeunit Gestion GESENTE (ID 50101).
/// </summary>
codeunit 50101 "Gestion GESENTE"
{
    trigger OnRun()
    begin

    end;

    internal procedure VerTarjetas()
    var
        lpageTarjetas: Page "Lista Tarjetas";
        lTarjeta: Record Tarjeta;
    begin
        lTarjeta.Reset();
        lTarjeta.SetFilter("Movimientos pendientes", '<>%1', 0);

        Clear(lpageTarjetas);
        lpageTarjetas.SetTableView(lTarjeta);
        lpageTarjetas.RunModal();
    end;

    internal procedure CambiarFechaMasivo(var prAsiento: Record Asiento)
    var
        pagePedirFecha: Page "Date-Time Dialog";
        confirmMgmt: Codeunit "Confirm Management";
        lFechaHora: DateTime;
        lNuevaFecha: Date;
        cambioFechaConf: Label 'Poner la fecha %1 en todos los asientos seleccionados?', Comment = '%1 es para la fecha nueva';
        lrAsiento: Record Asiento;
    begin
        //. Pedir la fecha
        Clear(pagePedirFecha);
        pagePedirFecha.RunModal();
        lFechaHora := pagePedirFecha.GetDateTime();
        lNuevaFecha := DT2Date(lFechaHora);

        if not confirmMgmt.GetResponse(StrSubstNo(cambioFechaConf, lNuevaFecha), false) then
            exit;

        if prAsiento.FindSet() then
            repeat
                lrAsiento := prAsiento;
                lrAsiento.Validate(Fecha, lNuevaFecha);
                lrAsiento.Modify(true);
            until prAsiento.Next() = 0;
    end;
}