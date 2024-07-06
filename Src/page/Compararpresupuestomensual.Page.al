/// <summary>
/// Page Comparar presupuesto mensual (ID 50116).
/// </summary>
page 50116 "Comparar presupuesto mensual"
{

    ApplicationArea = All;
    Caption = 'Comparar presupuesto mensual';
    PageType = List;
    SourceTable = Subconcepto;
    UsageCategory = ReportsAndAnalysis;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field("Importe presupuestado"; Rec."Importe presupuestado")
                {
                    ToolTip = 'Specifies the value of the Importe presupuestado field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        wFechaInicio: Date;
        wFechaFinal: Date;
    begin
        wFechaInicio := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3));
        wFechaFinal := CalcDate('<+1M-1D>', wFechaInicio);

        Rec.SetRange("Filtro fecha", wFechaInicio, wFechaFinal);
        Rec.SetFilter(Importe, '<>%1', 0);
        Rec.SetFilter("Importe presupuestado", '<>%1', 0);
    end;
}
