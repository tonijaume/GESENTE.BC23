page 50125 "Conv Texto concepto banco"
{
    ApplicationArea = All;
    Caption = 'Conversion Texto concepto banco';
    PageType = List;
    SourceTable = "Conv. texto concepto banco";
    UsageCategory = Administration;
    PopulateAllFields = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Banco; Rec.Banco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banco field.';
                }
                field("Texto concepto"; Rec."Texto concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto concepto field.';
                }
                field(Concepto; Rec.Concepto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Concepto field.';
                }
                field(Subconcepto; Rec.Subconcepto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subconcepto field.';
                }
                field(Empresa; Rec.Empresa)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Empresa field.';
                }

            }
        }
    }
}
