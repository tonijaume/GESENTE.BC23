table 50108 "Conv. texto concepto banco"
{
    Caption = 'Conversión texto concepto banco';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        field(2; Banco; Code[20])
        {
            Caption = 'Banco';
            DataClassification = CustomerContent;
            TableRelation = Banco.Codigo where(Bloqueado = const(false));
        }
        field(3; "Texto concepto"; Text[80])
        {
            Caption = 'Texto concepto';
            DataClassification = CustomerContent;
        }
        field(4; Concepto; Code[10])
        {
            Caption = 'Concepto';
            DataClassification = CustomerContent;
            TableRelation = Concepto.Codigo where(Bloqueado = const(false));

            trigger OnValidate()
            begin
                ComprobarConcepto();
            end;
        }
        field(5; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            DataClassification = CustomerContent;
            TableRelation = Subconcepto."Codigo Subconcepto" where(Bloqueado = const(false));

            trigger OnValidate()
            begin
                ComprobarConcepto();
            end;
        }
        field(6; Empresa; Code[10])
        {
            Caption = 'Empresa';
            DataClassification = CustomerContent;
            TableRelation = Empresa.Codigo;
        }

    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        rConvConcepto: Record "Conv. texto concepto banco";
    begin
        if rConvConcepto.FindLast() then
            ID := rConvConcepto.ID + 1
        else
            ID := 1;
    end;

    local procedure ComprobarConcepto()
    var
        rSubconcepto: Record Subconcepto;
        SubconceptoNoConceptoErr: Label 'Este subconcepto no está dentro del concepto %1', Comment = '%1 es el codigo de concepto';
    begin
        if Subconcepto = '' then
            exit;
        if Concepto = '' then begin
            rSubconcepto.SetRange("Codigo Subconcepto", Subconcepto);
            if rSubconcepto.FindFirst() then
                Concepto := rSubconcepto.Concepto;
        end
        else
            if not rSubconcepto.Get(Concepto, Subconcepto) then
                Error(SubconceptoNoConceptoErr, Concepto);
    end;
}
