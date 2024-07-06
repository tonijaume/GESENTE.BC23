/// <summary>
/// Table Tarjeta (ID 50102).
/// </summary>
table 50102 Tarjeta
{
    DataClassification = CustomerContent;
    Caption = 'Tarjeta';
    LookupPageId = "Lista Tarjetas";


    fields
    {
        field(1; Banco; Code[10])
        {
            Caption = 'Banco';
            DataClassification = CustomerContent;
            TableRelation = Banco;
            NotBlank = true;
        }
        field(2; Numero; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero';
            NotBlank = true;
        }
        field(3; Credito; Boolean)
        {
            Caption = 'Credito';
            DataClassification = CustomerContent;
        }
        field(4; "A nombre de"; Code[50])
        {
            Caption = 'A nombre de';
            DataClassification = CustomerContent;
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Importe';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Tarjeta = field(Numero), Fecha = field("Filtro fecha")));
        }
        field(6; "Filtro fecha"; Date)
        {
            Caption = 'Filtro fecha';
            FieldClass = FlowFilter;
        }
        field(7; Caducidad; Code[10])
        {
            Caption = 'Caducidad';
            DataClassification = CustomerContent;
        }
        field(8; Bloqueada; Boolean)
        {
            Caption = 'Bloqueada';
            DataClassification = CustomerContent;
        }
        field(9; "Ultimo dia credito"; Integer)
        {
            Caption = 'Ultimo dia credito';
            DataClassification = CustomerContent;
        }

        field(10; "Fecha asiento"; Enum TipoFechaAsiento)
        {
            Caption = 'Fecha asiento';
            DataClassification = CustomerContent;
        }
        field(11; Observaciones; Text[100])
        {
            Caption = 'Observaciones';
            DataClassification = CustomerContent;
        }
        field(12; Vencimiento; DateFormula)
        {
            Caption = 'Vencimiento';
            DataClassification = CustomerContent;
        }
        field(13; "Movimientos pendientes"; Decimal)
        {
            Caption = 'Movimientos pendientes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Tarjeta = field(Numero), Fecha = field("Filtro fecha"), Definitivo = const(false)));
        }
    }

    keys
    {
        key(PK; Banco, Numero)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Numero, Observaciones, Banco) { }
    }
}