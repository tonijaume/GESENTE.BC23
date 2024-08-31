page 50127 "Subconceptos Lookup"
{
    ApplicationArea = All;
    Caption = 'Subconceptos Lookup';
    PageType = List;
    SourceTable = Subconcepto;
    UsageCategory = Lists;
    Editable = false;
    SourceTableView = where(Bloqueado = const(false));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Concepto; Rec.Concepto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Concepto field.';
                }
                field("Codigo Subconcepto"; Rec."Codigo Subconcepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo Subconcepto field.';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descripcion field.';
                }
            }
        }
    }
}
