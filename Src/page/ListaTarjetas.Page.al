/// <summary>
/// Page Lista Tarjetas (ID 50118).
/// </summary>
page 50118 "Lista Tarjetas"
{

    ApplicationArea = All;
    Caption = 'Lista Tarjetas';
    PageType = List;
    SourceTable = Tarjeta;
    UsageCategory = Lists;
    SourceTableView = sorting(Banco);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Banco; Rec.Banco)
                {
                    ToolTip = 'Specifies the value of the Banco field.';
                    ApplicationArea = All;
                }
                field(Numero; Rec.Numero)
                {
                    ToolTip = 'Specifies the value of the Numero field.';
                    ApplicationArea = All;
                }
                field(Credito; Rec.Credito)
                {
                    ToolTip = 'Specifies the value of the Credito field.';
                    ApplicationArea = All;
                }
                field("A nombre de"; Rec."A nombre de")
                {
                    ToolTip = 'Specifies the value of the A nombre de field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field("Movimientos pendientes"; Rec."Movimientos pendientes")
                {
                    ToolTip = 'Specifies the value of the Movimientos pendientes field.';
                    ApplicationArea = All;
                }
                field(Caducidad; Rec.Caducidad)
                {
                    ToolTip = 'Specifies the value of the Caducidad field.';
                    ApplicationArea = All;
                }
                field(Bloqueada; Rec.Bloqueada)
                {
                    ToolTip = 'Specifies the value of the Bloqueada field.';
                    ApplicationArea = All;
                }
                field("Ultimo dia credito"; Rec."Ultimo dia credito")
                {
                    ToolTip = 'Specifies the value of the Ultimo dia credito field.';
                    ApplicationArea = All;
                }
                field("Fecha asiento"; Rec."Fecha asiento")
                {
                    ToolTip = 'Specifies the value of the Fecha asiento field.';
                    ApplicationArea = All;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Specifies the value of the Observaciones field.';
                    ApplicationArea = All;
                }
                field(Vencimiento; Rec.Vencimiento)
                {
                    ToolTip = 'Specifies the value of the Vencimiento field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Bloqueada, false);
    end;
}
