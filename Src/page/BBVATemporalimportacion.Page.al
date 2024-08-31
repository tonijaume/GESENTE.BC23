page 50121 "BBVA Temporal importacion"
{
    ApplicationArea = All;
    Caption = 'BBVA Temporal importacion';
    PageType = List;
    SourceTable = "Banco Temporal importacion";
    SourceTableView = sorting("Fecha valor") order(descending) where(Banco = const('BBVA'));
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
                field(Movimiento; Rec.Movimiento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Movimiento field.';
                    Editable = false;
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
                Caption = 'Importar Excel';
                ShortcutKey = 'Ctrl + I';
                ToolTip = 'Importar movimientos desde el Excel descargado del BBVA, la hoja debe llamarse Informe BBVA';

                trigger OnAction()
                var
                    codExcelBbva: Codeunit "Gestion Excel Bancos";
                    CargarExcelQst: Label 'Cargar movimientos desde el  fichero Excel';
                begin
                    if not Confirm(CargarExcelQst) then
                        exit;
                    codExcelBbva.LeerFicheroBBVA();

                    CurrPage.Update(false);
                end;
            }
            action(ProcesarLinea)
            {
                ApplicationArea = All;
                Caption = 'Procesar linea';
                ShortcutKey = 'Ctrl + P';
                ToolTip = 'Convierte la linea sobre la que estamos posicionados en un asiento de GesEnte';

                trigger OnAction()
                var
                    codExcelBbva: Codeunit "Gestion Excel Bancos";
                begin
                    codExcelBbva.ProcesarRegistro(Rec, true);
                end;
            }
        }
        area(Navigation)
        {
            action(ConversionConcepto)
            {
                ApplicationArea = All;
                Caption = 'Conversiones concepto';
                ToolTip = 'Definir las conversiones de texto concepto al subconcepto interno';
                RunObject = page "Conv Texto concepto banco";
                //RunPageLink = Banco = field(Banco);
            }
        }
    }
}
