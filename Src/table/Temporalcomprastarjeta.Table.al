/// <summary>
/// Table Temporal compras tarjeta (ID 50123).
/// </summary>
table 50123 "Temporal compras tarjeta"
{
    Caption = 'Temporal compras tarjeta';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        field(2; "Fecha compra"; Date)
        {
            Caption = 'Fecha compra';
            DataClassification = CustomerContent;
        }
        field(3; Empresa; Code[10])
        {
            Caption = 'Empresa';
            DataClassification = CustomerContent;
            TableRelation = Empresa;
        }
        field(4; Tarjeta; Code[20])
        {
            Caption = 'Tarjeta';
            DataClassification = CustomerContent;
            TableRelation = Tarjeta.Numero where(Bloqueada = const(false));
            trigger OnValidate()
            var
                Tarjeta: Record Tarjeta;
            begin
                Tarjeta.Reset();
                Tarjeta.SetRange(Numero, Rec.Tarjeta);
                Tarjeta.FindFirst();

                Rec.Banco := Tarjeta.Banco;
                Rec."Tarjeta credito" := Tarjeta.Credito;
            end;
        }
        field(5; Banco; Code[10])
        {
            Caption = 'Banco';
            DataClassification = CustomerContent;
            TableRelation = Banco;
        }
        field(6; Observaciones; Text[100])
        {
            Caption = 'Observaciones';
            DataClassification = CustomerContent;
        }
        field(7; Importe; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
        }
        field(8; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            DataClassification = CustomerContent;
            TableRelation = Subconcepto."Codigo Subconcepto" where(Concepto = field(Concepto));
        }
        field(9; "Tarjeta credito"; Boolean)
        {
            Caption = 'Tarjeta credito';
            DataClassification = CustomerContent;
            TableRelation = Tarjeta;
        }
        field(10; Concepto; Code[10])
        {
            Caption = 'Concepto';
            DataClassification = CustomerContent;
            TableRelation = Concepto;
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
        lrTemporal: Record "Temporal compras tarjeta";
    begin
        if lrTemporal.FindLast() then
            ID := lrTemporal.ID + 1
        else
            ID := 1;
    end;

    internal procedure RegistrarTickets()
    var
        lrTarjeta: Record Tarjeta;
        lrAsiento: Record Asiento;
        lrSubconcepto: Record Subconcepto;
    begin
        if Rec.FindSet() then
            repeat
                lrTarjeta.Get(Rec.Banco, Rec.Tarjeta);

                Clear(lrAsiento);
                lrAsiento.Validate(Banco, Rec.Banco);
                //. Los asientos de crédito van a previsión de VISA
                if lrTarjeta.Credito then begin
                    lrAsiento.Validate(Concepto, 'VARIOS');
                    lrAsiento.Validate(Subconcepto, 'PREV. VISA');
                end
                else begin
                    Rec.TestField(Subconcepto);
                    lrSubconcepto.SetRange("Codigo Subconcepto", Subconcepto);
                    lrSubconcepto.FindFirst();

                    lrAsiento.Validate(Concepto, lrSubconcepto.Concepto);
                    lrAsiento.Validate(Subconcepto, lrSubconcepto."Codigo Subconcepto");
                end;

                lrAsiento.Validate(Fecha, "Fecha compra");
                lrAsiento.Validate("Gasto/Ingreso", lrAsiento."Gasto/Ingreso"::Gasto);
                lrAsiento.Validate(Importe, Importe);
                lrAsiento.Validate(Tarjeta, Tarjeta);
                lrAsiento.Validate(Empresa, Empresa);
                lrAsiento.Validate("Fecha entrada", "Fecha compra");
                lrAsiento.Validate(Definitivo, false);
                lrAsiento.Validate(Observaciones, Observaciones);
                lrAsiento.Insert(true);

                lrAsiento.CalculoFechaAsiento();
            until Next() = 0;

        Rec.DeleteAll();

    end;
}
