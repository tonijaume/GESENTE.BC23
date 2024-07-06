/// <summary>
/// Page GesEnte Activities (ID 50119).
/// </summary>
page 50119 "GesEnte Activities"
{

    Caption = 'GesEnte Activities';
    PageType = CardPart;
    SourceTable = "GesEnte Cue";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(CueGroup1)
            {
                //TODO Prueba de TODO
                Caption = 'Día a día';
                field("Temporal Tickets"; Rec."Temporal Tickets")
                {
                    ToolTip = 'Specifies the value of the Temporal Tickets field.';
                    ApplicationArea = All;
                    DrillDownPageId = "Entrada tickets tarjetas";
                }
                field("Asientos Pendientes"; Rec."Asientos Pendientes")
                {
                    ToolTip = 'Specifies the value of the Asientos Pendientes field.';
                    ApplicationArea = All;
                }
            }
            cuegroup(CueGroup2)
            {
                Caption = 'Gastos Presupuestado';
                field("Presupuesto mensual"; Rec."Presupuesto mensual")
                {
                    ToolTip = 'Specifies the value of the Presupuesto mensual field.';
                    DrillDownPageId = "Gastos presupuestados";
                    ApplicationArea = All;
                }
                field("Ahorro activo mensual"; Rec."Ahorro activo mensual")
                {
                    ToolTip = 'Specifies the value of the Ahorro activo mensual field.';
                    DrillDownPageId = "Ahorros presupuestados";
                    ApplicationArea = All;
                }
                field("Ahorro alcanzado"; Rec."Ahorro alcanzado")
                {
                    ToolTip = 'Specifies the value of the Ahorro alcanzado field.';
                    ApplicationArea = All;
                }
                field("Ahorro acumulado"; Rec."Ahorro acumulado")
                {
                    ToolTip = 'Specifies the value of the Ahorro acumulado field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetFilter("Filtro Fecha", '<=%1', WorkDate());

    end;
}
