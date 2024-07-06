/// <summary>
/// Page Ficha parametros (ID 50106).
/// </summary>
page 50106 "Ficha parametros"
{

    Caption = 'Ficha parametros';
    PageType = Card;
    SourceTable = Parametros;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Banco; Rec.Banco)
                {
                    ToolTip = 'Specifies the value of the Banco field.';
                    ApplicationArea = All;
                }
                field("Fecha inicio permitido"; Rec."Fecha inicio permitido")
                {
                    ToolTip = 'Specifies the value of the Fecha inicio permitido field.';
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

    trigger OnOpenPage()
    begin
        if not Rec.FindFirst() then
            Rec.Insert();
    end;

}
