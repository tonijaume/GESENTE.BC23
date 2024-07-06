/// <summary>
/// Table Mov. Presupuesto compra (ID 50126).
/// </summary>
table 50126 "Mov. Presupuesto compra"
{
    Caption = 'Mov. Presupuesto compra';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "ID Presupuesto"; Integer)
        {
            Caption = 'ID Presupuesto';
            DataClassification = CustomerContent;
        }
        field(3; Fecha; Date)
        {
            Caption = 'Fecha';
            DataClassification = CustomerContent;
        }
        field(4; Importe; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
        }
        field(5; Concepto; Code[10])
        {
            Caption = 'Concepto';
            TableRelation = Concepto;
            DataClassification = CustomerContent;
        }
        field(6; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            TableRelation = Subconcepto."Codigo Subconcepto";
            DataClassification = CustomerContent;
        }
        field(7; "Fecha creacion"; DateTime)
        {
            Caption = 'Fecha creacion';
            Editable = false;
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
            SumIndexFields = Importe;
        }
    }
}
