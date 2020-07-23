{                       Tema 2- REDUCIDO - 14/07/2012

Un cine abre su boleteria para la venta de entradas (a lo sumo 400).

Realice un programa que:
a. Simule la recepciòn de las personas en la boleterìa. De cada persona se lee:
nombre, DNI, y el còdigo(1..10) de las peliculas que està interesado asistir
(a lo sumo 5). La lectura de personas finaliza al leer DNI 0, y la lectura de
còdigos de pelìculas de cada persona finaliza al leer còdigo 0.

Luego de realizar el punto a) calcular e informar:

b. El còdigo de pelicula que recibira menor cantidad de personas.
c. La cantidad de personas que concurriràn a lo sumo 3 peliculas.

Nota: Definir todas la estructuras de datos utilizadas. Modularizar            }

{ - - - - - - - - - - - - - - INICIO ESTRUCTURAS - - - - - - - - - - - - - - - }
program ParcialADP;
uses crt;
type
vectorpeliculas = array [1..5] of integer;
persona = record
            nombre: string [20];
            dni: integer;
            codigo: 1..10;
            vp: vectorpeliculas;
            dim_log: integer; //1..5;
end;
vectorpersonas = array [1..400] of persona;
vectorcodigo = array [1..10] of integer;

{ - - - - - - - - - - - - - - FIN ESTRUCTURAS - - - - - - - - - - - - - - - }


             { - - - - INICIO MODULO LEER - - - - }
procedure leer_persona (var p:persona);
begin
  p.dim_log:= 0;
  writeln ('Ingrese DNI : ');
  readln (p.dni);
  if (p.dni <> 0) then begin
    writeln ('Ingrese NOMBRE : ');
    readln (p.nombre);
    writeln ('Ingrese CODIGO DE PELICULA : ');
    readln (p.codigo);
    while (p.codigo <> 0) and (p.dim_log < 5) do begin
      p.dim_log:= p.dim_log + 1;
      p.vp[p.dim_log]:= p.codigo;
      writeln ('Ingrese NUEVO CODIGO DE PELICULA : ');
      readln (p.codigo);
    end;
  end;
end;
             { - - - - FIN MODULO LEER - - - - }


             { - - - - INICIO MODULO INICIALIZAR_VECTOR - - - - }
procedure inicializar_vector (var vec_cod:vectorcodigo);
var
  i:integer;
begin
  for i:= 1 to 10 do
    vec_cod[i]:= 0;
end;
             { - - - - FIN MODULO INICIALIZAR_VECTOR - - - - }


             { - - - - INICIO MODULO CARGAR_VECTOR - - - - }
procedure cargar_vector (var vec:vectorpersonas; var DIM_LOG:integer);
var
  p:persona;
begin
  leer_persona (p);
  while (p.dni <> 0) and (DIM_LOG < 400) do begin
    DIM_LOG:= DIM_LOG + 1;
    vec[DIM_LOG]:= p;
    leer_persona (p);
  end;
end;
             { - - - - FIN MODULO CARGAR_VECTOR - - - - }


             { - - - - INICIO MODULO RECORRER - - - - }
procedure Recorrer (vp:vectorpeliculas; dim_log:integer; var vec_cod:vectorcodigo);
var
  i: integer;
begin
  for i:= 1 to dim_log do
    vec_cod[vp[i]]:= vec_cod[vp[i]] + 1;

end;
             { - - - - FIN MODULO RECORRER - - - - }


             { - - - - INICIO MODULO MINIMO - - - - }
procedure Minimo (vec_cod:vectorcodigo);
var
  i:integer;
  cod_min:integer;
  cant_min:integer;
begin
  cod_min:= 0;
  cant_min:= 1000;
  for i:= 1 to 10 do begin
    if (vec_cod[i] < cant_min) then begin
      cant_min:= vec_cod[i];
      cod_min:= i;
    end;
  end;
  writeln ('Codigo de Pelicula con menor cantidad de personas fue el COD : ', cod_min);
end;
             { - - - - FIN MODULO MINIMO - - - - }

















             { - - - - INICIO MODULO INFORMAR - - - - }
procedure Informar (vec:vectorpersonas; DIM_LOG:integer);
var
  cant: integer;
  vec_cod:vectorcodigo;
  i: integer;
begin
  cant:= 0;
  inicializar_vector (vec_cod);
  for i:= 1 to DIM_LOG do begin
    if (vec[i].dim_log >= 3) then       { Punto c) }
      cant:= cant + 1;
    Recorrer (vec[i].vp,vec[i].dim_log,vec_cod);
  end;
  Minimo (vec_cod);
  writeln ('Cantidad de personas que asistieron a lo sumo 3 peliculas : ', cant);
end;
             { - - - - FIN MODULO INFORMAR - - - - }



               { - - - - PROGRAMA PRINCIPAL - - - - }
var
  vec:vectorpersonas;
  DIM_LOG:integer;                    // Dimension Logica de Vector con Personas
begin
  DIM_LOG:= 0;
  cargar_vector (vec,DIM_LOG);    // Modulo que carga vector con Personas
  Informar (vec,DIM_LOG);
  writeln ('Presione ENTER para finalizar');
  readkey;
end.

