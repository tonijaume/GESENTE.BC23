/// <summary>
/// Page Ahorros presupuestados (ID 50123).
/// </summary>
page 50123 "Ahorros presupuestados"
{

    ApplicationArea = All;
    Caption = 'Ahorros presupuestados';
    PageType = List;
    SourceTable = "Presupuesto compra";
    UsageCategory = Lists;
    RefreshOnActivate = true;
    SourceTableView = where("Tipo presupuesto" = const(Ahorro));

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
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field(Concepto; Rec.Concepto)
                {
                    ToolTip = 'Specifies the value of the Concepto field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field(Subconcepto; Rec.Subconcepto)
                {
                    ToolTip = 'Specifies the value of the Subconcepto field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Tipo presupuesto"; Rec."Tipo presupuesto")
                {
                    ToolTip = 'Specifies the value of the Tipo presupuesto field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Precio compra"; Rec."Precio compra")
                {
                    ToolTip = 'Specifies the value of the Precio compra field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Fecha compra"; Rec."Fecha compra")
                {
                    ToolTip = 'Specifies the value of the Fecha compra field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Importe mensual"; Rec."Importe mensual")
                {
                    ToolTip = 'Specifies the value of the Importe mensual field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Importe objetivo"; Rec."Importe objetivo")
                {
                    ToolTip = 'Specifies the value of the Importe objetivo field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Ahorro acumulado"; Rec."Ahorro acumulado")
                {
                    ToolTip = 'Specifies the value of the Ahorro acumulado field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Meses ahorrados (Real)"; Rec."Meses ahorrados (Real)")
                {
                    ToolTip = 'Specifies the value of the Meses ahorrados (Real) field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field(MesesCalculados; Rec.CalculoMeses())
                {
                    Caption = 'Meses de ahorro';
                    ToolTip = 'Specifies the value of the Meses ahorrados (Real) field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
                field("Objetivo alcanzado"; Rec."Objetivo alcanzado")
                {
                    ToolTip = 'Specifies the value of the Objetivo alcanzado field.';
                    ApplicationArea = All;
                }
                field(Caducado; Rec.Caducado)
                {
                    ToolTip = 'Specifies the value of the Caducado field.';
                    ApplicationArea = All;
                }
                field("Fecha ult. operacion"; Rec."Fecha ult. operacion")
                {
                    ToolTip = 'Specifies the value of the Fecha ult. operacion field.';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = wObjetivoAlcanzado;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(HistoricoCompras)
            {
                ApplicationArea = All;
                Caption = 'Histórico de compras';
                ToolTip = 'Ver la lista de compras';
                Image = PostedOrder;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Lista Historico compras";
                RunPageLink = "ID Presupuesto" = field(ID);
            }
        }
    }

    var
        wObjetivoAlcanzado: Boolean;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Caducado, false);
    end;

    trigger OnAfterGetRecord()
    begin
        wObjetivoAlcanzado := (Rec."Ahorro acumulado" >= Rec."Importe objetivo") and (Rec."Importe objetivo" <> 0);
    end;
}
