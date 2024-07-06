/// <summary>
/// Table Presupuesto compra (ID 50125).
/// </summary>
table 50125 "Presupuesto compra"
{
    Caption = 'Presupuesto compra';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; Concepto; Code[10])
        {
            Caption = 'Concepto';
            TableRelation = Concepto;
            DataClassification = CustomerContent;
        }
        field(3; Subconcepto; Code[10])
        {
            TableRelation = Subconcepto."Codigo Subconcepto" where(Concepto = field(Concepto));
            Caption = 'Subconcepto';
            DataClassification = CustomerContent;
        }
        field(4; Descripcion; Text[100])
        {
            Caption = 'Descripcion';
            DataClassification = CustomerContent;
        }
        field(5; "Importe mensual"; Decimal)
        {
            Caption = 'Importe mensual';
            DataClassification = CustomerContent;
        }
        field(6; Caducado; Boolean)
        {
            Caption = 'Caducado';
            DataClassification = CustomerContent;
        }
        field(7; "Ahorro acumulado"; Decimal)
        {
            Caption = 'Ahorro acumulado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento.Importe where("ID Presupuesto" = field(ID)));
        }
        field(8; "Fecha ult. operacion"; Date)
        {
            Caption = 'Fecha ult. operacion';
            DataClassification = CustomerContent;
        }
        field(9; "Fecha compra"; Date)
        {
            Caption = 'Fecha compra';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec."Fecha compra" <> 0D then begin
                    TestField("Precio compra");

                    if "Tipo presupuesto" = "Tipo presupuesto"::Ahorro then
                        BorrarMovimientos();
                    RegistrarHistorico();

                    Rec."Precio compra" := 0;
                    Rec."Objetivo alcanzado" := false;
                    Rec."Meses ahorrados (Real)" := 0;
                end;
            end;
        }
        field(10; Banco; Code[10])
        {
            Caption = 'Banco';
            TableRelation = Banco;
            DataClassification = CustomerContent;
        }
        field(11; "Tipo presupuesto"; Enum "Tipo presupuesto")
        {
            Caption = 'Tipo presupuesto';
            DataClassification = CustomerContent;
        }
        field(12; "Precio compra"; Decimal)
        {
            Caption = 'Precio compra';
            DataClassification = CustomerContent;
        }
        field(13; "Meses ahorrados (Real)"; Integer)
        {
            Caption = 'Meses ahorrados (Real)';
            DataClassification = CustomerContent;
        }
        field(14; "Objetivo alcanzado"; Boolean)
        {
            Caption = 'Objetivo alcanzado';
            DataClassification = CustomerContent;
        }
        field(15; "Importe objetivo"; Decimal)
        {
            Caption = 'Importe objetivo';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ImporteObjetivoErr: Label 'El importe objetivo solo lo usamos en el ahorro.';
            begin
                if Rec."Tipo presupuesto" = Rec."Tipo presupuesto"::Presupuesto then
                    Error(ImporteObjetivoErr);
            end;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// ImporteRealMes.
    /// </summary>
    /// <returns>Return value of type Decimal.</returns>
    procedure ImporteRealMes(): Decimal
    var
        lwFechaDesde: Date;
        lwFechaHasta: Date;
        lrAsientos: Record Asiento;
    begin
        lwFechaDesde := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3));
        lwFechaHasta := CalcDate('<+1M-1D>', lwFechaDesde);

        lrAsientos.Reset();
        lrAsientos.SetRange(Fecha, lwFechaDesde, lwFechaHasta);
        lrAsientos.SetRange(Concepto, Concepto);
        lrAsientos.SetRange(Subconcepto, Subconcepto);
        if lrAsientos.FindSet() then begin
            lrAsientos.CalcSums(Importe);
            exit(lrAsientos.Importe);
        end;
    end;

    internal procedure CalculoMeses(): Integer
    begin
        CalcFields(Rec."Ahorro acumulado");
        if Rec."Importe mensual" <> 0 then
            exit(Round(Rec."Ahorro acumulado" / Rec."Importe mensual", 1))
        else
            exit(0);
    end;

    local procedure BorrarMovimientos()
    var
        confmanagement: Codeunit "Confirm Management";
        ConfCompraMsg: Label 'Confirmas que se ha hecho la compra, eliminamos lo ahorrado';
        ProcesoCanceladoErr: Label 'Proceso cancelado.';
        Asiento: Record Asiento;
    begin
        if not confmanagement.GetResponse(ConfCompraMsg, false) then
            Error(ProcesoCanceladoErr);

        Clear(Asiento);
        Asiento.SetRange("ID Presupuesto", ID);
        if Asiento.FindSet(true) then
            Asiento.DeleteAll();
    end;

    local procedure RegistrarHistorico()
    var
        HistoricoCompra: Record "Historico compras";
    begin
        HistoricoCompra.Reset();
        HistoricoCompra."ID Presupuesto" := Rec.ID;
        HistoricoCompra.Concepto := Rec.Concepto;
        HistoricoCompra.Subconcepto := Rec.Subconcepto;
        HistoricoCompra.Descripcion := Rec.Descripcion;
        HistoricoCompra.Fecha := Rec."Fecha compra";
        HistoricoCompra."Precio compra" := Rec."Precio compra";
        HistoricoCompra.Insert();
    end;



    trigger OnInsert()
    begin
        Rec."Fecha ult. operacion" := CalcDate('<-1M>', Today);
    end;
}
