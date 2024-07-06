/// <summary>
/// Table Recibo domiciliado (ID 50116).
/// </summary>
table 50116 "Recibo domiciliado"
{
    Caption = 'Recibo domiciliado';
    DataClassification = ToBeClassified;
    LookupPageId = "Recibos domiciliados";
    DrillDownPageId = "Recibos domiciliados";

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; Banco; Code[10])
        {
            Caption = 'Banco';
            TableRelation = Banco;
            DataClassification = CustomerContent;
        }
        field(3; Concepto; Code[10])
        {
            Caption = 'Concepto';
            TableRelation = Concepto;
            DataClassification = CustomerContent;
        }
        field(4; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            TableRelation = Subconcepto."Codigo Subconcepto" where(Concepto = field(Concepto));
            DataClassification = CustomerContent;
        }
        field(5; Empresa; Code[10])
        {
            Caption = 'Empresa';
            TableRelation = Empresa;
            DataClassification = CustomerContent;
        }
        field(6; Periodicidad; DateFormula)
        {
            Caption = 'Periodicidad';
            DataClassification = CustomerContent;
        }
        field(7; Importe; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
        }
        field(8; "Proximo recibo sin generar"; Date)
        {
            Caption = 'Proximo recibo sin generar';
            DataClassification = ToBeClassified;
        }
        field(9; "Fecha inicial"; Date)
        {
            Caption = 'Fecha inicial';
            DataClassification = ToBeClassified;
        }
        field(10; Observaciones; Text[100])
        {
            Caption = 'Observaciones';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }


    internal procedure AplicaUnRecibo(pwVerbose: Boolean; pwFechaFinal: Date)
    var
        confmanagement: Codeunit "Confirm Management";
        crearrecibosconf: Label 'Desea crear los recibos para todos el concepto actual.';
        lwFechaFinal: Date;
        lrRecibo: Record "Recibo domiciliado";
        lrAsi: Record Asiento;
    begin

        if pwVerbose then begin
            if not confmanagement.GetResponseOrDefault(crearrecibosconf, false) then
                exit;

            //  Pedimos la fecha de finalizacion de los recibos
            lwFechaFinal := DMY2Date(31, 12, Date2DMY(Today, 3) + 1);
            if lwFechaFinal = 0D then
                exit;
        end
        else
            lwFechaFinal := pwFechaFinal;

        lrRecibo := Rec;
        if lrRecibo."Proximo recibo sin generar" = 0D then
            lrRecibo."Proximo recibo sin generar" := lrRecibo."Fecha inicial";

        while lrRecibo."Proximo recibo sin generar" < lwFechaFinal do begin
            lrAsi.Init();
            lrAsi.Insert(true);
            lrAsi.Validate(Banco, lrRecibo.Banco);
            lrAsi.Validate(Fecha, lrRecibo."Proximo recibo sin generar");
            lrAsi.Validate(Concepto, lrRecibo.Concepto);
            lrAsi.Validate(Subconcepto, lrRecibo.Subconcepto);
            lrAsi.Validate("Gasto/Ingreso", lrAsi."Gasto/Ingreso"::Gasto);
            lrAsi.Validate(Importe, lrRecibo.Importe);
            lrAsi.Validate(Empresa, lrRecibo.Empresa);
            lrAsi.Validate(Definitivo, false);
            lrAsi.Validate(Observaciones, lrRecibo.Observaciones);
            lrAsi.Modify(true);

            lrRecibo."Proximo recibo sin generar" := CalcDate(lrRecibo.Periodicidad, lrRecibo."Proximo recibo sin generar");
        end;
        lrRecibo.Modify();

    end;
}
