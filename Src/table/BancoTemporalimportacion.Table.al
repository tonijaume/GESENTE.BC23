/// <summary>
/// Table Banco Temporal importacion (ID 50107).
/// </summary>
table 50107 "Banco Temporal importacion"
{
    Caption = 'Banco Temporal importacion';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Fecha valor"; Date)
        {
            Caption = 'Fecha valor';
        }
        field(3; "Texto concepto"; Text[80])
        {
            Caption = 'Texto concepto';
        }
        field(4; Movimiento; Text[80])
        {
            Caption = 'Movimiento';
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Importe';
        }
        field(6; Disponible; Decimal)
        {
            Caption = 'Disponible';
        }
        field(7; Observaciones; Text[250])
        {
            Caption = 'Observaciones';
        }
        field(8; Procesado; Boolean)
        {
            Caption = 'Procesado';
        }
        field(9; "Fecha proceso"; DateTime)
        {
            Caption = 'Fecha proceso';
        }
        field(10; "Usuario proceso"; Text[50])
        {
            Caption = 'Usuario proceso';
        }
        field(11; Concepto; Code[10])
        {
            Caption = 'Concepto';
            TableRelation = Concepto.Codigo where(Bloqueado = const(false));

            trigger OnValidate()
            begin
                ComprobarConcepto();
            end;
        }
        field(12; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            TableRelation = Subconcepto."Codigo Subconcepto" where(Bloqueado = const(false));

            trigger OnValidate()
            begin
                ComprobarConcepto();
            end;
        }
        field(13; Banco; Code[10])
        {
            Caption = 'Banco';
            TableRelation = Banco.Codigo where(Bloqueado = const(false));
        }
        field(14; Empresa; Code[10])
        {
            Caption = 'Empresa';
            TableRelation = Empresa.Codigo;
        }
        field(15; Tarjeta; Code[20])
        {
            Caption = 'Tarjeta';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
        key(Proceso; Procesado)
        {

        }
        key(fecha; "Fecha valor")
        {

        }
    }

    trigger OnInsert()
    var
        rBBVA: Record "Banco Temporal importacion";
    begin
        if rBBVA.FindLast() then
            ID := rBBVA.ID + 1
        else
            ID := 1;
    end;

    local procedure ComprobarConcepto()
    var
        rSubconcepto: Record Subconcepto;
        SubconceptoNoConceptoErr: Label 'Este concepto no está dentro del concepto %1', Comment = '%1 es el codigo de concepto';
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
