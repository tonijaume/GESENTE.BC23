/// <summary>
/// Table "Banco" (ID 50101).
/// </summary>
table 50101 Banco
{
    DataClassification = ToBeClassified;
    Caption = 'Banco';
    LookupPageId = "Lista Bancos";

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
        field(3; Cuenta; Code[20])
        {
            Caption = 'Cuenta';
            DataClassification = CustomerContent;
        }
        field(4; "Ultimo dia"; Date)
        {
            Caption = 'Ultimo dia';
            DataClassification = CustomerContent;
        }
        field(5; "Saldo a la fecha"; Decimal)
        {
            Caption = 'Saldo a la fecha';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(Asiento."Importe signo" where(Banco = field(Codigo),
                                                            Fecha = field("Filtro Fecha"),
                                                            "Gasto/Ingreso" = field("Filtro Gasto/Ingreso")));
        }
        field(6; "Saldo a 2 meses"; Decimal)
        {
            Caption = 'Saldo a 2 meses';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(Asiento."Importe signo" where(Banco = field(Codigo),
                                                            Fecha = field("Filtro Fecha 3"),
                                                            "Gasto/Ingreso" = field("Filtro Gasto/Ingreso")));
            trigger OnLookup()
            var
                lrSubCon: Record Subconcepto;
                lfSubCon: Page "Subconceptos con saldo";
            begin
                lrSubCon.Reset();
                lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today, GetRangeMax(Rec."Filtro Fecha 3"));

                Clear(lfSubCon);
                lfSubCon.SetTableView(lrSubCon);
                lfSubCon.RunModal();
            end;
        }
        field(7; "Filtro Fecha"; Date)
        {
            Caption = 'Filtro Fecha';
            FieldClass = FlowFilter;
        }
        field(8; "Filtro Fecha 2"; Date)
        {
            Caption = 'Filtro Fecha 2';
            FieldClass = FlowFilter;
        }
        field(9; "Filtro Gasto/Ingreso"; Enum GastoIngreso)
        {
            Caption = 'Filtro Gasto/Ingreso';
            FieldClass = FlowFilter;
        }
        field(10; "Saldo a 1 mes"; Decimal)
        {
            Caption = 'Saldo a 1 mes';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(Asiento."Importe signo" where(Banco = field(Codigo),
                                                            Fecha = field("Filtro Fecha 2"),
                                                            "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"),
                                                            "ID Presupuesto" = field("Filtro ID presupuesto")));
            trigger OnLookup()
            var
                lrSubCon: Record Subconcepto;
                lfSubCon: Page "Subconceptos con saldo";
            begin
                lrSubCon.Reset();
                lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today, GetRangeMax(Rec."Filtro Fecha 2"));

                Clear(lfSubCon);
                lfSubCon.SetTableView(lrSubCon);
                lfSubCon.RunModal();
            end;
        }
        field(11; "Filtro Fecha 3"; Date)
        {
            Caption = 'Filtro Fecha 3';
            FieldClass = FlowFilter;
        }
        field(12; IBAN; Code[50])
        {
            Caption = 'IBAN';
            DataClassification = CustomerContent;
        }
        field(13; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
            DataClassification = CustomerContent;
        }
        field(14; Orden; Integer)
        {
            Caption = 'Orden';
            DataClassification = CustomerContent;
        }
        field(15; "Saldo real a 1 mes"; Decimal)
        {
            Caption = 'Saldo real a 1 mes';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(Asiento."Importe signo" where(Banco = field(Codigo),
                                                            Fecha = field("Filtro Fecha 2"),
                                                            "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"),
                                                            "ID Presupuesto" = const(0)));
            trigger OnLookup()
            var
                lrSubCon: Record Subconcepto;
                lfSubCon: Page "Subconceptos con saldo";
            begin
                lrSubCon.Reset();
                lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today, GetRangeMax(Rec."Filtro Fecha 2"));
                lrSubCon.SetRange("Filtro presupuesto", 0);


                Clear(lfSubCon);
                lfSubCon.SetTableView(lrSubCon);
                lfSubCon.RunModal();
            end;
        }
        field(16; "Saldo real a 2 meses"; Decimal)
        {
            Caption = 'Saldo real a 2 meses';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(Asiento."Importe signo" where(Banco = field(Codigo),
                                                            Fecha = field("Filtro Fecha 3"),
                                                            "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"),
                                                            "ID Presupuesto" = const(0)));
            trigger OnLookup()
            var
                lrSubCon: Record Subconcepto;
                lfSubCon: Page "Subconceptos con saldo";
            begin
                lrSubCon.Reset();
                lrSubCon.SetFilter("Filtro banco", Rec.Codigo);
                lrSubCon.SetFilter("Filtro fecha", '%1..%2', Today, GetRangeMax(Rec."Filtro Fecha 3"));
                lrSubCon.SetRange("Filtro presupuesto", 0);


                Clear(lfSubCon);
                lfSubCon.SetTableView(lrSubCon);
                lfSubCon.RunModal();
            end;
        }
        field(17; "Filtro ID presupuesto"; Integer)
        {
            Caption = 'Filtro ID presupuesto';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; Codigo)
        {
            Clustered = true;
        }
        key(Key2; Orden)
        {

        }
    }
}