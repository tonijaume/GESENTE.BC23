/// <summary>
/// Page Recibos domiciliados (ID 50109).
/// </summary>
page 50109 "Recibos domiciliados"
{

    ApplicationArea = All;
    Caption = 'Recibos domiciliados';
    PageType = List;
    SourceTable = "Recibo domiciliado";
    UsageCategory = Lists;

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
                field(Empresa; Rec.Empresa)
                {
                    ToolTip = 'Specifies the value of the Empresa field.';
                    ApplicationArea = All;
                }
                field("Fecha inicial"; Rec."Fecha inicial")
                {
                    ToolTip = 'Specifies the value of the Fecha inicial field.';
                    ApplicationArea = All;
                }
                field(Periodicidad; Rec.Periodicidad)
                {
                    ToolTip = 'Specifies the value of the Periodicidad field.';
                    ApplicationArea = All;
                }
                field(Importe; Rec.Importe)
                {
                    ToolTip = 'Specifies the value of the Importe field.';
                    ApplicationArea = All;
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ToolTip = 'Specifies the value of the Observaciones field.';
                    ApplicationArea = All;
                }
                field("Proximo recibo sin generar"; Rec."Proximo recibo sin generar")
                {
                    ToolTip = 'Specifies the value of the Proximo recibo sin generar field.';
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AplicarRecibo)
            {
                ApplicationArea = All;
                ToolTip = 'Crear los asientos de un año para un recibo';
                Caption = 'Aplicar 1 recibo';
                trigger OnAction()
                begin
                    Rec.AplicaUnRecibo(true, 0D);
                end;
            }
            action(AplicarMasiva)
            {
                ApplicationArea = All;
                ToolTip = 'Crear los asientos de un año para todos los recibos';
                Caption = 'Aplicación masiva';
                trigger OnAction()
                begin
                    AplicacionMasiva();
                end;
            }

        }
    }
    local procedure AplicacionMasiva()
    var
        CrearMasivoConf: Label 'Desea crear los recibos para todos los conceptos de la ventana.';
        ProgresoProcesoMsg: Label 'CREANDO RECIBOS\\@1@@@@@@@@@@@@';
        confmanagement: Codeunit "Confirm Management";
        lrRecibo: Record "Recibo domiciliado";
        lwFechaFinal: Date;
        wVentana: Dialog;
        wActual: Integer;
        wTotal: Integer;
    begin
        if not confmanagement.GetResponseOrDefault(CrearMasivoConf, false) then
            exit;

        lrRecibo.Copy(Rec);
        if lrRecibo.FindSet() then begin

            //  Pedimos la fecha de finalizacion de los recibos
            lwFechaFinal := DMY2Date(31, 12, Date2DMY(Today, 3) + 1);
            if lwFechaFinal = 0D then
                exit;

            //  Ventana de seguimiento
            wVentana.Open(ProgresoProcesoMsg);
            wActual := 0;
            wTotal := lrRecibo.Count;
            repeat
                wActual += 1;
                wVentana.Update(1, Round(wActual / wTotal * 10000, 1));

                Rec.AplicaUnRecibo(false, lwFechaFinal);
            until lrRecibo.Next() = 0;
            wVentana.Close();
        end;
    end;
}
