/// <summary>
/// "Concepto" base para los asientos (ID 50100)
/// </summary>
table 50100 Concepto
{
    DataClassification = CustomerContent;
    LookupPageId = "Lista conceptos";

    fields
    {
        field(1; Codigo; Code[10])
        {
            Caption = 'Codigo';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Descripcion; Text[100])
        {
            Caption = 'Descripción';
            DataClassification = CustomerContent;
        }

        field(3; Importe; Decimal)
        {
            Caption = 'Importe';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Concepto = field(Codigo)));
        }

        field(4; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Codigo)
        {
            Clustered = true;
        }
    }
}