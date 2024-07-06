/// <summary>
/// Page Lista asientos (ID 50105).
/// </summary>
page 50105 "Lista asientos"
{

    ApplicationArea = All;
    Caption = 'Lista asientos';
    PageType = List;
    SourceTable = Asiento;
    SourceTableView = sorting(Fecha) order(descending);
    UsageCategory = Lists;
    PopulateAllFields = true;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Subconcepto; Rec.Subconcepto)
                {
                    ToolTip = 'Specifies the value of the Subconcepto field.';
                    ApplicationArea = All;
                    Editable = wSubConceptoEditable;
                }
                field(Concepto; Rec.Concepto)
                {
                    ToolTip = 'Specifies the value of the Concepto field.';
                    ApplicationArea = All;
                    Editable = wConceptoEditable;
                }
                field(Fecha; Rec.Fecha)
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                    ApplicationArea = All;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field(Banco; Rec.Banco)
                {
                    ToolTip = 'Specifies the value of the Banco field.';
                    ApplicationArea = All;
                }
                field("Gasto/Ingreso"; Rec."Gasto/Ingreso")
                {
                    ToolTip = 'Specifies the value of the Gasto/Ingreso field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = wEstilo;
                }
                field(Efectivo; Rec.Efectivo)
                {
                    ToolTip = 'Specifies the value of the Efectivo field.';
                    ApplicationArea = All;
                }
                field(Empresa; Rec.Empresa)
                {
                    ToolTip = 'Specifies the value of the Empresa field.';
                    ApplicationArea = All;
                }
                field(Tarjeta; Rec.Tarjeta)
                {
                    ToolTip = 'Specifies the value of the Tarjeta field.';
                    ApplicationArea = All;
                }
                field(Definitivo; Rec.Definitivo)
                {
                    ToolTip = 'Specifies the value of the Definitivo field.';
                    ApplicationArea = All;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Specifies the value of the Observaciones field.';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = wDescripcionStyle;
                }
                field("ID Presupuesto"; Rec."ID Presupuesto")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the ID Presupuesto field.';
                    ApplicationArea = All;
                }
                field("Fecha entrada"; Rec."Fecha entrada")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Fecha entrada field.';
                    ApplicationArea = All;
                }
                field("Hora entrada"; Rec."Hora entrada")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Hora entrada field.';
                    ApplicationArea = All;
                }
                field("Usuario entrada"; Rec."Usuario entrada")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usuario entrada field.';
                    ApplicationArea = All;
                }
                field(Traspaso; Rec.Traspaso)
                {
                    ToolTip = 'Specifies the value of the Traspaso field.';
                    ApplicationArea = All;
                }
                field("Importe signo"; Rec."Importe signo")
                {
                    ToolTip = 'Specifies the value of the Importe signo field.';
                }
                field(Aportacion; Rec.Aportacion)
                {
                    ToolTip = 'Specifies the value of the Aportacion field.', Comment = '%';
                }
                field(NumParticipaciones; Rec.NumParticipaciones)
                {
                    ToolTip = 'Specifies the value of the Num. Participaciones field.', Comment = '%';
                }
                field("Valor unitario"; Rec."Valor unitario")
                {
                    ToolTip = 'Specifies the value of the Valor unitario field.', Comment = '%';
                }
                field(Incremento; Rec.Incremento)
                {
                    ToolTip = 'Specifies the value of the Incremento field.', Comment = '%';
                }
            }
            group(Totales)
            {
                field(ImporteTotal; wImporte)
                {
                    Caption = 'Importe total';
                    ApplicationArea = All;
                    ToolTip = 'Suma de los asientos';
                }
                field(ImporteMarcados; wImporteMarcado)
                {
                    Caption = 'Importe lineas seleccionadas';
                    ApplicationArea = All;
                    ToolTip = 'Suma de los asientos marcados';
                }

            }
        }
        area(FactBoxes)
        {
            part(SBFactBox; "Subconcepto Factbox")
            {
                ApplicationArea = All;
                Caption = 'Resumen subconcepto';
                SubPageLink = Concepto = field(Concepto), "Codigo Subconcepto" = field(Subconcepto);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CambiarConcepto)
            {
                ApplicationArea = All;
                Caption = 'Cambiar concepto';
                ToolTip = 'Cambiar el concepto del asiento seleccionado';
                Image = Task;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortcutKey = 'F11';

                trigger OnAction()
                begin
                    CambiarConceptoAsiento(Rec);
                end;
            }
            action(CambiarConceptoMasivo)
            {
                ApplicationArea = All;
                Caption = 'Cambiar concepto seleccionados';
                ToolTip = 'Cambiar el concepto de todas las lineas seleccionadas';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortcutKey = 'Ctrl+F11';

                trigger OnAction()
                var
                    lrAsiento: Record Asiento;
                begin
                    CurrPage.SetSelectionFilter(lrAsiento);
                    if lrAsiento.FindSet() then
                        repeat
                            CambiarConceptoAsiento(lrAsiento);
                        until lrAsiento.Next() = 0;
                end;
            }

            action(CambiarFecha)
            {
                ApplicationArea = All;
                Caption = 'Cambiar fecha asiento';
                ToolTip = 'Actualizar la fecha de todos los asientos seleccionados';
                Image = Task;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    cgestion: Codeunit "Gestion GESENTE";
                    lrAsiento: Record Asiento;
                begin
                    CurrPage.SetSelectionFilter(lrAsiento);
                    cgestion.CambiarFechaMasivo(lrAsiento);
                end;
            }

            action(CalcularFechaCreditoTarjeta)
            {
                ApplicationArea = All;
                ToolTip = 'Calcular la fecha del asiento en función del crédito de la tarjeta';
                Caption = 'Calcular fecha credito tarjeta';
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.CalculoFechaAsiento();
                end;
            }
        }

        area(Navigation)
        {
            action(Tarjetas)
            {
                ApplicationArea = All;
                Caption = 'Tarjetas';
                ToolTip = 'Consulta de las tarjetas con movimientos pendientes';
                trigger OnAction()
                var
                    cGestion: Codeunit "Gestion GESENTE";
                begin
                    cGestion.VerTarjetas();
                end;
            }
        }
    }

    var
        wImporte: Decimal;
        wConceptoEditable: Boolean;
        wSubConceptoEditable: Boolean;
        wEstilo: Boolean;
        wDescripcionStyle: Boolean;
        wImporteMarcado: Decimal;

    local procedure CambiarConceptoAsiento(lrAsiento: Record Asiento)
    var
        fTabSubcon: Page "Lista subconceptos";
        rSubCon: Record Subconcepto;
        rAsiento: Record Asiento;
    begin
        Clear(fTabSubcon);
        fTabSubcon.LookupMode(true);
        if fTabSubcon.RunModal() <> Action::LookupOK then
            exit;

        fTabSubcon.GetRecord(rSubCon);

        rAsiento := lrAsiento;
        rAsiento.Validate(Concepto, rSubCon.Concepto);
        rAsiento.Validate(Subconcepto, rSubCon."Codigo Subconcepto");
        rAsiento.Modify(true);
    end;

    local procedure CalcularTotales()
    var
        lrAsi: Record Asiento;
        lrAsiMarc: Record Asiento;
    begin
        lrAsi.Copy(Rec);
        wImporte := 0;
        if lrAsi.FindSet() then begin
            lrAsi.CalcSums("Importe signo");
            wImporte := lrAsi."Importe signo";
        end;

        CurrPage.SetSelectionFilter(lrAsiMarc);
        wImporteMarcado := 0;
        if lrAsiMarc.FindSet() then
            repeat
                wImporteMarcado += lrAsiMarc."Importe signo";
            until lrAsiMarc.Next() = 0;
    end;

    trigger OnOpenPage()
    begin
        wConceptoEditable := (Rec.GetFilter(Concepto) = '');
        wSubConceptoEditable := (Rec.GetFilter(Subconcepto) = '');
    end;

    trigger OnAfterGetRecord()
    begin
        wEstilo := not Rec.Definitivo;
        wDescripcionStyle := (Rec."ID Presupuesto" <> 0);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalcularTotales();
        CurrPage.SBFactBox.Page.PasarParametros(Rec.Fecha);
    end;
}
