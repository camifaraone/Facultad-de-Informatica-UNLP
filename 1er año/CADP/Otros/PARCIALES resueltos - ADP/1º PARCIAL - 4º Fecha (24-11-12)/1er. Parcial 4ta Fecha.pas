{Se acerca el cumpleaños de Fernandito y está organizando su fiesta. Para ello
necesita que usted desarrolle un programa que arme una estructura que contenga
los invitados que él desea tener en su dia, que son exactamente 200.
Los invitados se organizarán en 20 mesas (numeradas de 1 al 20) de 10 invitados
cada una.


1) Simular la recepción de los 200 invitados, para ello se leen desde teclado
los datos del invitado (DNI, nombre , apellido, si es familiar de Fernandito)
junto con el numero de mesa asignado (1..20) y la posición de la mesa (1..10).
cada invitado debe ser ubicado en la mesa y posición que le corresponde.

2) Una vez generada la estructura del punto 1, se pide:
a. Calcular e informar la cantidad de invitados cuyo DNI posee a lo sumo tres
digitos impares.
b. Para cada mesa, informar la cantidad de invitados con apellido "Marrero"    }

Program Ej_Parcial;
const
  MAX_MESA =  2;
  MAX_SILLA = 3;
type
  invitado = record
               DNI:integer;
               nombre:string;
               apellido:string;
               es_familiar:boolean;
               nro_mesa:1..MAX_MESA;
               nro_silla:1..MAX_SILLA;
  end;

  MATRIZ = array [1..MAX_MESA,1..MAX_SILLA] of invitado;



           { - - - - INICIO MODULO LEER_INVITADO - - - - }
procedure LEER_INVITADO (var I:invitado);
var
  fliar:string;
begin
  writeln ('Ingrese DNI : ');
  readln (I.DNI);
  writeln ('Ingrese NOMBRE : ');
  readln (I.nombre);
  writeln ('Ingrese APELLIDO : ');
  readln (I.apellido);
  writeln ('Ingrese NRO_MESA (de 1 a 20) : ');
  readln (I.nro_mesa);
  writeln ('Ingrese NRO_SILLA (de 1 a 10) : ');
  readln (I.nro_silla);
  writeln ('El invitado es FAMILIAR ?? ("SI" o "NO" :' );
  readln (fliar);
  if (fliar = 'SI') then
    I.es_familiar:= TRUE
  else
    I.es_familiar:= FALSE;
end;
           { - - - - INICIO MODULO LEER_INVITADO - - - - }


           { - - - - INICIO MODULO CARGAR_MATRIZ - - - - }
procedure CARGAR_MATRIZ (var M:MATRIZ);
var
  I:invitado;
  j:integer;
begin
  for j:= 1 to 6 do begin
    LEER_INVITADO (I);
    M[I.nro_mesa,I.nro_silla]:= I;
  end;
end;
           { - - - - FIN MODULO CARGAR_MATRIZ - - - - }


           { - - - - INICIO MODULO PUNTO_A - - - - }
procedure PUNTO_A (DNI:integer; var cant_impar:integer);
var
  dig:integer;
  cant:integer;
begin
  cant:= 0;
  while (DNI > 0) do begin
    dig:= DNI mod 10;
    if (dig mod 2 = 1) then
      cant:= cant + 1;
    DNI:= DNI div 10;
  end;
  if (cant <= 3) then
    cant_impar:= cant_impar + 1;
end;
           { - - - - FIN MODULO PUNTO_A - - - - }


           { - - - - INICIO MODULO PUNTO_B - - - - }
procedure PUNTO_B (apellido:string; var cant_marrero:integer);
begin
  if (apellido = 'marrero') then
    cant_marrero:= cant_marrero + 1;
end;
           { - - - - FIN MODULO PUNTO_B - - - - }




           { - - - - INICIO MODULO RECORRER_MATRIZ - - - - }
procedure RECORRER_MATRIZ (M:MATRIZ);
var
  cant_impar:integer;
  cant_marrero:integer;
  i:integer;
  j:integer;
begin
  cant_impar:= 0;
  for i:= 1 to MAX_MESA do begin
    cant_marrero:= 0;
    for j:= 1 to MAX_SILLA do begin
      PUNTO_A (M[i,j].DNI,cant_impar);
      PUNTO_B (M[i,j].apellido,cant_marrero);
    end;
    writeln ('En la Mesa : ',i, ' hubieron : ', cant_marrero, ' invitados con el apellido MARRERO.-')
  end;
  writeln ('Cantidad de invitados con DNI con a lo sumo 3 dig impares fue de : ',cant_impar);
end;
           { - - - - FIN MODULO RECORRER_MATRIZ - - - - }



// PROGRAMA PRINCIPAL
var
  M:MATRIZ;
begin
  CARGAR_MATRIZ (M);
  RECORRER_MATRIZ (M);
  writeln ('Presione ENTER para finalizar');
  readln ();
end.

