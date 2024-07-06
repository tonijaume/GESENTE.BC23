/// <summary>
/// Table Parametros (ID 50106).
/// </summary>
table 50106 Parametros
{
    Caption = 'Parametros';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Codigo; Code[10])
        {
            Caption = 'Codigo';
            DataClassification = SystemMetadata;
        }
        field(2; Banco; Code[10])
        {
            Caption = 'Banco';
            TableRelation = Banco;
            DataClassification = CustomerContent;
        }
        field(3; "Serie Medios"; Code[10])
        {
            Caption = 'Serie Medios';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(4; "Fecha inicio permitido"; Date)
        {
            Caption = 'Fecha inicio permitido';
            DataClassification = ToBeClassified;
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
