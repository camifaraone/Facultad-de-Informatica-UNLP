
Program ejercicio4;
Uses Crt;
Type
    empleado= record { registro del tipo empleado }
    numero_empleado:integer;
    apellido: string[20];
    nombre: string[20];
    edad: integer;	
    dni: longInt;
    end;

    archivo= file of empleado;

    archivo_txt = file of text;


      // PROCEDURE AND FUNCTION //
Procedure Mostrar (Var e: empleado); { Imprime en pantalla los datos de un empleado }
begin 
  writeln(e.numero_empleado);
  writeln(e.apellido);
  writeln(e.nombre);
  writeln(e.dni);
  writeln(e.edad);
end

Procedure Leer (Var e: empleado); { Imprime en pantalla los datos de un empleado }
begin 
  writeln (" Por favor ingrese su apellido")
  readln(e.apellido);
  while (e.apellido <> ' ') do begin 
    writeln (" Por favor ingrese su numero de empleado")
    readln(e.numero_empleado);
    writeln (" Por favor ingrese su nombre")
    readln(e.nombre);
    writeln (" Por favor ingrese su numero de DNI")
    readln(e.dni);
    writeln (" Por favor ingrese su edad")
    readln(e.edad);
  end;
end;

Procedure CrearArchEmpleado(a :archivo); { Crea un archivo de empleados }
Var
   e: empleado;
Begin
  leer(e);
  reset(a);
  while(e.apellido <> ' ')do begin
    write(a,e);
    leer(e);
  end;
  close(archEmpleado);
End;


Procedure ListadoPersonasConAPEdeterminado(var archEmpleado:archivo;APE:string); { Lista todos los empleados con un apellido igual al pasado como parametro}
Var
   e: empleado;
Begin
    reset(archEmpleado);
    While(not eof(archEmpleado))do begin
       read(archEmpleado,e);
       if (e.apellido = APE )then   
            Mostrar(e);
    end;
    close(archEmpleado);
End;


Procedure ListadoPersonasConNOMdeterminado(var archEmpleado:archivo;NOM:string);{ Lista todas las personas con un nombre igual al pasado por parametro }
Var
   e: empleado;
Begin
    reset(archEmpleado);
    While(not eof(archEmpleado))do begin
       read(archEmpleado,e);
       if (e.nombre= NOM )then   
            Mostrar(e);
    end;
    close(archEmpleado);
End;


Procedure ListadoPersonas(var archEmpleado:archivo);{ Imprime todos los empleados del archivo }
Var
    e: empleado;
Begin
    reset(archEmpleado);
    While(not eof(archEmpleado))do
    begin
       read(archEmpleado,e);
       Mostrar(e);
    end;
    close(archEmpleado);
end;


Procedure ListadoPersonasmayores(var archEmpleado:archivo); { Lista en pantalla todas las personas mayores a 60 años }
Var
    e: empleado;
Begin
    reset(archEmpleado);
    While(not eof(archEmpleado))do begin
       read(archEmpleado,e);
       if (e.edad > 60)then   
          Mostrar(e);
    end;
    close(archEmpleado);
End;


Procedure ModificarEdad(a:archivo);
var
  num:integer;
  e:empleado;
begin
  writeln('Ingrese el numero de empleado a modificar edad');
  readln(num);
  reset(a);
  while (num<>0) do begin
    seek(a,0);
    while (not EOF(a)) do begin
      read(a,e);
      if (e.numero_empleado = num) then begin
          writeln('Ingrese la edad');
          readln(num);
          e.edad:= num;
          seek(a,filepos(a)-1);
          write(a,e);
      end;
    writeln('Ingrese otro numero de empleado : ');
    readln(num);
  end;
  close(arch);
end;

Procedure Agregar (var a:archivo);
var 
  e:persona
begin 
  reset (a);
  seek(a,filesize(a));
  leer(e);
  while (e.apellido <> '') do begin 
    write(a,e);
    leer(e);
  end;
  close(a);
end;

procedure copiarATXT(var a: archivo);
var
  e: empleado;
  nombre_txt: string;
  archivo_txt: text;
