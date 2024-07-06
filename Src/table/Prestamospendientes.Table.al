/// <summary>
/// Table Prestamos pendientes (ID 50124).
/// </summary>
table 50124 "Prestamos pendientes"
{
    Caption = 'Prestamos pendientes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        field(2; Fecha; Date)
        {
            Caption = 'Fecha';
            DataClassification = CustomerContent;
        }
        field(3; Descripcion; Text[100])
        {
            Caption = 'Descripcion';
            DataClassification = CustomerContent;
        }
        field(4; "Descripcion 2"; Text[50])
        {
            Caption = 'Descripcion 2';
            DataClassification = CustomerContent;
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
        }
        field(6; Tipo; Enum TipoMovimientoPrestamo)
        {
            Caption = 'Tipo';
            DataClassification = CustomerContent;
        }
        field(7; Codigo; Code[20])
        {
            Caption = 'Codigo';
            DataClassification = CustomerContent;
        }
        field(8; Devoluciones; Decimal)
        {
            Caption = 'Devoluciones';
            FieldClass = FlowField;
            CalcFormula = - sum("Prestamos pendientes".Importe where(Codigo = field(Codigo), Tipo = const(Devolucion)));
            Editable = false;
        }
        field(9; Acabado; Boolean)
        {
            Caption = 'Acabado';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
        key(Key2; Codigo, Tipo)
        {
            SumIndexFields = Importe;
        }
        key(Key3; Fecha)
        {

        }
    }

}
