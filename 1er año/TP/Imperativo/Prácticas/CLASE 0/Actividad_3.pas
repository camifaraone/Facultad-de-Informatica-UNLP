program Actividad_3;
type
    lista = ^nodo;
    nodo = record
      dato: integer;
      sig: lista;
    end;



procedure insertarAdelante (var l:lista; n:integer);
var
   nuevo:lista;
begin
     new(nuevo);
     nuevo^.dato:=n;
     nuevo^.sig:=l;
     l:=nuevo;
end;

procedure insertarAtras (var l,ult:lista; n:integer);
var
   nuevo:lista;
begin
     new(nuevo);
     nuevo^.dato:=n;
     nuevo^.sig:=nil;
     if (l=nil) then
        l:=nuevo
     else
         ult^.sig:=nuevo;
     ult:=nuevo;
end;


procedure insertarOrdenado(var l:lista; n:integer);
var
    nuevo,ant,act:lista;
begin
     new(nuevo);
     nuevo^.dato:=n;
     ant:=l;
     act:=l;
     while (act<>nil) and (act^.dato<nuevo^.dato) do begin
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



procedure imprimir (pri:lista);
begin
     while (pri <> nil) do begin
           write (pri^.dato ,' ');
           pri:= pri^.sig;
     end;
     writeln;
end;



var
  LA, LU, LO, ult: lista;
  i,n:integer;
Begin
   randomize;
   LA := Nil;
   LU := Nil;
   LO := Nil;

   //Generar listas
   for i:= 1 to 5 do begin
       n:= random (50);
       insertarOrdenado(LO,n);
       insertarAtras(LU,ult,n);
       insertarAdelante(LA,n);
   end;

   //Imprimir
   writeln('Agregar adelante');
   imprimir(LA);
   writeln;
   writeln('Agregar atras');
   imprimir(LU);
   writeln;
   writeln('Agregar ordenado');
   imprimir(LO);

   readln;
End.
