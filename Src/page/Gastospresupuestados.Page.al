/// <summary>
/// Page Gastos presupuestados (ID 50114).
/// </summary>
page 50114 "Gastos presupuestados"
{

    ApplicationArea = All;
    Caption = 'Gastos presupuestados';
    PageType = List;
    SourceTable = "Presupuesto compra";
    UsageCategory = Lists;
    RefreshOnActivate = true;
    SourceTableView = where("Tipo presupuesto" = const(Presupuesto));

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
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
                    ApplicationArea = All;
                }
                field("Tipo presupuesto"; Rec."Tipo presupuesto")
                {
                    ToolTip = 'Specifies the value of the Tipo presupuesto field.';
                    ApplicationArea = All;
                }
                field("Precio compra"; Rec."Precio compra")
                {
                    ToolTip = 'Specifies the value of the Precio compra field.';
                    ApplicationArea = All;
                }
                field("Fecha compra"; Rec."Fecha compra")
                {
                    ToolTip = 'Specifies the value of the Fecha compra field.';
                    ApplicationArea = All;
                }
                field("Importe mensual"; Rec."Importe mensual")
                {
                    ToolTip = 'Specifies the value of the Importe mensual field.';
                    ApplicationArea = All;
                }
                field(ImporteRealMes; Rec.ImporteRealMes())
                {
                    ToolTip = '.';
                    ApplicationArea = All;
                    Caption = 'Importe real mes actual';

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
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GenerarPresupuesto)
            {
                Caption = 'Generar Presupuesto';
                ApplicationArea = All;
                ToolTip = '.';
                Image = LedgerBudget;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    cPresup: Codeunit "Gestionar compra presupuestada";
                begin
                    cPresup.ProcesarPresupuesto(Rec);
                end;

            }
            action(VerPresupuesto)
            {
                ApplicationArea = All;
                Caption = 'Ver presupuesto';
                ToolTip = 'Ver el detalle del presupuesto';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Comparar presupuesto mensual";
            }
        }
    }
}