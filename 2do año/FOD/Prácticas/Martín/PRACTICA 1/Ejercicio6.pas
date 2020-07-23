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

{-----------------parte del 6------------------}

procedure leer(var f:electrodomestico);
begin
  with f do begin
      writeln('Ingrese el nombre del electrodomestico');
      readln(nombre);

      if (nombre<>'') then begin
        writeln('Ingrese el codigo del electrodomestico : ');
        readln(codelectro);
        writeln('Ingrese la descripcion del electrodomestico : ');
        readln(desc);
        writeln('Ingrese el precio del electrodomestico : ');
        readln(precio);
        writeln('Ingrese el stock minimo');
        readln(Stockmin);
        writeln('Ingrese el stock disponible');
        readln(StockDisp);
      end;
  end;
end;

procedure agregar(var arch:archivo);          
var
   f:electrodomestico;
begin
     seek(arch,filesize(arch));    //me pongo en EOF
     leer(f);
     while (f.nombre<>'') do begin
        write(arch,f);
        leer(f);
     end;
end;


procedure modif(var arch:archivo);
var
   nom:string;
   ok:boolean;
   f:electrodomestico;
begin
  ok:=true;
  writeln('Ingrese el nombre del electrodomestico al cual le desea cambiar el stock : ');
  readln(nom);

  while (nom<>'')  do begin         
      while ((not EOF(arch))and (ok = true)) do begin
        read(arch,f);
        if (f.nombre=nom) then begin     
          writeln('Ingrese el numero de Stock : ');
          readln(f.StockDisp);
          seek(arch,filepos(arch)-1);
          write(arch,f);
          ok:= false;
        end;
      end;
      writeln('Ingrese otro electrodomestico : ');
      readln(nom);
      ok:= true;
  end;
end;

procedure stockcero(var arch:archivo);
var
   texto:text;
   f:electrodomestico;
begin
    assign(texto,'sinstock.txt');
    rewrite(texto);

    while(not EOF(arch)) do begin
      read(arch,f);
      if (f.StockDisp = 0) then
        write(texto,'El electrodomestico : ',f.nombre, ' se encuentra sin stock')
    end;
    close(texto);
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
    writeln('Opcion 5: agregar un nuevo electrodomestico al archivo');
    writeln('Opcion 6: modificar el stock de algun electrodomestico');
    writeln('Opcion 7: exportar los electrodomesticos sin stock a un txt');
    writeln('Opcion 8: salir');
    
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
        5 :begin
                writeln('Iniciando la carga');
                reset(electros);
                agregar(electros);
                close(electros);
           end;
        6 :begin
                writeln('plese wait...');
                reset(electros);
                modif(electros);
                close(electros);
           end;
         7:begin
                writeln('Escaneando.... please wait');
                reset(electros);
                stockcero(electros);
                close(electros);
           end;
    end;   
        
  until(opcion=8);

  close (electros);

End.