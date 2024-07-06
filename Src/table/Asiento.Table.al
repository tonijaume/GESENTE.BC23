/// <summary>
/// Table Asiento (ID 50104).
/// </summary>
table 50104 Asiento
{
    Caption = 'Asiento';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Lista asientos";

    fields
    {
        field(1; "Num. Asiento"; Integer)
        {
            Caption = 'Num. Asiento';
            DataClassification = SystemMetadata;
        }
        field(2; Banco; Code[10])
        {
            Caption = 'Banco';
            TableRelation = Banco;
            DataClassification = CustomerContent;
        }
        field(3; Concepto; Code[10])
        {
            Caption = 'Concepto';
            TableRelation = Concepto;
            DataClassification = CustomerContent;
        }
        field(4; Fecha; Date)
        {
            Caption = 'Fecha';
            DataClassification = CustomerContent;
        }
        field(5; "Gasto/Ingreso"; Enum GastoIngreso)
        {
            Caption = 'Gasto/Ingreso';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Validate(Importe);
            end;
        }
        field(6; Importe; Decimal)
        {
            Caption = 'Importe';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Gasto/Ingreso" = "Gasto/Ingreso"::Gasto then
                    Rec."Importe signo" := -Rec.Importe
                else
                    Rec."Importe signo" := Rec.Importe;
            end;
        }
        field(7; Tarjeta; Code[20])
        {
            Caption = 'Tarjeta';
            TableRelation = Tarjeta.Numero where(Banco = field(Banco));
            DataClassification = EndUserIdentifiableInformation;
            trigger OnValidate()
            begin
                if Rec.Tarjeta <> '' then
                    Rec."Clave tarjeta" := CopyStr(Rec.Tarjeta, 1, 9)
                else
                    Rec."Clave tarjeta" := '';
            end;
        }
        field(8; Empresa; Code[10])
        {
            Caption = 'Empresa';
            TableRelation = Empresa;
            DataClassification = CustomerContent;
        }
        field(9; "Fecha entrada"; Date)
        {
            Caption = 'Fecha entrada';
            DataClassification = SystemMetadata;
        }
        field(10; "Hora entrada"; Time)
        {
            Caption = 'Hora entrada';
            DataClassification = SystemMetadata;
        }
        field(11; "Usuario entrada"; Code[50])
        {
            Caption = 'Usuario entrada';
            DataClassification = SystemMetadata;
        }
        field(12; Subconcepto; Code[10])
        {
            Caption = 'Subconcepto';
            TableRelation = Subconcepto."Codigo Subconcepto" where(Concepto = field(Concepto));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                rSub: Record Subconcepto;
            begin
                if rSub.Get(Rec.Concepto, Rec.Subconcepto) then begin
                    if Rec.Concepto = '' then
                        Rec.Validate(Concepto, rSub.Concepto);
                    Rec."Gasto/Ingreso" := rSub."Tipo entrada";
                end;
            end;

            trigger OnLookup()
            var
                rSub: Record Subconcepto;
            begin
                rSub.Reset();
                if Rec.Concepto <> '' then
                    rSub.SetRange(Concepto, Rec.Concepto);

                if Page.RunModal(0, rSub) = Action::LookupOK then begin
                    Rec.Validate(Concepto, rSub.Concepto);
                    Rec.Validate(Subconcepto, rSub."Codigo Subconcepto");
                end;
            end;
        }
        field(13; "Importe signo"; Decimal)
        {
            Caption = 'Importe signo';
            DataClassification = CustomerContent;
        }
        field(14; Definitivo; Boolean)
        {
            Caption = 'Definitivo';
            DataClassification = CustomerContent;
        }
        field(15; Observaciones; Text[100])
        {
            Caption = 'Observaciones';
            DataClassification = CustomerContent;
        }
        field(16; "Extracto mes"; Boolean)
        {
            Caption = 'Extracto mes';
            DataClassification = CustomerContent;
        }
        field(17; Efectivo; Boolean)
        {
            Caption = 'Efectivo';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                RellenarDatosBasicosErr: Label 'Debe rellenar los datos basicos del asiento antes de marcar efectivo.';
            begin
                if (Rec.Banco = '') or (Rec.Fecha = 0D) or (Rec.Concepto = '') or (Rec.Subconcepto = '') then
                    Error(RellenarDatosBasicosErr);

                if Efectivo then
                    descontar_cajero()
                else
                    devolver_cajero();
            end;
        }
        field(18; "Asiento ligado"; Integer)
        {
            Caption = 'Asiento ligado';
            DataClassification = CustomerContent;
        }
        field(19; Traspaso; Boolean)
        {
            Caption = 'Traspaso';
            DataClassification = CustomerContent;
        }
        field(20; "Clave tarjeta"; Code[10])
        {
            Caption = 'Clave tarjeta';
            DataClassification = CustomerContent;
        }
        field(21; "ID Presupuesto"; Integer)
        {
            Caption = 'ID Presupuesto';
            TableRelation = "Presupuesto compra";
            DataClassification = ToBeClassified;
        }
        field(22; "Aportacion"; Boolean)
        {
            Caption = 'Aportacion';
            DataClassification = CustomerContent;
        }
        field(23; "NumParticipaciones"; Decimal)
        {
            Caption = 'Num. Participaciones';
            DataClassification = CustomerContent;
        }
        field(24; "Valor unitario"; Decimal)
        {
            Caption = 'Valor unitario';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(25; "Incremento"; Boolean)
        {
            Caption = 'Incremento';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Num. Asiento")
        {
            Clustered = true;
        }
        key(key2; Fecha, Banco)
        {
            SumIndexFields = "Importe signo";
        }
        key(key3; Fecha, Banco, Definitivo)
        {
            SumIndexFields = "Importe signo";
        }
        key(key4; Tarjeta, Fecha)
        {
            SumIndexFields = "Importe signo";
        }
        key(key5; Empresa, Fecha)
        {
            SumIndexFields = "Importe signo";
        }

        key(key6; "Gasto/Ingreso", Banco, Fecha, Traspaso)
        {
            SumIndexFields = "Importe signo";
        }
        key(key7; Concepto, Subconcepto, Fecha, Banco, "Gasto/Ingreso", Traspaso, Definitivo)
        {
            SumIndexFields = "Importe signo";
        }
    }

    internal procedure CalculoFechaAsiento()
    var
        lrTarjeta: Record Tarjeta;
        lwDia: Date;
    begin
        if not lrTarjeta.Get(Rec.Banco, Rec.Tarjeta) then
            exit;

        if not lrTarjeta.Credito then begin
            Rec.Fecha := Rec."Fecha entrada";
            Rec.Modify();
            exit;
        end;

        lrTarjeta.TestField(Vencimiento);

        if lrTarjeta."Ultimo dia credito" = 0 then
            Rec.Fecha := CalcDate(lrTarjeta.Vencimiento, Rec."Fecha entrada")
        else begin
            if Date2DMY("Fecha entrada", 1) > lrTarjeta."Ultimo dia credito" then
                lwDia := CalcDate('<+1M>', Rec."Fecha entrada")
            else
                lwDia := Rec."Fecha entrada";

            Rec.Fecha := CalcDate(lrTarjeta.Vencimiento, lwDia);
        end;

        Rec.Modify();
    end;

    local procedure descontar_cajero()
    var
        lrAsi2: Record Asiento;
        FaltaBancoErr: Label 'Hay que poner el banco antes de indicar que es efectivo.';
    begin
        if Fecha = 0D then
            exit;

        if Banco = '' then
            Error(FaltaBancoErr);

        lrAsi2 := Rec;
        lrAsi2.Banco := Banco;
        lrAsi2.Concepto := 'BANCS';
        lrAsi2.Subconcepto := 'CAIXER';
        lrAsi2.Validate(Importe, -Importe);
        lrAsi2."Asiento ligado" := 0;
        lrAsi2.Insert(true);

        "Asiento ligado" := lrAsi2."Num. Asiento";
    end;

    local procedure devolver_cajero()
    var
        lrAsi: Record Asiento;
    begin
        lrAsi.Reset();
        if lrAsi.Get("Asiento ligado") then
            lrAsi.Delete();
    end;

    trigger OnInsert()
    var
        rAsie: Record Asiento;
    begin
        rAsie.Reset();
        if not rAsie.FindLast() then
            Rec."Num. Asiento" := 100
        else
            Rec."Num. Asiento" := rAsie."Num. Asiento" + 100;

        if Rec."Fecha entrada" = 0D then
            Rec."Fecha entrada" := Today;

        Rec."Hora entrada" := Time;
        Rec."Usuario entrada" := CopyStr(UserId(), 1, 50);

        rPar.Get();
        if Rec.Fecha <> 0D then
            if Rec.Fecha < rPar."Fecha inicio permitido" then
                Error(FechaCerradaErr);
    end;

    trigger OnModify()
    var
        rAsie: Record Asiento;
    begin
        if (Rec.Fecha <> xRec.Fecha) or (Rec.Importe <> xRec.Importe) or (Rec.Concepto <> xRec.Concepto) or
           (Rec.Subconcepto <> xRec.Subconcepto) or (Rec."Gasto/Ingreso" <> xRec."Gasto/Ingreso") then begin
            rPar.FindFirst();
            if Rec.Fecha <> 0D then
                if Rec.Fecha < rPar."Fecha inicio permitido" then
                    Error(FechaCerradaErr);

            if "Asiento ligado" <> 0 then
                if rAsie.Get("Asiento ligado") then begin
                    rAsie.Fecha := Rec.Fecha;
                    rAsie.Validate(Importe, -Rec.Importe);
                    rAsie."Gasto/Ingreso" := Rec."Gasto/Ingreso";
                    rAsie.Modify();
                end;
        end;
    end;

    trigger OnDelete()
    var
        rAsie: Record Asiento;
    begin
        if Rec."Asiento ligado" <> 0 then
            if rAsie.Get(Rec."Asiento ligado") then
                rAsie.Delete();
    end;

    var
        rPar: Record Parametros;
        FechaCerradaErr: Label 'Este periodo esta cerrado.';
}
