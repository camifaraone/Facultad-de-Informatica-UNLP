procedure eliminar (var mae:archivo);
var
   dni:integer;e:empleado;pos:integer;
begin
     writeln('Ingrese DNI del empleado a eliminar : ');
     readln(dni);
     read(mae,e);
     while not eof(mae) and (e.dni <> dni)do begin
       read(mae,e);
       end;
     if(e.dni = dni)then begin
	    pos:=filepos(mae)-1;
        if eof(mae)then begin
               seek(mae,filepos(mae)-1);
               Truncate(mae);
          end
          else begin
               seek(mae,filesize(mae)-1);
               read(mae,e);
               seek(mae,filepos(mae)-1);
               Truncate(mae);
               seek(mae,pos);
               write(mae,e);
          end;
     end
     else
         writeln('No existe');
end;
