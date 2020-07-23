program siete;
Type
  novela = record
    codnov : integer;
    nombre: string;
    genero: string;
    precio: integer;
  end;

  archivo = file of novela;

Procedure cargar(var arch:archivo; var carga:text);
var
  f:novela;
begin
  rewrite(carga);
  while not EOF(carga) do begin
    with f do begin
      read(carga,codnov,genero,precio);
      read(carga,nombre);
    end;
    write(arch,f);
  end;
  close(carga);
end;

procedure leerN(var f:novela);
begin
  writeln('Ingrese codigo de novela');
  read(f.codnov);
  if(f.codnov<>-1) then begin
    writeln('ingrese genero');
    readln(f.genero);
    writeln('ingrese precio');
    readln(f.precio);
    writeln('ingrese nombre');
    readln(f.nombre);
  end;
end;

Procedure agregar(var arch:archivo);
var
   f:novela;
begin
  seek(arch,filesize(arch));
  leerN(f);
  while (f.codnov<>-1) do begin
    write(arch,f);
    leerN(f);
  end;
end;

procedure modif(var arch:archivo);
var
   nom:string;
   ok:boolean;
   n:novela;
begin
  ok:=true;
  writeln('Ingrese el nombre de la novela la cual desea cambiar : ');
  readln(nom);

  while (nom<>'')  do begin         
      while ((not EOF(arch))and (ok = true)) do begin
        read(arch,n);
        if (n.nombre = nom) then begin     
          writeln('Ingrese la novela : ');
          leerN (n);
          seek(arch,filepos(arch)-1);
          write(arch,n);
          ok:= false;
        end;
      end;
      writeln('Ingrese otro electrodomestico : ');
      readln(nom);
      ok:= true;
  end;
end;

 {----------------programa principal--------------------------}

var
   nom:string;
   nov:archivo;
   c:integer;
   carga:text;
begin

  writeln('Ingrese el nombre del archivo');
  readln(nom);
  assign(nov,nom);

  assign(carga,'novelas.txt');
      
  repeat 
     writeln('Opcion 1: crear el archivo apartir del archivo novelas.txt');
     writeln('Opcion 2: agregar novela');
     writeln('Opcion 3: modificar novela');
     writeln('Opcion 4: salir');

     readln(c);
     case c of
          1 :begin
                 writeln('Cargando..........');
                 rewrite(nov);
                 cargar(nov,carga);
                 close(nov);
             end;
          2 :begin
                  writeln('ingrese datos');
                  reset(nov);
                  agregar(nov);
                  close(nov);
             end;
          3: begin
            restet (nov);
            modif (nov);
            close (nov);
          end;
     end;
  
  until(opcion=4);

  close (nov);

end.