/// <summary>
/// Table "Empresa" (ID 50103).
/// </summary>
table 50103 Empresa
{
    Caption = 'Empresa';
    DataClassification = ToBeClassified;
    LookupPageId = "Lista empresas";

    fields
    {
        field(1; Codigo; Code[10])
        {
            Caption = 'Codigo';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Nombre; Text[100])
        {
            Caption = 'Nombre';
            DataClassification = CustomerContent;
        }
        field(3; Importe; Decimal)
        {
            Caption = 'Importe';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Empresa = field(Codigo), Fecha = field("Filtro fecha")));
        }
        field(4; "Concede credito"; Boolean)
        {
            Caption = 'Concede credito';
            DataClassification = CustomerContent;
        }
        field(5; "Filtro fecha"; Date)
        {
            Caption = 'Filtro fecha';
            FieldClass = FlowFilter;
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
