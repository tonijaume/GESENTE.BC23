/// <summary>
/// Page Subconcepto Factbox (ID 50122).
/// </summary>
page 50122 "Subconcepto Factbox"
{

    Caption = 'Subconcepto Factbox';
    PageType = CardPart;
    SourceTable = Subconcepto;
    Editable = false;

    layout
    {
        area(Content)
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

            group(General)
            {
                field("Saldo hoy"; Rec."Saldo hoy")
                {
                    ToolTip = 'Specifies the value of the Saldo hoy field.';
                    ApplicationArea = All;
                }
                field("Saldo mes"; Rec."Saldo mes")
                {
                    ToolTip = 'Specifies the value of the Saldo mes field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        wInicioMes: Date;
        wFinalMes: Date;
    begin
        if wFecha = 0D then
            wFecha := Today;

        wInicioMes := DMY2Date(1, Date2DMY(wFecha, 2), Date2DMY(wFecha, 3));
        wFinalMes := CalcDate('<+1M-1D>', wInicioMes);

        Rec.SetRange("Filtro hoy", Today);
        Rec.SetRange("Filtro mes", wInicioMes, wFinalMes);
    end;

    var
        wFecha: Date;

    /// <summary>
    /// PasarParametros.
    /// </summary>
    /// <param name="pwFechaReferencia">Date.</param>
    procedure PasarParametros(pwFechaReferencia: Date)
    begin
        wFecha := pwFechaReferencia;
    end;

}
