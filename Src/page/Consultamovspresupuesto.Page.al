/// <summary>
/// Page Consulta movs. presupuesto (ID 50117).
/// </summary>
page 50117 "Consulta movs. presupuesto"
{

    ApplicationArea = All;
    Caption = 'Consulta movs. presupuesto';
    PageType = List;
    SourceTable = "Mov. Presupuesto compra";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field("Fecha creacion"; Rec."Fecha creacion")
                {
                    ToolTip = 'Specifies the value of the Fecha creacion field.';
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
