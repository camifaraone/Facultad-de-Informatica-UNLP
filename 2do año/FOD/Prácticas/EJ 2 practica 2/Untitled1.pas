program ej_2;
const
     valorAlto=9999;

type
    alumno=record
           codigo:integer;
           nombre:string[20];
           conFinal:integer;
           sinFinal:integer;
           apellido:string[20];
    end;
    materia=record
            codigo:integer;
            informacion:string[10];
    end;


    maestro=file of alumno;
    detalle=file of materia;

procedure CrearMaestro(var mae:maestro;var a:text);
var
al:alumno;
begin
     rewrite(mae);
     reset(a);
     while (not eof(a)) do
     begin
          readln(a,al.codigo,al.nombre);
          readln(a,al.conFinal,al.sinFinal,al.apellido);
          write(mae,al);
     end;
     close(a);
     close(mae);

end;
procedure CrearDetalle(var det:detalle;var b:text);
var
   mat:materia;
begin
     rewrite(det);
     reset(b);
     while (not eof(b)) do
     begin
          readln(b,mat.codigo,mat.informacion);
          write(det,mat);
     end;
     close(b);
     close(det);

end;

procedure ListarMaestro(var mae:maestro;var c:text);
var
al:alumno;
begin
     rewrite(c);
     reset(mae);
     while (not eof(mae)) do
     begin
          read(mae,al);
          writeln(c,al.codigo,al.nombre);
          writeln(c,al.conFinal,al.sinFinal,al.apellido);

     end;
     close(c);
     close(mae);

end;
procedure ListarDetalle(var det:detalle;var d:text);
var
   mat:materia;
begin
     rewrite(det);
     reset(d);
     while (not eof(d)) do
     begin

          read(det,mat);
          writeln(d,mat.codigo,mat.informacion);
     end;
     close(d);
     close(det);

end;

procedure leer(var det:detalle;var mat:materia);
begin
     if(not eof(det))then

          read(det,mat)
     else
         mat.codigo:=valorAlto;
end;

procedure actualizarMaestro(var mae:maestro;var det:detalle);
var
   al:alumno;mat:materia;
begin
     reset(mae);
     reset(det);
     leer(det,mat);
     while(mat.codigo<>valorAlto)do
     begin
          read(mae,al);
          while(mat.codigo<>al.codigo)do
               read(mae,al);
          while(mat.codigo=al.codigo)do
          begin
               if(mat.informacion=' cursada')then
                     al.conFinal:=al.conFinal+1
               else
                   al.sinFinal:=al.sinFinal +1;
               leer(det,mat);
          end;
          seek(mae, filePos(mae)-1);
          write(mae,al);
     end;
     close(mae);
     close(det);
end;

procedure ListarMaestroFinal(var mae:maestro;var e:text);
var
al:alumno;
begin
     rewrite(e);
     reset(mae);
     while (not eof(mae)) do
     begin

          read(mae,al);
          if(al.sinFinal<4)then
          begin
               writeln(e,al.codigo,al.nombre);
               writeln(e,al.conFinal,al.sinFinal,al.apellido);
          end;
     end;
     close(e);
     close(mae);

end;


var
   al:alumno; mat:materia; mae:maestro; det:detalle; a,b,c,d,e:text;
   nombre:string[20]; menu:char;

begin
     assign(a,'C:\Users\Cami Faraone\Desktop\alumnos.txt');assign(b,'C:\Users\Cami Faraone\Desktop\detalle.txt');assign(c,'C:\Users\Cami Faraone\Desktop\reporteAlumno.txt');assign(d,'C:\Users\Cami Faraone\Desktop\reporteDetalle.txt');  assign(e,'C:\Users\Cami Faraone\Desktop\todos.txt');
     writeln('Ingrese a: Crear archivo maestro');
     writeln('Ingrese b: Crear archivo detalle');
     writeln('Ingrese c: Listar maestro');
     writeln('Ingrese d: Listar detalle');
     writeln('Ingrese e: Actualizar maestro');
     writeln('Ingrese f: Listar maestro con cursadas sin aprobar');
     writeln('Ingrese g: Salir');

     repeat
           readln(menu);
           case menu of
                'a': begin
                          writeln('ingrese el nombre del archivo maestro');
                          readln(nombre);
                          assign(mae,nombre);
                          crearMaestro(mae,a)
                     end;
                 'b': begin
                          writeln('ingrese el nombre del archivo detalle');
                          readln(nombre);
                          assign(det,nombre);
                          crearDetalle(det,b)
                     end;
                 'c': begin
                           writeln('ingrese el nombre del archivo maestro a listar');
                          readln(nombre);
                          assign(mae,nombre);
                          listarMaestro(mae,c)

                      end;
                   'd':begin
                           writeln('ingrese el nombre del archivo detalle a listar');
                          readln(nombre);
                          assign(det,nombre);
                          listarDetalle(det,d)

                          end;
                    'e':begin
                           writeln('ingrese el nombre del archivo maestro a acutualizar');
                          readln(nombre);
                          assign(mae,nombre);
                          actualizarMaestro(mae,det)

                          end;

                    'f':  begin
                           writeln('ingrese el nombre del archivo maestro a listar con final aprobado');
                          readln(nombre);
                          assign(mae,nombre);
                          listarMaestroFinal(mae,e)

                          end;
                    'g': writeln('Programa teriminado')

                    else writeln('opcion incorrecta')
                    end;

     until(menu='g')
end.
