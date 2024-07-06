/// <summary>
/// Page Busca diferencias (ID 50108).
/// </summary>
page 50108 "Busca diferencias"
{

    ApplicationArea = All;
    Caption = 'Busca diferencias';
    PageType = List;
    SourceTable = Asiento;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Num. Asiento"; Rec."Num. Asiento")
                {
                    ToolTip = 'Specifies the value of the Num. Asiento field.';
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
                field("Importe signo"; Rec."Importe signo")
                {
                    ToolTip = 'Specifies the value of the Importe signo field.';
                    ApplicationArea = All;
                }
                field(Diferencia; GetDiferencia())
                {
                    Caption = 'Diferencia';
                    ToolTip = 'Specifies the value of the Importe signo field.';
                    ApplicationArea = All;
                }

            }
        }
    }

    local procedure GetDiferencia(): Decimal
    begin
        exit(Abs(Rec.Importe) - Abs(Rec."Importe signo"));
    end;

}
