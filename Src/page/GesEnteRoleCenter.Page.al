/// <summary>
/// Page GesEnte Role Center (ID 50149).
/// </summary>
page 50115 "GesEnte Role Center"
{
    PageType = RoleCenter;
    Caption = 'GesEnte';

    layout
    {
        area(RoleCenter)
        {

            part(Activities; "GesEnte Activities")
            {
                ApplicationArea = Basic, Suite;
            }

            part("Help And Chart Wrapper"; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {

        }
        area(Processing)
        {
            group(New)
            {
                action("GesEnte.Asientos")
                {
                    RunPageMode = Edit;
                    Caption = 'Asientos';
                    ToolTip = 'Consulta de los movimientos';
                    RunObject = page "Lista asientos";
                    Image = DataEntry;
                    ApplicationArea = Basic, Suite;
                }

                action("GesEnte.Recibos")
                {
                    RunPageMode = Edit;
                    Caption = 'Recibos domiciliados';
                    ToolTip = 'Consulta de los recibos domicialiados';
                    RunObject = page "Recibos domiciliados";
                    Image = DataEntry;
                    ApplicationArea = Basic, Suite;
                }

                action("GesEnte.EntradaTickets")
                {
                    RunPageMode = Edit;
                    Caption = 'Entrada tickets tarjeta';
                    ToolTip = 'Entrar los tickets de tarjeta de crédito';
                    RunObject = page "Entrada tickets tarjetas";
                    Image = DataEntry;
                    ApplicationArea = Basic, Suite;
                }
                action("GesEnte.PrestamosPendientes")
                {
                    RunPageMode = Edit;
                    Caption = 'Prestamos pendientes';
                    ToolTip = 'Consultar los prestamos pendientes';
                    RunObject = page "Prestamos pendientes";
                    Image = Loaners;
                    ApplicationArea = Basic, Suite;
                }

                action("GesEnte.GastosPresupuestados")
                {
                    RunPageMode = View;
                    Caption = 'Gastos presupuestados';
                    ToolTip = 'Consulta de los Gastos presupuestos';
                    RunObject = page "Gastos presupuestados";
                    Image = LedgerBudget;
                    ApplicationArea = Basic, Suite;
                }
                action("GesEnte.AhorrosPresupuestados")
                {
                    RunPageMode = View;
                    Caption = 'Ahorros presupuestados';
                    ToolTip = 'Consulta de los ahorros a largo plazo';
                    RunObject = page "Ahorros presupuestados";
                    Image = LedgerBudget;
                    ApplicationArea = Basic, Suite;
                }
            }
            // group("AppNameSomeProcess Group")
            // {
            //     action("AppNameSomeProcess")
            //     {
            //         Caption = 'AppNameSomeProcess';
            //         ToolTip = 'AppNameSomeProcess description';
            //         Image = Process;
            //         RunObject = Codeunit "AppNameSomeProcess";
            //         ApplicationArea = Basic, Suite;
            //     }
            // }
            // group("AppName Reports")
            // {
            //     action("AppNameSomeReport")
            //     {
            //         Caption = 'AppNameSomeReport';
            //         ToolTip = 'AppNameSomeReport description';
            //         Image = Report;
            //         RunObject = report "AppNameSomeReport";
            //         ApplicationArea = Basic, Suite;
            //     }
            // }
        }
        area(Reporting)
        {
            action("GesEnte.SaldoDiario")
            {
                RunPageMode = View;
                Caption = 'Saldo diario general';
                ToolTip = 'Consulta del saldo de todos los bancos. Por día.';
                RunObject = page "Saldo diario";
                Image = DataEntry;
                ApplicationArea = Basic, Suite;
            }

            action("GesEnte.SaldoMensual")
            {
                RunPageMode = View;
                Caption = 'Saldo mensual general';
                ToolTip = 'Consulta del saldo de todos los bancos. Por mes.';
                RunObject = page "Saldo mensual";
                Image = DataEntry;
                ApplicationArea = Basic, Suite;
            }

        }
        area(Embedding)
        {
            //     action("AppNameMasterData List")
            //     {
            //         RunObject = page "AppNameMasterData List";
            //         ApplicationArea = Basic, Suite;
            //     }

            action("GesEnte.Bancos")
            {
                RunPageMode = Edit;
                Caption = 'Bancos';
                ToolTip = 'Cuentas bancarias y fondo de inversión de la Ges-Familia';
                Image = New;
                RunObject = page "Lista Bancos";
                ApplicationArea = Basic, Suite;
            }
            action("GesEnte.Conceptos")
            {
                RunPageMode = Edit;
                Caption = 'Conceptos';
                ToolTip = 'Conceptos básicos para los asientos';
                RunObject = page "Lista conceptos";
                Image = New;
                ApplicationArea = Basic, Suite;
            }

            action("GesEnte.SubConceptos")
            {
                RunPageMode = Edit;
                Caption = 'Subconceptos';
                ToolTip = 'Detalle de subconceptos para los asientos';
                RunObject = page "Lista subconceptos";
                Image = New;
                ApplicationArea = Basic, Suite;
            }

            action("GesEnte.Empresas")
            {
                RunPageMode = Edit;
                Caption = 'Empresas';
                ToolTip = 'Add some tooltip here';
                Image = New;
                RunObject = page "Lista empresas";
                ApplicationArea = Basic, Suite;
            }

            action("GesEnte.Tarjetas")
            {
                RunPageMode = Edit;
                Caption = 'Tarjetas de credito/debito';
                ToolTip = 'Add some tooltip here';
                Image = New;
                RunObject = page "Lista Tarjetas";
                ApplicationArea = Basic, Suite;
            }
        }
        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;

                action("GesEnte.Parametros")
                {
                    Caption = 'Parametros';
                    ToolTip = 'Configura GesEnte';
                    RunObject = page "Ficha parametros";
                    ApplicationArea = Basic, Suite;

                }

                action("Assisted Setup")
                {
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    RunObject = page "Assisted Setup";
                    ApplicationArea = Basic, Suite;
                }
                // action("Manual Setup")
                // {
                //     ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                //     RunObject = Page "Business Setup";
                //     ApplicationArea = Basic, Suite;
                // }
                action("Service Connections")
                {
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    RunObject = page "Service Connections";
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Importaciones)
            {
                action(ImportarBBVA)
                {
                    ApplicationArea = All;
                    Caption = 'Importar Excel BBVA';
                    RunObject = page "BBVA Temporal importacion";
                }
                action(ImportarSantander)
                {
                    ApplicationArea = All;
                    Caption = 'Importar Excel Santander';
                    RunObject = page "Santander Temporal importacion";
                }
            }
        }
    }

}