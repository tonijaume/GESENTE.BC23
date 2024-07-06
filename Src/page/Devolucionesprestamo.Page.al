/// <summary>
/// Page Devoluciones prestamo (ID 50113).
/// </summary>
page 50113 "Devoluciones prestamo"
{

    Caption = 'Devoluciones prestamo';
    PageType = ListPart;
    SourceTable = "Prestamos pendientes";
    PopulateAllFields = true;
    DelayedInsert = true;
    SourceTableView = sorting(Codigo, Tipo) where(Tipo = const(Devolucion));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                    ApplicationArea = All;
                }
                field(Codigo; Rec.Codigo)
                {
                    ToolTip = 'Specifies the value of the Codigo field.';
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
                    ApplicationArea = All;
                }
                field("Descripcion 2"; Rec."Descripcion 2")
                {
                    ToolTip = 'Specifies the value of the Descripcion 2 field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
