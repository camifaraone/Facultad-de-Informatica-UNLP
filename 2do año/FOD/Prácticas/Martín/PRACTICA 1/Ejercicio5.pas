program Ejercicio5;
type
    electrodomestico = record
          codelectro:integer;
          nombre:string[30];
          desc: string[30];
          precio: integer;
          Stockmin:integer;
          StockDisp:integer;
     end;

     archivo = file of electrodomestico;

  {------------PROCEDURE AND FUNCTION-------------}


procedure cargar(var arch:archivo);
var
   carga:text;
   f:electrodomestico;
begin
     Assign(carga,'carga.txt');
     reset(carga);
     while not EOF(carga) do begin
        with f do begin                                    {el whit es para acceder a cada campo del registro!!!}
          readln(carga,codelectro,precio,nombre);
          readln(carga,StockDisp,Stockmin,desc);
        end;
        write(arch,f);
     end;
     close(carga);
end;

procedure menorstock(var arch:archivo);
var
   f:electrodomestico;
begin
     while (not EOF(arch)) do begin
        read(arch,f);
        if (f.StockDisp<f.stockmin) then
            writeln('El electrodomestico ',f.nombre,' Tiene un stock inferior al minimo ');
     end;
end;

procedure buscadesc(var arch:archivo);
var
   f:electrodomestico;
begin
     while (not EOF(arch)) do begin
        read(arch,f);
        if (f.desc<>'') then
          writeln('El Electrodomestico ',f.nombre,' tiene la siguiente descripcion dada por el usuario ',f.desc);
     end;
end;

procedure exportar(var arch:archivo);
var
   f:electrodomestico;
   expo:text;
begin
  assign(expo,'electro.txt');
  rewrite(expo);

  while (not EOF(arch)) do begin
    read(arch,f);
    with f do
        writeln(expo,'Codigo de electrodomestico : ',codelectro,' Nombre : ',nombre,' Descripcion del usuario : ',desc,' Precio ',precio,' Stock Minimo : ',Stockmin,' Stock Disponible : ',StockDisp)
  end;
  close(expo);
end;


  {------------PROGRAMA PRINCIPAL--------------}  
var 
   nom:string;
   electros: archivo;
   c : integer; 
   opcion:integer;  

Begin
   writeln('Ingrese el nombre del archivo : ');
   readln(nom);
   assign(electros,nom);

  repeat
    writeln('Opcion 1: crear archivo de electrodomesticos!');
    writeln('Opcion 2: ver en pantalla cuales electrodomesticos tiene un stock disponible inferior al stock minimo');
    writeln('Opcion 3: buscar los electrodomesticos con descripciones puestas por los usuarios');
    writeln('Opcion 4: exportar los electrodomesticos a electro.txt');

    read(opcion);
    case opcion of 
        1 :begin
               writeln('Iniciando la carga... Please wait');
               rewrite(electros);
               cargar(electros);
               close(electros);
           end;
        2 :begin
                writeln('Buscando.....');
                reset(electros);
                menorstock(electros);
                close(electros);
           end;
        3 :begin
                writeln('Buscando.... please wait');
                reset(electros);
                buscadesc(electros);
                close(electros);
           end;
        4 :begin
                writeln('Iniciando exportacion.... please wait');
                reset(electros);
                exportar(electros);
                close(electros);
           end;
    end;   
        
  until(opcion=5);

  close (electros);

End.

