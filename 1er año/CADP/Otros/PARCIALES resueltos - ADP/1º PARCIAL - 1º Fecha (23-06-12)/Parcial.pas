program parcial;
uses crt;
type
  venta = record
            dni: integer;
            apellido: string [20];
            nombre: string [20];
            tipo: 1..20;
            marca: string [20];
            monto: real;
          end;

  vector = array [1..20] of integer;

      { - - - - INICIO MODULO LEER - - - - }
procedure leer_registro (var vent:venta);
begin
  writeln ('Ingrese DNI : ');
  readln (vent.dni);
  if (vent.dni <> 0) then begin
    writeln ('Ingrese APELLIDO : ');
    readln (vent.apellido);
    writeln ('Ingrese NOMBRE : ');
    readln (vent.nombre);
    writeln ('Ingrese TIPO DE INSTRUMENTO (1 a 20) : ');
    readln (vent.tipo);
    writeln ('Ingrese MARCA : ');
    readln (vent.marca);
    writeln ('Ingrese MONTO : ');
    readln (vent.monto);
  end;
end;
      { - - - - FIN MODULO LEER - - - - }

      { - - - - INICIO MODULO INICIALIZAR - - - - }
procedure inicializar (var vectipo:vector);
var
  i: integer;
begin
  for i:= 1 to 20 do
    vectipo[i]:= 0;
end;
      { - - - - FIN MODULO INICIALIZAR - - - - }


      { - - - - INICIO MODULO EVALUAR_MAXIMO - - - - }
procedure evaluar_maximo (vectipo:vector; var tipomax:integer);
var
  i: integer;
  cantmax: integer;
begin
  cantmax:= -1;
  for i:= 1 to 20 do begin
    if (vectipo[i] > cantmax) then begin
      cantmax:= vectipo[i];
      tipomax:= i;
    end;
  end;
end;
      { - - - - FIN MODULO EVALUAR_MAXIMO - - - - }





{PROGRAMA PRINCIPAL}
var
  vent: venta;
  vectipo: vector;
  dniactual: integer;
  montocliente: real;
  cantyamaha: integer;
  tipomax: integer;

begin
  inicializar (vectipo);
  leer_registro (vent);
  cantyamaha:= 0;
  while (vent.dni <> 0) do begin
    dniactual:= vent.dni;
    montocliente:= 0;
    while (dniactual = vent.dni) do begin
      montocliente:= montocliente + vent.monto;
      if (vent.marca = 'yamaha') then
        cantyamaha:= cantyamaha + 1;
      vectipo[vent.tipo]:= vectipo[vent.tipo] + 1;
      leer_registro (vent);
    end;
    writeln ('El cliente ', dniactual, ' abono un total de : $ ', montocliente:2:2);
  end;
  writeln ('La cantidad de instrumentos marca YAMAHA vendidos que de : ', cantyamaha);
  evaluar_maximo (vectipo,tipomax);
  writeln ('El tipo de instrumento mas vendido fue el Nro. : ', tipomax);
  writeln ('Presione ENTER para finalizar');
  readkey;
end.




