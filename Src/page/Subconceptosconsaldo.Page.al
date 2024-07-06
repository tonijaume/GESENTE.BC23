/// <summary>
/// Page Subconceptos con saldo (ID 50111).
/// </summary>
page 50111 "Subconceptos con saldo"
{

    ApplicationArea = All;
    Caption = 'Subconceptos con saldo';
    PageType = List;
    SourceTable = Subconcepto;
    UsageCategory = Lists;
    Editable = false;

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
                field("Codigo Subconcepto"; Rec."Codigo Subconcepto")
                {
                    ToolTip = 'Specifies the value of the Codigo Subconcepto field.';
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
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

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Importe, '<>0');
    end;
}
