program CalculoDePotencia;

Function potencia (x,n: integer): real;
begin
  if (n = 0) then 
    potencia:= 1
  else
    potencia := x * potencia(x,n-1);
end;

{PROGRAMA PRINCIPAL}



begin


     readln;
     readln;
end.
