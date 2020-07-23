program NumAleatorio;

var ale: integer;

begin
     Randomize;
     
     ale := random (100); {valores en el intervalo 0 a 99}

     writeln ('El numero aleatorio generado es: ', ale);

     readln;
end.
