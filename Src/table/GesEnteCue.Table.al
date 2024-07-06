/// <summary>
/// Table GesEnte Cue (ID 50127).
/// </summary>
table 50127 "GesEnte Cue"
{
    Caption = 'GesEnte Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Temporal Tickets"; Integer)
        {
            Caption = 'Temporal Tickets';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Temporal compras tarjeta");
        }
        field(3; "Asientos Pendientes"; Integer)
        {
            Caption = 'Asientos Pendientes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count(Asiento where(Definitivo = const(false), Fecha = field("Filtro Fecha")));
        }
        field(4; "Presupuesto mensual"; Decimal)
        {
            Caption = 'Presupuesto mensual';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Presupuesto compra"."Importe mensual" where("Tipo presupuesto" = const(Presupuesto), Caducado = const(false)));
        }
        field(5; "Ahorro acumulado"; Decimal)
        {
            Caption = 'Ahorro acumulado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum(Asiento."Importe signo" where("ID Presupuesto" = filter(<> 0)));
        }
        field(6; "Ahorro activo mensual"; Decimal)
        {
            Caption = 'Ahorro activo mensual';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Presupuesto compra"."Importe mensual" where("Tipo presupuesto" = const(Ahorro), Caducado = const(false)));
        }
        field(7; "Ahorro alcanzado"; Decimal)
        {
            Caption = 'Ahorro alcanzado';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Presupuesto compra"."Importe objetivo" where("Tipo presupuesto" = const(Ahorro), "Objetivo alcanzado" = const(true)));
        }
        field(8; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            DataClassification = ToBeClassified;
        }
        field(9; "Filtro Fecha"; Date)
        {
            Caption = 'Filtro Fecha';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
