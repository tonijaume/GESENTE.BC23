/// <summary>
/// Page Lista Bancos (ID 50101).
/// </summary>
page 50101 "Lista Bancos"
{
    PageType = List;
    Caption = 'Lista bancos';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Banco;
    AdditionalSearchTerms = 'GESENTE - Banco';
    DeleteAllowed = false;
    SourceTableView = sorting(Orden);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Codigo field.';
                }
                field(Nomnbre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nombre field.';
                }
                field(Bloqueado; Rec.Bloqueado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bloqueado field.';
                }
                field("Ultimo dia"; Rec."Ultimo dia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ultimo dia field.';
                }
                field("Saldo a la fecha"; Rec."Saldo a la fecha")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Saldo a la fecha field.';
                }
                field("Saldo real a 1 mes"; Rec."Saldo real a 1 mes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Saldo real a 1 mes field.';

                    trigger OnDrillDown()
                    var
                        lrSubCon: Record Subconcepto;
                        lfSubCon: Page "Subconceptos con saldo";
                    begin
                        lrSubCon.Reset();
                        lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                        lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today + 1, Rec.GetRangeMax(Rec."Filtro Fecha 2"));
                        lrSubCon.SetFilter("Filtro presupuesto", '%1', 0);

                        Clear(lfSubCon);
                        lfSubCon.SetTableView(lrSubCon);
                        lfSubCon.RunModal();
                    end;
                }
                field("Saldo real a 2 meses"; Rec."Saldo real a 2 meses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Saldo real a 2 meses field.';
                    trigger OnDrillDown()
                    var
                        lrSubCon: Record Subconcepto;
                        lfSubCon: Page "Subconceptos con saldo";
                    begin
                        lrSubCon.Reset();
                        lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                        lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today + 1, Rec.GetRangeMax(Rec."Filtro Fecha 2"));
                        lrSubCon.SetFilter("Filtro presupuesto", '%1', 0);

                        Clear(lfSubCon);
                        lfSubCon.SetTableView(lrSubCon);
                        lfSubCon.RunModal();
                    end;
                }
                field("Saldo a 1 mes"; Rec."Saldo a 1 mes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Saldo a 1 mes field.';
                    trigger OnDrillDown()
                    var
                        lrSubCon: Record Subconcepto;
                        lfSubCon: Page "Subconceptos con saldo";
                    begin
                        lrSubCon.Reset();
                        lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                        lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today + 1, Rec.GetRangeMax(Rec."Filtro Fecha 2"));

                        Clear(lfSubCon);
                        lfSubCon.SetTableView(lrSubCon);
                        lfSubCon.RunModal();
                    end;
                }
                field("Saldo a 2 meses"; Rec."Saldo a 2 meses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Saldo a 2 meses field.';

                    trigger OnDrillDown()
                    var
                        lrSubCon: Record Subconcepto;
                        lfSubCon: Page "Subconceptos con saldo";
                    begin
                        lrSubCon.Reset();
                        lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                        lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today + 1, Rec.GetRangeMax(Rec."Filtro Fecha 3"));

                        Clear(lfSubCon);
                        lfSubCon.SetTableView(lrSubCon);
                        lfSubCon.RunModal();
                    end;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IBAN field.';
                }
                field(Cuenta; Rec.Cuenta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cuenta field.';
                }
                field(BancoCuentafield; BancoCuenta())
                {
                    Caption = 'Banco';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cuenta field.';
                }
                field(OficinaCuentafield; OficinaCuenta())
                {
                    Caption = 'Oficina';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cuenta field.';
                }
                field(DCfield; DCCuenta())
                {
                    Caption = 'Digito control';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cuenta field.';
                }
                field(NumCuentafield; NumCuenta())
                {
                    Caption = 'Número cuenta';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cuenta field.';
                }
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Orden field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DesMarcarDemoDatabase)
            {
                ApplicationArea = All;
                Caption = 'Desmarcar Demo company';
                ToolTip = 'Desmarcar el campo Demo Company';
                trigger OnAction()
                var
                    CompanyInfo: Record "Company Information";
                begin
                    CompanyInfo.FindFirst();
                    CompanyInfo."Demo Company" := false;
                    CompanyInfo.Modify();

                    Message('Proceso finalizado.');
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
            action(ListaObjetos)
            {
                ApplicationArea = All;
                Caption = 'Lista de objetos';
                ToolTip = 'Consultar la lista de objetos para poder ejecutar';
                RunObject = page "Show Object List";

            }
        }

    }
    /// <summary>
    /// BancoCuenta.
    /// </summary>
    /// <returns>Return value of type Text[4].</returns>
    procedure BancoCuenta(): Text[4]
    begin
        if Rec.Cuenta <> '' then
            exit(CopyStr(Rec.Cuenta, 1, 4));
    end;

    /// <summary>
    /// OficinaCuenta.
    /// </summary>
    /// <returns>Return value of type Text[4].</returns>
    procedure OficinaCuenta(): Text[4]
    begin
        if Rec.Cuenta <> '' then
            exit(CopyStr(Rec.Cuenta, 5, 4));
    end;

    /// <summary>
    /// DCCuenta.
    /// </summary>
    /// <returns>Return value of type Text[2].</returns>
    procedure DCCuenta(): Text[2]
    begin
        if Rec.Cuenta <> '' then
            exit(CopyStr(Rec.Cuenta, 9, 2));
    end;

    /// <summary>
    /// NumCuenta.
    /// </summary>
    /// <returns>Return value of type Text[10].</returns>
    procedure NumCuenta(): Text[10]
    begin
        if Rec.Cuenta <> '' then
            exit(CopyStr(Rec.Cuenta, 11, 10));
    end;

    trigger OnOpenPage()
    var
        wDia: Date;
    begin
        wDia := Today;

        Rec.SetFilter("Filtro Fecha", '..%1', wDia);

        wDia := DMY2Date(5, Date2DMY(Today, 2), Date2DMY(Today, 3));

        wDia := CalcDate('<+1M>', wDia);

        Rec.SetFilter("Filtro Fecha 2", '..%1', wDia);

        wDia := CalcDate('<+1M>', wDia);

        Rec.SetFilter("Filtro Fecha 3", '..%1', wDia);

        Rec.SetRange(Bloqueado, false);
    end;
}
