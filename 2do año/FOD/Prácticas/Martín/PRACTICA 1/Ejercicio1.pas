Program Ej1;
Type
    archivo = file of integer;                    {tipo de archivo}

var
   enteros:archivo;                            { enteros  variable de tipo archivo (NOMBRE LOGICO)}
   numero:integer;
   nombre:string;

begin
     writeln ('ingrese el nombre del archivo ');
     readln (nombre);                        {lee de teclado el nombre(el nombre del archivo se debe proporcionar por el usuario)}

     assign (enteros,nombre);                 {realiza una correspondencia entre el archivo logico(enteros) y el archivo fisico(nombre) }
     rewrite (enteros);                       {crea un archivo, con EL NOMBRE LOGICO }

     writeln ('ingrese un numero');
     readln (numero);                         {se cargar numeros de teclado. ARCHIVO FISICO}
     while (numero <> 10000) do begin         { mientras no se ingrese el numero 10000(diez mi) se siguen cargando numeros}

           write(enteros,numero);             {el tipo de dato numero es igual al tipo de datos de los elementos del archivo - (ARCHIVO LOGICO,NUMERO)}

           writeln ('ingrese un numero');
           readln (numero)
     end;

     close (enteros);                         {cierre del archivo. transfiere la informacion del buffer al disco , close(nombre logico) }

     readln();                                {siempre dejar un reglon desp del close}
end.
