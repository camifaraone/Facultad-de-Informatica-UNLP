program Actividad_5
Type
    rangoI=1980..2018;
    rangoC=1..4;
    cadena= string [30];
    empleados=record
              apellido:cadena;
              ingreso:rangoI;
              categoria:rangoC;
     end;

    lista=^nodo;
    nodo=record
           dato:empleados;
           sig:lista;
    end;

    vector=array [1..rangoC] of lista;



{------------------------------------------------------------------------------
 imprime la categoria de cada empleado}
procedure imprimir (v:vector;l:lista);
var
   i:integer;
begin

   for i:= 1 to 4 do
       write ('el codigo del empleado es:',v[l^.dato.categoria]);
end;

{-----------------------------------------------------------------------------
inserta ordenado por apellido}
procedure insertarOrdenado(var l:lista; e:empleados);
var
    nuevo,ant,act:lista;
begin
     new(nuevo);
     nuevo^.dato:=e;
     ant:=l;
     act:=l;
     while (act<>nil) and (act^.dato.apellido<nuevo^.dato.apellido) do begin
           ant:=act;
           act:= act^.sig;
     end;
     if (ant=act) then begin
        nuevo^.sig:= l;
        l:=nuevo;
     end
     else
         ant^.sig:= nuevo;
     nuevo^.sig:=act;
end;


{-------------------------------------------------------------------------------
 proceso leer el registro}
procedure leer(var e:empleado);
begin
     read(e.apellido);
     read(e.ingreso);
     read(e.categoria);
end;


{------------------------------------------------------------------------------
 carga los 15 empleados en el vector de listas por cada categoria}
procedure cargar (var v:vector);
var
   e:empleado;
begin
     for i:= 1 to 15 do begin
         leer (e);
         insertarOrdenado (v[e.categoria],e);
     end;
end;


{------------------------------------------------------------------------------
  en el vector estan las listas, las pongo en nil}
procedure inicializarV (var v:vector);
var
    i:integer;
begin
     for i:= 1 to 4 do
         v[i]:= nil;
end;


 {-----------------------------------------------------------------------------}
var
   l:lista ; v:vector;
begin
    inicializarV(v);
    cargar(v);
    imprimir(v,l);
    readln();
end.
