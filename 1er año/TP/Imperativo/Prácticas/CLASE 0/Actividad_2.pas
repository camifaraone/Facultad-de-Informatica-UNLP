program Actividad_2;
var
   r,n,cant: Integer;
begin
    cant := 0; //Inicializaci?n del contador
    randomize;
    writeln('Para jugar, ingrese un numero. Para salir, ingrese el numero 5.');
    write('> ');
    readln(n);
    while(n <> 5) do begin
      writeln;
      r := random(11);
      if (r = n) then begin
         writeln('> ¡Felicitaciones, acertaste!');
         cant:= cant + 1;
      end
      else
          writeln('> No acertaste :( pero puedes volver a intentarlo!');
      writeln('Para volver a jugar, ingrese un numero. Para salir, ingrese el numero 5');
      write('> ');
      readln(n);
    end;
    writeln;
    writeln('Numero de aciertos: ',cant);
    readln;
end.
