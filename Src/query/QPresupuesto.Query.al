/// <summary>
/// Query "QPresupuesto" (ID 50101).
/// </summary>
query 50101 QPresupuesto
{
    Caption = 'QPresupuesto';
    QueryType = Normal;

    elements
    {
        dataitem(Presupuestocompra; "Presupuesto compra")
        {
            column(Tipopresupuesto; "Tipo presupuesto")
            {
            }
            column(Banco; Banco)
            {
            }
            column(Concepto; Concepto)
            {
            }
            column(Subconcepto; Subconcepto)
            {
            }
            column(Descripcion; Descripcion)
            {
            }
            column(Fecha_ult_operacion; "Fecha ult. operacion")
            {
            }
            column(Fecha_compra; "Fecha compra")
            {
            }
            column(Importe_mensual; "Importe mensual")
            {
            }
            column(Caducado; Caducado)
            {
            }
            column(Ahorro_acumulado; "Ahorro acumulado")
            {
            }
        }
    }

}
