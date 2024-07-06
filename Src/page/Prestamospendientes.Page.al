/// <summary>
/// Page Prestamos pendientes (ID 50112).
/// </summary>
page 50112 "Prestamos pendientes"
{

    ApplicationArea = All;
    Caption = 'Prestamos pendientes';
    PageType = List;
    SourceTable = "Prestamos pendientes";
    UsageCategory = Lists;
    SourceTableView = sorting(Fecha) where(Tipo = const(Prestamo));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                    ApplicationArea = All;
                }
                field(Codigo; Rec.Codigo)
                {
                    ToolTip = 'Specifies the value of the Codigo field.';
                    ApplicationArea = All;
                }
                field(Tipo; Rec.Tipo)
                {
                    ToolTip = 'Specifies the value of the Tipo field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
                    ApplicationArea = All;
                }
                field("Descripcion 2"; Rec."Descripcion 2")
                {
                    ToolTip = 'Specifies the value of the Descripcion 2 field.';
                    ApplicationArea = All;
                }
            }
            part(Devoluciones; "Devoluciones prestamo")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Acabado, false);
    end;
}
