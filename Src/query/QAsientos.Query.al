/// <summary>
/// Query QAsientos (ID 50100).
/// </summary>
query 50100 QAsientos
{
    Caption = 'QAsientos';
    QueryType = Normal;

    elements
    {
        dataitem(Asiento; Asiento)
        {
            column(Banco; Banco)
            {
            }
            column(Concepto; Concepto)
            {
            }
            column(Subconcepto; Subconcepto)
            {
            }
            column(Fecha; Fecha)
            {
            }
            column(Gasto_Ingreso; "Gasto/Ingreso")
            {
            }
            column(Importe; Importe)
            {
            }
            column(Importe_Signo; "Importe signo")
            {
            }
            column(Observaciones; Observaciones)
            {
            }
            column(Empresa; Empresa)
            {
            }
            column(Definitivo; Definitivo)
            {
            }
            column(ID_Presupuesto; "ID Presupuesto")
            {
            }
            column(Traspaso; Traspaso)
            {
            }
            column(Aportacion; Aportacion)
            {
            }
            column(NumParticipaciones; NumParticipaciones)
            {
            }
            column(Valorunitario; "Valor unitario")
            {
            }
            column(Incremento; Incremento)
            {
            }
            dataitem(rBanco; Banco)
            {
                DataItemLink = Codigo = Asiento.Banco;
                column(NombreBanco; Nombre)
                {

                }
            }
        }
    }

}
