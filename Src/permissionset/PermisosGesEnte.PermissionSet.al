/// <summary>
/// Unknown Permisos GesEnte (ID 50100).
/// </summary>
permissionset 50100 "Permisos GesEnte"
{
    Assignable = true;
    Permissions =
        tabledata Asiento = RIMD,
        tabledata Banco = RIMD,
        tabledata Concepto = RIMD,
        tabledata Empresa = RIMD,
        tabledata "GesEnte Cue" = RIMD,
        tabledata "Historico compras" = RIMD,
        tabledata "Mov. Presupuesto compra" = RIMD,
        tabledata Parametros = RIMD,
        tabledata "Prestamos pendientes" = RIMD,
        tabledata "Presupuesto compra" = RIMD,
        tabledata "Recibo domiciliado" = RIMD,
        tabledata Subconcepto = RIMD,
        tabledata Tarjeta = RIMD,
        tabledata "Temporal compras tarjeta" = RIMD;
}