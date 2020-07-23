
Program ejercicio3;
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
  writeln (" Por favor ingrese su numero de empleado")
  readln(e.numero_empleado);
  while (e.apellido <> ' ') do begin 
    writeln (" Por favor ingrese su apellido")
    readln(e.apellido);
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
  while(e.apellido <> '')do begin
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



        //programa principal  //
var 
   Empleado: archivo; 
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
    writeln('5. Salir');

    read(opcion);
    case opcion of

           1: begin
              writeln('Ingrese un apellido');
              readln(apellido);
              ListadoPersonasConAPEdeterminado(archivoEmpleado,apellido);
            end;
           2: begin
              writeln('Ingrese un nombre');
              readln(nombre);
              ListadoPersonasConNOMdeterminado(archivoEmpleado,nombre);
            end;
           3: begin
              ListadoPersonas(archivoEmpleado);
            end;
	         4: begin
 	             listadodepersonasmayores (archivoEmpleado);
 	          end;
    end;

  until(opcion=5);

  close (archivoEmpleado);
End.