begin
  nombre_txt:= 'empleados.txt';
  assign(archivo_txt, nombre_txt);
  reset(a);
  rewrite(archivo_txt);
  write(archivo_txt, 'Listado de empleados');
  while not eof(a) do begin
    read(a,e);
    writeln(archivo_txt, 'Numero de empleado: ', e.numEmpleado);
    writeln(archivo_txt, 'Nombre: ', e.nombre);
    writeln(archivo_txt, 'Apellido: ', e.apellido);
    writeln(archivo_txt, 'DNI: ', e.dni);
    writeln(archivo_txt, 'Edad: ', e.edad);
  end;
  close(archivo);
  close(archivo_txt);
end;

procedure faltaDNI(a: archivo);
var
  e: empleado;
  nombre_txt: string;
  arc_txt: text;
begin
  nombre_txt:= 'faltaDNI.txt';
  assign(arc_txt, nombre_txt);
  reset(a);
  rewrite(arc_txt);
  write(arc_txt, 'Empleados/as que les falta el DNI');
  while not eof(a) do begin
    read(a, e);
    if (e.dni = '00') then begin
        writeln(arc_txt, 'Numero de empleado: ', e.numEmpleado);
        writeln(arc_txt, 'Nombre: ', e.nombre);
        writeln(arc_txt, 'Apellido: ', e.apellido);
        writeln(arc_txt, 'DNI: ', e.dni);
        writeln(arc_txt, 'Edad: ', e.edad);
    end;
   end;
   close(a);
   close(arc_txt);
end;


    //programa principal  //
var 
   archivoEmpleado: archivo; 
   opcion:integer;  
   nombre,apellido:string;





Begin

  writeln('Ingrese el nombre para el archivo'); {punto uno del ejercicio, en el que se crea el archivo}
  readln(nombre);

  assign(archivoEmpleado,nombre);
  rewrite(archivoEmpleado);

  ClrScr;
  CrearArchivo(archivoEmpleado);

  repeat
    writeln('1. Listar datos de personas que tengan un apellido determinado');
    writeln('2. Listar datos de personas que tengan un nombre determinado');
    writeln('3. Listar en pantalla las personas de a una por linea');
    writeln('4. Listar en pantalla las personas mayores de 60 años');
    writeln('5. Añadir uno o mas empleados al final del fichero');
    writeln('6. Modificar edad a una o más empleados');
    writeln('7. Exportar el contenido del archivo a un archivo de texto llamado “empleados.txt');
    writeln('8. Exportar a un archivo de texto llamado: “faltaDNI.txt”, los empleados que no tengan cargado el DNI (DNI en 00).');
    writeln('9. Salir');

    read(opcion);
    case opcion of 
           1: begin
              {Lista en pantalla los datos de empleados que tengan un apellido determinado}
              writeln('Ingrese un apellido');
              readln(apellido);
              ListadoPersonasConAPEdeterminado(archivoEmpleado,apellido);
           end;
           2: begin
              {Lista en pantalla los datos de empleados que tengan un nombre determinado}
              writeln('Ingrese un nombre');
              readln(nombre);
              ListadoPersonasConNOMdeterminado(archivoEmpleado,nombre);
           end;
           3: begin
              {Listar en pantalla los empleados de a uno por línea}
              ListadoPersonas(archivoEmpleado);
           end;
	         4: begin
              {Lista en pantalla empleados mayores de 60 años}
 	            listadodepersonasmayores (archivoEmpleado);
 	         end;
           5: begin
              {añade uno o más empleados al final del archivo}
              Agregar (archivoEmpleado);
           end;
           6: begin
              { modifica la edad de empleado/os}
              ModificarEdad(archivoEmpleado);
           end;
           7: begin
              { Exporta el contenido del archivo a un archivo de texto}
              copiarATXT(archivoEmpleado);
           end;
           8: begin
              {Exporta a un archivo de texto, los empleados que no tengan cargado el DNI  en 00 }
              faltaDNI(archivoEmpleado);
           end;
    end;

  until(opcion=9);

  close (archivoEmpleado);

End.
