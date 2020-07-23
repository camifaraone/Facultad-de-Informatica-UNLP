Program Medicamentos;

Uses CRT;

Type
	medicamento = record
		nombre: string[20];
		presentacion: string[50];
		fechaVto: integer;
		stock: integer;
	end;

	archivo_medicamentos = file of medicamento;


    { Importa un archivo de texto a un archivo binario }
    procedure importar (VAR A: archivo_medicamentos; VAR T: text);
    var
        reg: medicamento;
    begin
        rewrite(A);
        reset(T);
        while not(EOF(T)) do begin
            readln(T, reg.nombre);
            readln(T, reg.fechaVto, reg.stock, reg.presentacion);
            write(A, reg);
        end;
        close(A);
        close(T);
    end;


    { Exporta un archivo binario a un archivo de texto }
    procedure exportar (VAR A: archivo_medicamentos; VAR T: text);
    var
        reg: medicamento;
    begin
        reset(A);
        rewrite(T);
        while not(EOF(A)) do begin
            read(A, reg);
            writeln(T, reg.nombre);
            writeln(T, reg.fechaVto, reg.stock, reg.presentacion);
        end;
        close(A);
        close(T);
    end;


var
   opc: Byte;
   nombre: string;
   A: archivo_medicamentos;
   T: text;
begin
     WriteLn('MEDICAMENTOS');
     WriteLn;
     WriteLn('1. Importar archivo');
     WriteLn('2. Exportar archivo');
     WriteLn('0. Salir');
     Window(1,7,80,22);
     Repeat
        Write('Ingrese opcion: ');
        ReadLn(opc);
        Case opc of
            1: begin
                writeln;
                write('Ingrese el nombre del archivo binario: ');
                readln(nombre);
                assign(A, nombre);
                write('Ingrese el nombre del archivo de texto a importar: ');
                readln(nombre);
                assign(T, nombre + '.txt');
                importar(A, T);
            end;
            2: begin
                writeln;
                write('Ingrese el nombre del archivo binario: ');
                readln(nombre);
                assign(A, nombre);
                write('Ingrese nombre del archivo de texto a exportar: ');
                readln(nombre);
                assign(T, nombre + '.txt');
                exportar(A, T);
            end;
        end;
        ClrScr;
     until
        opc=0;

     {NOTA: en caso de inconvenientes al realizar el assign, utilizar el path completo al archivo.}
end.


