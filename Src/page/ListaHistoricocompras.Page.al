/// <summary>
/// Page Lista Historico compras (ID 50120).
/// </summary>
page 50120 "Lista Historico compras"
{

    ApplicationArea = All;
    Caption = 'Lista Historico compras';
    PageType = List;
    SourceTable = "Historico compras";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

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
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
                    ApplicationArea = All;
                }
                field("Precio compra"; Rec."Precio compra")
                {
                    ToolTip = 'Specifies the value of the Precio compra field.';
                    ApplicationArea = All;
                }
                field(Concepto; Rec.Concepto)
                {
                    ToolTip = 'Specifies the value of the Concepto field.';
                    ApplicationArea = All;
                }
                field(Subconcepto; Rec.Subconcepto)
                {
                    ToolTip = 'Specifies the value of the Subconcepto field.';
                    ApplicationArea = All;
                }
                field("ID Presupuesto"; Rec."ID Presupuesto")
                {
                    ToolTip = 'Specifies the value of the ID Presupuesto field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
