program OrdenacionVector;

Const
     dimf=4;

Type
    vector = array [1..dimf] of integer;





{------------------------------------------------------------------------------
 IMPRIMO TODOS LOS ELEMENTOS Q TENGA EL VECTOR}
procedure imprimirVector( v:vector; diml:integer);
var
    i:integer;
begin
     for i := 1 to diml do
         write (v[i], '|');
end;


{------------------------------------------------------------------------------
 ORDENA LOS ELEMENTOS DEL VECTOR DE MENOR A MAYOR}
procedure OrdenacionPorInsercion (var v:vector; diml:integer);        // en cada pasada elige a un minimo.
var
   i,j,p:integer;
   aux:vector;
begin
     for i:= 1 to (diml-1) do begin                   //UTILIZA (DIML-1) PASADAS, DONDE N ES LA DIMENSION DEL ARREGLO
         p:=i;
         for j:= (i+1) to diml do begin
             if (v[j]< v[p]) then
                p:=j;
                aux[p]:= v[p];
                v[p]:= v[i];
                v[i]:= aux[p];
         end;
     end;
end;


{------------------------------------------------------------------------------
 CREO VECTOR DE NUMEROS ALEATORIAMENTE}
procedure crearvector ( var v:vector; var diml:integer);
var
   n:integer;
begin
   diml:=0;
   n:= random (10);
   while (n<>0) and (diml < dimf) do begin
         diml:= diml +1;
         v[diml]:= n;
         n:= random (10);
   end;
end;


{------------------------------------------------------------------------------
 INICIALIZO EL VECTOR EN 0}
procedure inicializarV (var v:vector);
var
    i:integer;
begin
     for i:= 1 to dimf do
         v[i]:=0;
end;


{------------------------------------------------------------------------------}
var
   v:vector; diml:integer;

begin
     randomize;

     inicializarV (v);

     crearvector(v,diml);
     writeln ('Vector original:');
     imprimirVector (v,diml);

     writeln;
     writeln('ordenando...');
     OrdenacionPorInsercion (v,diml);

     writeln ('Nros ordenados y almacenados:');
     imprimirVector (v,diml);
     readln;

end.

