/// <summary>
/// Page Lista conceptos (ID 50100).
/// </summary>
page 50100 "Lista conceptos"
{
    PageType = List;
    Caption = 'Lista conceptos';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Concepto;
    PopulateAllFields = true;
    AdditionalSearchTerms = 'GESENTE - Conceptos';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo field.';

                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descripción field.';
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

    actions
    {
        area(Navigation)
        {
            action(Subconceptos)
            {
                Caption = 'Subconceptos relacionados';
                ToolTip = 'Acceso a los subconceptos relacionados con el concepto seleccionado';
                ApplicationArea = All;
                RunObject = page "Lista subconceptos";
                RunPageLink = Concepto = field(Codigo);
            }
        }
    }
}