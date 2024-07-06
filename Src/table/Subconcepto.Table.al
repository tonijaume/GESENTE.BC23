/// <summary>
/// Table "Subconcepto" (ID 50105).
/// </summary>
table 50105 Subconcepto
{
    DataClassification = CustomerContent;
    Caption = 'Subconcepto';
    LookupPageId = "Lista subconceptos";

    fields
    {
        field(1; Concepto; Code[10])
        {
            Caption = 'Concepto';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Concepto;
            NotBlank = true;
        }
        field(2; "Codigo Subconcepto"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Subconcepto';
            NotBlank = true;
        }
        field(3; Descripcion; Text[100])
        {
            Caption = 'Descripcion';
            DataClassification = CustomerContent;
        }
        field(4; "Filtro fecha"; Date)
        {
            Caption = 'Filtro fecha';
            FieldClass = FlowFilter;
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Importe';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Concepto = field(Concepto),
                                                            Subconcepto = field("Codigo Subconcepto"),
                                                            Fecha = field("Filtro fecha"),
                                                            "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"),
                                                            Banco = field("Filtro banco"),
                                                            Traspaso = field("Filtro Traspaso"),
                                                            "ID Presupuesto" = field("Filtro presupuesto")));
        }
        field(6; "Filtro Gasto/Ingreso"; Enum GastoIngreso)
        {
            Caption = 'Filtro Gasto/Ingreso';
            FieldClass = FlowFilter;
        }
        field(7; "Tipo entrada"; Enum GastoIngreso)
        {
            Caption = 'Tipo entrada';
            DataClassification = CustomerContent;
        }
        field(8; "Filtro banco"; Code[10])
        {
            Caption = 'Filtro banco';
            FieldClass = FlowFilter;
            TableRelation = Banco;
        }
        field(9; "Filtro Traspaso"; Boolean)
        {
            Caption = 'Filtro Traspaso';
            FieldClass = FlowFilter;
        }
        field(10; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
            DataClassification = CustomerContent;
        }
        field(11; "CC Definitivo"; Decimal)
        {
            Caption = 'CC Definitivo';
            FieldClass = FlowField;
            Editable = false;

            CalcFormula = sum(Asiento."Importe signo" where(Concepto = field(Concepto), Subconcepto = field("Codigo Subconcepto"), Fecha = field("Filtro fecha"), "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"), Banco = field("Filtro banco"), Traspaso = field("Filtro Traspaso"), Definitivo = const(true), "ID Presupuesto" = field("Filtro presupuesto")));
        }
        field(12; "Importe presupuestado"; Decimal)
        {
            Caption = 'Importe presupuestado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Mov. Presupuesto compra".Importe where(Subconcepto = field("Codigo Subconcepto"), Fecha = field("Filtro fecha")));
        }
        field(13; "Saldo hoy"; Decimal)
        {
            Caption = 'Saldo hoy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Concepto = field(Concepto), Subconcepto = field("Codigo Subconcepto"), Fecha = field("Filtro hoy"), "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"), Banco = field("Filtro banco"), Traspaso = field("Filtro Traspaso"), "ID Presupuesto" = field("Filtro presupuesto")));
        }
        field(14; "Saldo mes"; Decimal)
        {
            Caption = 'Saldo mes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Asiento."Importe signo" where(Concepto = field(Concepto), Subconcepto = field("Codigo Subconcepto"), Fecha = field("Filtro mes"), "Gasto/Ingreso" = field("Filtro Gasto/Ingreso"), Banco = field("Filtro banco"), Traspaso = field("Filtro Traspaso"), "ID Presupuesto" = field("Filtro presupuesto")));
        }
        field(15; "Filtro hoy"; Date)
        {
            Caption = 'Filtro hoy';
            FieldClass = FlowFilter;
        }
        field(16; "Filtro mes"; Date)
        {
            Caption = 'Filtro mes';
            FieldClass = FlowFilter;
        }
        field(17; "Filtro presupuesto"; Integer)
        {
            Caption = 'Filtro presupuesto';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; Concepto, "Codigo Subconcepto")
        {
            Clustered = true;
        }
    }
}