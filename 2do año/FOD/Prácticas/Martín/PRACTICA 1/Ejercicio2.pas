Program Ej2;
Type
    archivo = file of integer;                    {tipo de archivo}

var
   enteros:archivo;                            { enteros  variable de tipo archivo (NOMBRE LOGICO)}
   numero:integer;
   nombre:string;
   cant:integer;
   promedio:real;

begin
     cant:= 0;
     ingresados:=0;
     promedio:=0;

     writeln ('ingrese el nombre del archivo ');
     readln (nombre);                            {lee de teclado el nombre(el nombre del archivo se debe proporcionar por el usuario)}

     assign (enteros,nombre);                    {realiza una correspondencia entre el archivo logico(enteros) y el archivo fisico(nombre) }
     reset(enteros);                             { abre un archivo existente. EL EJEMPLO 1}


     while (not EOF(enteros)) do begin          { EOF(NOMBRE LOGICO) controla el fin del archivo. mientras no termine los numeros enteros (q no haya puesto 10000)}

           readln (enteros, numero);			{ lee un numero del archivo}

           if (numero < 1000) then
              cant:= cant + 1;                  {LA CANTIDAD MENOR A MIL }

           writeln(numero);                     {al ser un RESET, SOLO SE ESCRIBE EL NUMERO INGRESADO}
     end;

     promedio:=filesize(enteros)/cant;              {filesize es el tamaño del archivo q lo divido por la cantidad}

     writeln ('la cantidad de numeros menores a mil son:',cant);
     writeln ('el promediode num menores a mil ingresado por teclado es:',promedio);


     close (enteros);                         {cierre del archivo. transfiere la informacion del buffer al disco , close(nombre logico) }

     readln();                                {siempre dejar un reglon desp del close}
end.
