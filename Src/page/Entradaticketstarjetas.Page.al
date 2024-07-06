/// <summary>
/// Page Entrada tickets tarjetas (ID 50110).
/// </summary>
page 50110 "Entrada tickets tarjetas"
{

    ApplicationArea = All;
    Caption = 'Entrada tickets tarjetas';
    PageType = List;
    SourceTable = "Temporal compras tarjeta";
    UsageCategory = Tasks;
    PopulateAllFields = true;
    RefreshOnActivate = true;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field("Fecha compra"; Rec."Fecha compra")
                {
                    ToolTip = 'Specifies the value of the Fecha compra field.';
                    ApplicationArea = All;
                }
                field(Tarjeta; Rec.Tarjeta)
                {
                    ToolTip = 'Specifies the value of the Tarjeta field.';
                    ApplicationArea = All;
                }
                field(Empresa; Rec.Empresa)
                {
                    ToolTip = 'Specifies the value of the Empresa field.';
                    ApplicationArea = All;
                }
                field(Concepto; Rec.Concepto)
                {
                    ToolTip = 'Specifies the value of the Concepto field.';
                    ApplicationArea = All;
                }
                field(Subconcepto; Rec.Subconcepto)
                {
                    ToolTip = 'Specifies the value of the Subconcepto field.';
                    ApplicationArea = All;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Specifies the value of the Observaciones field.';
                    ApplicationArea = All;
                }
                field(Banco; Rec.Banco)
                {
                    ToolTip = 'Specifies the value of the Banco field.';
                    ApplicationArea = All;
                }
                field("Tarjeta credito"; Rec."Tarjeta credito")
                {
                    ToolTip = 'Specifies the value of the Tarjeta credito field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        confManagement: Codeunit "Confirm Management";
        abandonarticketsMsg: Label 'Deseas abandonar la introduccion de tickets';
        RegistrarTicketsMsg: Label 'Registrar los tickets de la ventana';
    begin
        if Rec.IsEmpty() then
            exit(true);

        if confManagement.GetResponse(RegistrarTicketsMsg, false) then begin
            Commit();

            Rec.RegistrarTickets();
            exit(true);
        end;

        if not Confirm(abandonarticketsMsg) then
            exit(false);
    end;
}
