program Ejercicio1;
type
    ingresoemp= record
                codigo:integer;
                nombre:string[15];
                monto:real;
    end;
    empleado= record
                codigo:integer;
                nombre:string[15];
                monto:real;
    end;
    detalle= file of ingresoemp;
    maestro=file of empleado;
var
   mae:maestro;
   det:detalle;
   regm:empleado;
   regd:ingresoemp;
   codact:integer;
   montototal:real;
begin
     assign(mae, 'maestro');
     assign(det,'detalle');
     reset(mae);
     reset(det);
     while(not eof(det)) do begin
               read(mae, regm);
               read(det,regd);
               while(regm.codigo<>regd.codigo) do begin
                     read(mae,regm);
               end;
               codact:=regd.codigo;
               montototal:=0;
               while(regd.codigo=codact) do begin
                      montototal:=montototal+regd.monto;
                      read(det,regd);
               end;
               regm.monto:=regm.monto + montototal;
               seek(mae, filepos(mae)-1);
               write(mae, regm);
     end;
     close(det);
     close(mae);
end.
