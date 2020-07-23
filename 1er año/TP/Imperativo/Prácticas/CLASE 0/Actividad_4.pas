Program Actividad_4
Const
     dimf=8;

Type
    vector = array [1..dimf] of integer;



procedure crearvector ( var v:vector; var diml:integer);
var
   n:integer;
begin
   diml:=0;
   n:= random (100);
   while (n<>0) and (diml < dimf) do begin
         diml:= diml +1;
         v[diml]:= n;
         n:= random (100);
   end;
end;


procedure imprimirVector( v:vector);
var
    i:integer;
begin
     for i := 1 to diml do
         write (v[i]);
end;


{------------------------------------------------------------------------------}
var
   v:vector; diml:integer;

begin
     randomize;

     crearvector(v,diml);

     writeln ('Nros almacenados:');
     imprimirVector (v);
     writeln;
end.

