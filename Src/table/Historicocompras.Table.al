/// <summary>
/// Table Historico compras (ID 50128).
/// </summary>
table 50128 "Historico compras"
{
    Caption = 'Historico compras';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID Presupuesto"; Integer)
        {
            Caption = 'ID Presupuesto';
            DataClassification = SystemMetadata;
        }
        field(2; Concepto; Code[10])
        {
            Caption = 'Concepto';
            DataClassification = CustomerContent;
        }
        field(3; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            DataClassification = CustomerContent;
        }
        field(4; Descripcion; Text[100])
        {
            Caption = 'Descripcion';
            DataClassification = CustomerContent;
        }
        field(5; Fecha; Date)
        {
            Caption = 'Fecha';
            DataClassification = CustomerContent;
        }
        field(6; "Precio compra"; Decimal)
        {
            Caption = 'Precio compra';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "ID Presupuesto")
        {
            Clustered = true;
        }
    }

}
