/// <summary>
/// Page Lista empresas (ID 50103).
/// </summary>
page 50103 "Lista empresas"
{
    Caption = 'Lista empresas';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Empresa;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ToolTip = 'Specifies the value of the Codigo field.';
                    ApplicationArea = All;
                }
                field(Nombre; Rec.Nombre)
                {
                    ToolTip = 'Specifies the value of the Nombre field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field("Concede credito"; Rec."Concede credito")
                {
                    ToolTip = 'Specifies the value of the Concede credito field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                }

            }
        }
    }

}