/// <summary>
/// Page BBVA Temporal importacion (ID 50121).
/// </summary>
page 50128 "Santander Temporal importacion"
{
    ApplicationArea = All;
    Caption = 'Santander Temporal importacion';
    PageType = List;
    SourceTable = "Banco Temporal importacion";
    SourceTableView = sorting("Fecha valor") order(descending) where(Banco = const('SANTANDER'));
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Fecha valor"; Rec."Fecha valor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fecha valor field.';
                    Editable = false;
                }
                field(TextoConcepto; Rec."Texto concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Texto Concepto field.';
                    Editable = true;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Importe field.';
                    Editable = false;
                }
                field(Disponible; Rec.Disponible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disponible field.';
                    Editable = false;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Observaciones field.';
                    Editable = true;
                }
                field(Concepto; Rec.Concepto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Concepto field.';
                }
                field(Subconcepto; Rec.Subconcepto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SubConcepto field.';
                }
                field(Empresa; Rec.Empresa)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Empresa field.';
                }
                field(Tarjeta; Rec.Tarjeta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tarjeta field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(importar)
            {
                ApplicationArea = All;
                Image = ImportExcel;
                Caption = 'Importar Excel';
                ShortcutKey = 'Ctrl + I';
                ToolTip = 'Importar movimientos desde el Excel descargado del Santander, la hoja debe llamarse Informe Santander';

                trigger OnAction()
                var
                    codExcelBancos: Codeunit "Gestion Excel Bancos";
                    CargarExcelQst: Label 'Cargar movimientos desde el  fichero Excel';
                begin
                    if not Confirm(CargarExcelQst) then
                        exit;
                    codExcelBancos.LeerFicheroSantander();

                    CurrPage.Update(false);
                end;
            }
            action(ProcesarLinea)
            {
                ApplicationArea = All;
                Image = Post;
                Caption = 'Procesar linea';
                ShortcutKey = 'Ctrl + P';
                ToolTip = 'Convierte la linea sobre la que estamos posicionados en un asiento de GesEnte';

                trigger OnAction()
                var
                    codExcelBancos: Codeunit "Gestion Excel Bancos";
                begin
                    codExcelBancos.ProcesarRegistro(Rec, true);
                end;
            }
        }
        area(Navigation)
        {
            action(ConversionConcepto)
            {
                ApplicationArea = All;
                Image = UnitConversions;
                Caption = 'Conversiones concepto';
                ToolTip = 'Definir las conversiones de texto concepto al subconcepto interno';
                RunObject = page "Conv Texto concepto banco";
                //RunPageLink = Banco = field(Banco);
            }
        }
    }
}
