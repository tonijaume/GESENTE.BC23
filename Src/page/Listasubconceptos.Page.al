/// <summary>
/// Page Lista subconceptos (ID 50104).
/// </summary>
page 50104 "Lista subconceptos"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Subconcepto;
    Caption = 'Lista subconceptos';
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Concepto; Rec.Concepto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Concepto field.';
                }
                field(Subconcepto; Rec."Codigo Subconcepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo Subconcepto field.';
                }
                field("Tipo entrada"; Rec."Tipo entrada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tipo entrada field.';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descripcion field.';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Importe field.';
                }
                field(Bloqueado; Rec.Bloqueado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bloqueado field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Bloqueado, false);
    end;
}