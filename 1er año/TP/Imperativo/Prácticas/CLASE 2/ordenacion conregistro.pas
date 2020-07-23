program Ordenacion;

uses
    sysutils;


const
     dimf =4;
Type

    cadena= string [30];
    personas = record
             nombre:cadena;
             apellido:cadena;
             dni:integer;
    end;


    vector = array [1..dimf] of personas;





{------------------------------------------------------------------------------
 IMPRIMO TODOS LOS ELEMENTOS Q TENGA EL VECTOR}
procedure imprimirVector( v:vector; diml:integer);
var
    i:integer;
begin
     for i := 1 to diml do
         write (v[i].nombre, '/',v[i].apellido,'/',v[i].dni,'/');
end;


{------------------------------------------------------------------------------
 ORDENA LOS ELEMENTOS DEL VECTOR DE MENOR A MAYOR POR APELLIDO}
procedure OrdenacionPorInsercion (var v:vector; diml:integer);        // en cada pasada elige a un minimo.
var
   i,j,p:integer;
   aux:vector;
begin
     for i:= 1 to (diml-1) do begin                   //UTILIZA (DIML-1) PASADAS, DONDE N ES LA DIMENSION DEL ARREGLO
         p:=i;
         for j:= (i+1) to diml do begin
             if (v[j].nombre< v[p].nombre) then begin
                p:=j;
                aux[p].nombre:= v[p].nombre;
                v[p].nombre:= v[i].nombre;
                v[i].nombre:= aux[p].nombre;
             end;
         end;
     end;
end;


{------------------------------------------------------------------------------
LECTURA DEL REGISTRO}
procedure leer (var p:personas);
begin
     p.nombre:= 'nombre' + inttostr(random(10));
     if (p.nombre <> 'zzz') then begin
        p.apellido:= 'apellido' + inttostr (random(10));
        p.dni:= random(20);
     end;
end;






{------------------------------------------------------------------------------
 CREO VECTOR DE REGISTROS}
procedure crearvector ( var v:vector; var diml:integer);
var
   p:personas;
begin
   diml:=0;
   leer (p);
   while (p.nombre<>'zzzz') and (diml < dimf) do begin
         diml:= diml +1;
         v[diml]:= p;
         leer (p);
   end;
end;



{------------------------------------------------------------------------------}
var
   v:vector; diml:integer;

begin
     randomize;

     crearvector(v,diml);
     writeln ('Vector original:');
     imprimirVector (v,diml);

     OrdenacionPorInsercion (v,diml);

     writeln ('Nros ordenados y almacenados:');
     imprimirVector (v,diml);
     readln;

end.

