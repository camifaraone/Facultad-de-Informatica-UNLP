program ejercicio_7;
uses SysUtils;

const
     vInvalido = 9999;
type
     especie = record
       cod : integer;
       nombre : string;
       familia : string;
       desc : string;
       zona : string;
     end;

    archivo_especies = file of especie ;

procedure leerMaestro (var a : archivo_especies ; var r : especie);
begin
    if (not(eof(a))) then
       read (a,r)
    else
       r.cod := vInvalido;
end;

procedure LeerRegistro (var r : especie);
begin
     writeln ('Leer codigo de la especie');
     readln (r.cod);
     if (r.cod <> 0) then
       begin
         writeln ('Leer nombre de la especie: ');
         readln (r.nombre);
         writeln ('Leer familia de la especie: ');
         readln (r.familia);
         writeln ('Leer descripcion de la especie: ');
         readln (r.desc);
         writeln ('Leer zona de la especie: ');
         readln (r.zona);
       end;
     writeln;
end;

procedure EscribirRegistro ( r : especie);
begin
     writeln ('Codigo de la especie: ',r.cod);
     writeln ('Nombre de la especie: ',r.nombre);
     writeln ('Familia de la especie: ',r.familia);
     writeln ('Descripcion de la especie: ',r.desc);
     writeln ('Zona de la especie: ',r.zona);
end;

procedure crearMaestro (var a : archivo_especies);
var
   r: especie;
begin
     rewrite (a);
     LeerRegistro (r);
       while (r.cod <> 0) do
         begin
           write (a,r);
           LeerRegistro (r);
         end;
     close (a);
end;

procedure escribirMaestro (var a : archivo_especies);
var
   r: especie;
begin
   reset (a);
   leerMaestro (a,r);
   while (r.cod <> vInvalido) do
     begin
       EscribirRegistro (r);
       leerMaestro (a,r);
     end;
   close (a);
end;

procedure darBajas (var m : archivo_especies);
var
   r : integer;
   s : especie;
begin
     reset (m);
     writeln ('Ingrese codigo de especie a eliminar: ');
     readln (r);
     while (r <> 10000) do
       begin
         leerMaestro (m,s);
         while ((s.cod <> vInvalido) and (s.cod <> r)) do leerMaestro (m,s);
         if (s.cod = r) then
           begin
             seek (m,filepos(m) - 1);
             s.cod := -1;
             write (m,s);
           end;
         seek (m,0);
         writeln ('Ingrese otro codigo de especie a eliminar: ');
         readln (r);
       end;
    close(m);
end;

procedure compactarMaestro (var a : archivo_especies);
var
   r, aux : especie;
   pos : integer;
begin
     reset(a);
     leerMaestro (a,r);
     while (r.cod <> vInvalido) do
       begin
         if (r.cod = -1) then
           begin
             pos := filepos(a) - 1;
             seek (a,filesize(a) - 1);
             leerMaestro (a,aux);
             seek (a,filepos(a) - 1);
             while ((aux.cod = -1) and (filepos(a) <> pos)) do
               begin
                 truncate (a);
                 seek (a,filepos(a) - 1);
                 leerMaestro (a,aux);
                 seek (a,filepos(a) - 1);
               end;
             if (filepos(a) = pos) then truncate (a)
             else
               begin
                 truncate (a);
                 seek (a,pos);
                 write (a,aux);
               end
           end;
         leerMaestro (a,r);
       end;
     close (a);
end;

var
   maestro : archivo_especies;
   name : String;
   menu : integer;
begin
     writeln ('Ingrese nombre del archivo maestro para utilizar');
     readln (name);
     Assign (maestro,name);
     writeln ('Seleccione una opcion a seleccionar:');
     writeln ('0 : Termina el Programa');
     writeln ('1 : Crear el archivo maestro');
     writeln ('2 : Listar el archivo maestro');
     writeln ('3 : Dar de baja especies');
     writeln ('4 : Compactar el archivo a uno nuevo');
     readln (menu);

     while (menu <> 0) do

      begin
       if ((menu >= 1) and  (menu < 7)) then
        begin
             case menu of
               1: begin
                    crearMaestro(maestro);
                  end;
               2: begin
                    escribirMaestro(maestro);
                  end;
               3: begin
                    darBajas (maestro);
                  end;
               4: begin
                    compactarMaestro (maestro);
                  end;

        end;
        writeln;
        writeln ('Seleccione una opcion nuevamente');
        readln (menu);
        end
        else
           begin
                writeln ('Numero Incorrecto, Ingrese un numero corespondiente a una opcion');
                readln (menu);
           end;
      end;
end.
