program Ejercicio1;
type
    empleado= record
               numEmp: integer;
               ape: String;
               nom: String;
               edad: integer;
               dni: integer;
    end;

    archivo_empleados  = file of empleado;

procedure leoEmpleados( var emp: empleado);
begin
     writeln('ingrese apellido ');
     readln(emp.ape);
     if (emp.ape <> '')then begin
        writeln('ingrese numero de empleado ');
        readln(emp.numEmp);
        writeln('ingrese nombre ');
        readln(emp.nom);
        writeln('ingrese edad ');
        readln(emp.edad);
        writeln('ingrese dni ');
        readln(emp.dni);
     end;
end;

procedure imprimoEmpleado(emp: empleado);
begin
     writeln('Apellido ', emp.ape);
     writeln('Nombre ', emp.nom);
     writeln('Edad ', emp.edad);
     writeln('Numero de empleado ', emp.numEmp);
     writeln('DNI ', emp.dni);
end;

procedure buscoApeNom (var empleados : archivo_empleados);
var
   buscar: String;
   emp: empleado;
begin
     writeln('ingrese apellido a buscar o nombre a buscar ');
     readln(buscar);
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset (empleados);
     while (not EOF (empleados)) do begin
           read(empleados, emp);
           if (emp.ape = buscar) or (emp.nom = buscar) then
              imprimoEmpleado(emp);
           writeln();
     end;
     close(empleados);

end;

procedure muestroEmpleados(var empleados: archivo_empleados);
var
   emp: empleado;
begin
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset (empleados);
     while (not EOF (empleados)) do begin
           read(empleados, emp);
           imprimoEmpleado(emp);
           writeln();
     end;
     close(empleados);
end;

procedure mayor60(var empleados: archivo_empleados);
var
   emp: empleado;
begin
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset (empleados);
     while (not EOF (empleados)) do begin
           read(empleados, emp);
           if (emp.edad > 60) then
              imprimoEmpleado(emp);
           writeln();
     end;
     close(empleados);
end;

procedure generoArchivo (var empleados: archivo_empleados);
var
     nombre_fisico: string[12];
     emp: empleado;
begin
     write('Ingrese el nombre del archivo a crear: ');
     readln(nombre_fisico);
     assign(empleados, nombre_fisico);
     rewrite(empleados);
     leoEmpleados(emp);
     while (emp.ape <> '') do begin
           write(empleados, emp);
           leoEmpleados(emp);
     end;
     close(empleados);
end;

procedure agregarEmpleados(var empleados: archivo_empleados);
var
   emp: empleado;
begin
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset(empleados);
     seek( empleados, filesize(empleados));
     leoEmpleados(emp);
     while (emp.ape <> '') do begin
           write(empleados, emp);
           leoEmpleados(emp);
     end;
     close(empleados);
end;

procedure modificarEdad(var empleados: archivo_empleados);
var
   edad: integer;
   numero: integer;
   emp: empleado;
begin
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset(empleados);
     writeln('Ingrese numero de empleado al que quiere cambiarle la edad ');
     readln(numero);
     while (not EOF (empleados)) do begin
           read(empleados, emp);
           if (numero = emp.numEmp) then begin
              writeln('Ingrese nueva edad para el empleado ', emp.nom, ' ', emp.ape);
              readln(edad);
              seek( empleados, filepos(empleados) -1 );
              emp.edad := edad;
              write( empleados, emp);
           end;
     end;
     writeln();
     close(empleados);
end;

procedure exportarAtxt(var empleados: archivo_empleados);
var
   emp:empleado;
   carga: text;
begin
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset(empleados); {abre archivo binario}
     assign(carga, 'empleados.txt');
     rewrite(carga);

     while (not eof(empleados)) do begin
           read(empleados, emp);
           With emp do
                writeln(carga, 'Apellido ', emp.ape, ', Nombre ', emp.nom, ', Edad ', emp.edad, ', DNI ', emp.dni, ', Num Emp ', emp.numEmp);
     end;
     writeln();
     close(empleados);
     close(carga);
end;

procedure exportarSinDNI(var empleados: archivo_empleados);
var
   emp:empleado;
   carga: text;
