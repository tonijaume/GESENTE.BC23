/// <summary>
/// Page Saldo diario (ID 50107).
/// </summary>
page 50107 "Saldo diario"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    LinksAllowed = false;
    SourceTable = Date;
    SourceTableView = sorting("Period Type", "Period Start") where("Period Type" = const(Date));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Dia; Rec."Period Start")
                {
                    ApplicationArea = All;
                    Caption = 'Dia';
                    ToolTip = 'Fecha del saldo';
                }
                field(fieldSaldoDiario; SaldoDiario())
                {
                    ApplicationArea = All;
                    ToolTip = 'Saldo hasta el dia';
                    Caption = 'Saldo diario';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Period Start", '>=%1', Today - 365);
    end;

    /// <summary>
    /// SaldoDiario. 
    /// </summary>
    /// <returns>Suma de los movimientos.</returns>
    procedure SaldoDiario(): Decimal
    var
        lrAsi: Record Asiento;
    begin
        lrAsi.Reset();
        lrAsi.SetCurrentKey(Fecha);
        lrAsi.SetFilter(Fecha, '..%1', Rec."Period Start");
        lrAsi.CalcSums("Importe signo");

        exit(lrAsi."Importe signo");
    end;
}