begin
     //como ya cree el archivo, levanto directamente con el nombre que le puse en el archivo fisico, en vez de nombre_fisico
     assign(empleados, 'archEmpleados');
     reset(empleados); {abre archivo binario}
     assign(carga, 'faltaDNI.txt');
     rewrite(carga);

     while (not eof(empleados)) do begin
           read(empleados, emp);
           if (emp.dni = 00) then
              With emp do
                   writeln(carga, 'Apellido ', emp.ape, ', Nombre ', emp.nom, ', Edad ', emp.edad, ', DNI ', emp.dni, ', Num Emp ', emp.numEmp);
     end;
     writeln();
     close(empleados);
     close(carga);
end;

procedure truncar(var empleados: archivo_empleados; var empleados2: archivo_empleados);
var
   e:empleado;
begin
     reset(empleados);
     assign(empleados2,'maestroNuevoEj1P3');
     rewrite(empleados2);
     while(filepos(empleados) <> filesize(empleados)-2)do begin
           read(empleados,e);
           write(empleados2,e);
     end;
     close(empleados2);
end;

procedure baja(var empleados: archivo_empleados; var empleados2: archivo_empleados);
var
   dni:integer;
   e:empleado;
   pos:integer;
begin
     reset(empleados);
     writeln('Ingrese DNI del empleado a eliminar : ');
     readln(dni);
     read(empleados,e);
     while((not EOF(empleados))and(e.dni<>dni))do begin//busco al tipo por dni
       read(empleados,e);
       //pos:=filepos(empleados)-1;//porque automaticamente se mueve en 1 al leer
     end;
     pos:=filepos(empleados)-1;//porque automaticamente se mueve en 1 al leer
     if(e.dni=dni)then begin
          writeln('encontro por dni');
          readln();
          if(EOF(empleados))then begin//si se dio la coincidencia de ser el ultimo reg
               //seek(empleados,filepos(empleados)-1);
               writeln('es el ultimo registro del maestro original');
               readln();
               truncar(empleados, empleados2);
          end else
          begin
               writeln('esta en el medio del archivo original');
               readln();
               seek(empleados,filesize(empleados)-1);//me posiciono en el ultimo reg
               read(empleados,e);//agarro el reg
               //seek(empleados,filepos(empleados)-1)
               //truncar(empleados, empleados2);//muevo el EOF
               seek(empleados,pos);//me vuelvo a la pos del reg que debo borrar
               write(empleados,e);//sobreescribo
               truncar(empleados, empleados2);
          end;
     writeln('registro borrado correctamente ');
     readln();
     end else
     writeln('No existe');
     close(empleados);
     readln();
end;




//principal
var
  	 empleados: archivo_empleados;
     empleados2: archivo_empleados;
     opcion : integer;
begin
     repeat
           writeln('Ingrese 1 para generar un nuevo archivo ');
           writeln('Ingrese 2 para buscar empleado por apellido o nombre en archivo existente ');
           writeln('Ingrese 3 para mostrar todos los empleados en archivo existente ');
           writeln('Ingrese 4 para buscar empleados mayores a 60 años en archivo existente ');
           writeln('Ingrese 5 para agregar empleados a archivo existete');
           writeln('Ingrese 6 para modificar la edad de los empleados ');
           writeln('Ingrese 7 para exportar archivo a .txt ');
           writeln('Ingrese 8 para exportar aquellos que tengan dni 00 ');
           writeln('Ingrese 9 para eliminae registro');
           writeln('Ingrese 10 para salir del menu ');
           readln(opcion);
           case opcion of
                1: begin
                   generoArchivo(empleados);
                end;
                2: begin
                   buscoApeNom(empleados);
                end;
                3: begin
                   muestroEmpleados(empleados);
                end;
                4: begin
                   mayor60(empleados);
                end;
                5: begin
                   agregarEmpleados(empleados);
                end;
                6: begin
                   modificarEdad(empleados);
                end;
                7: begin
                   exportarAtxt(empleados);
                end;
                8: begin
                   exportarSinDNI(empleados);
                end;
                9: begin
                   baja(empleados, empleados2);
                   muestroEmpleados(empleados2);
                end;
           end;
     until (opcion = 10);
end.


