{ - - - - - - - - - - - - - - - - - ENUNCIADO - - - - - - - - - - - - - - - - -}
Se dispone de una lista con la información de archivos almacenados en un
pendrive. De cada archivo se conoce: nº de archivo, fecha de creación, fecha de
última actualización, extensión y tamaño (expresado en KB). Esta estructura no
posee orden alguno.

a) En base a la lista que se dispone, generar una nueva estructura que contenga
dos campos: tamaño (expresado en KB), y una lista con la información de los
archivos que poseen dicho tamaño. Esta nueva estructura debe ser eficiente para
realizar búsquedas y debe estar ordenada por tamaño.

b) Una vez generada la estructura del inciso a) se pide:
i. Realizar un módulo que reciba la estructura generada en el punto a), un
tamaño y un nº de archivo y elimine dicho archivo si existe.
ii. Calcular e informar la cantidad de archivos cuyo tamaño es mayor que 1.024KB
y menor a 102.400KB.
{ - - - - - - - - - - - - - - - - - ENUNCIADO - - - - - - - - - - - - - - - - -}



Program Parcial_2º;
type
                   { - - - - INICIO ESTRUTURAS - - - - }
  lista_archivos = ^nodo;
  nodo = record
    datos:archivo;
    sig:lista_archivos;
  end;
  archivo = record                           // LISTA QUE SE DISPONE
              nro: integer;
              fecha_creacion: string;
              fecha_act: string;
              extension: string;
              tamaño: real;
  end;


  arbol = ^nodo_arbol;
  nodo_arbol = record
                 izq: arbol;
                 der: arbol;                  // ARBOL QUE HAY QUE GENERAR
                 tam: real;                   // PARA EL PUNTO A.-
                 L_A: L_arch;
  end;

  L_arch = ^nodo;
  nodo = record
           dato: reg;
           sig: L_arch;
  end;
  reg = record                               // LISTA DEL ARBOL.-
          nro: integer;
          fecha_creacion: string;
          fecha_act: string;
          extension: string;
  end;
                   { - - - - FIN ESTRUTURAS - - - - }



                   { - - - - INICIO MODULO GENERAR_ESTRUCTURA - - - - }
procedure GENERAR_ESTRUCTURA (L:lista_archivos; var A:arbol);
begin
  while (L <> NIL) do begin
    INSERTAR_EN_ARBOL (L^.datos,A);
    L:= L^.sig;
  end;
end;
                   { - - - - FIN MODULO GENERAR_ESTRUCTURA - - - - }

















                   { - - - - INICIO MODULO INSERTAR_EN_ARBOL - - - - }
procedure INSERTAR_EN_ARBOL (ar:archivo; var A:arbol);
begin
  if (A = NIL) then begin
    new (A);
    A^.izq:= NIL;
    A^.der:= NIL;
    A^.L_A:= NIL;
    A^.tam:= ar.tamaño;
    INSERTAR_LISTA (ar,A^.L_A);
  end;
  else
    if (A^.tam < ar.tamaño) then
      INSERTAR_EN_ARBOL (ar,A^.der);
    else
      if (A^.tam > ar.tamaño) then
        INSERTAR_EN_ARBOL (ar,A^.izq);
      else
        // Si es igual
        INSERTAR_LISTA (ar,A^.L_A);
end;
                   { - - - - FIN MODULO INSERTAR_EN_ARBOL - - - - }


                   { - - - - INICIO MODULO INSERTAR_LISTA - - - - }
procedure INSERTAR_LISTA (ar:archivo; var L:L_arch);
var
  nue:L_arch;
begin                                     // MODULO QUE INSERTA ADELANTE.-
  new (nue);
  nue^.dato.nro:= ar.nro;
  nue^.dato.fecha_creacion:= ar.fecha_creacion;
  nue^.dato.fecha_act:= ar.fecha_act;
  nue^.dato.extension:= ar.extension;
  nue^.sig:= L;
  L:= nue;
end;
                   { - - - - FIN MODULO INSERTAR_LISTA - - - - }



                   { - - - - INICIO MODULO_i - - - - }
procedure MODULO_i (var A:arbol; tam_arch:real; nro_arch:integer);
begin
  if (A = NIL); then
    write ('No se encontro el tamaño del archivo.-');
  else
    if (A^.tam < tam_arch) then
      MODULO_i (A^.der,tam_arch,nro_arch)
    else
      if (A^.tam > tam_arch) then
        MODULO_i (A^.izq,tam_arch,nro_arch)
      else
        // Si es igual, entro a la lista y busco el nro. de archivo.-
        BUSCAR_y_BORRAR (A^.L_A,nro_arch);
end;
                   { - - - - FIN MODULO_i - - - - }









                   { - - - - INICIO MODULO BUSCAR_y_ELIMINAR - - - - }
procedure BUSCAR_y_BORRAR (var L:L_arch; nro_arch:integer);
var
  act: L_arch;
  ant: L_arch;
begin
  ant:= L;
  act:= L;
  while (act <> NIL) and (act^.dato.nro <> nro_arch) do begin
    ant:= act;
    act:= act^.sig;
  end;
  if (act = NIL) then
    write ('No existia numero del archivo a ser eliminado en la lista.-');
  else
    if (act = L) then
      L:= act^.sig;               // Era el 1er. nodo a eliminar
    else
      ant^.sig:= act^.sig;        // Era al medio o al final.-
    dispose (act);
    write ('El archivo fue eliminado correctamente.-');
end;
                   { - - - - FIN MODULO BUSCAR_y_ELIMINAR - - - - }


                   { - - - - INICIO MODULO_ii - - - - }
procedure MODULO_ii (A:arbol; lim_inf:real; lim_sup:real; var cant_arch:integer);
// BUSQUEDA ACOTADA.-
begin
  if (A^.tam > lim_inf) then
    if (A^.tam < lim_sup) then begin
      cant_arch:= cant_arch + CONTAR_NODOS (A^.L_A)
      MODULO_ii (A^.izq,lim_inf,lim_sup,cant_arch);
      MODULO_ii (A^.der,lim_inf,lim_sup,cant_arch);
    end
    else
      MODULO_ii (A^.izq,lim_inf,lim_sup,cant_arch);
  else
    MODULO_ii (A^.der,lim_inf,lim_sup,cant_arch);

end;
                   { - - - - FIN MODULO_ii - - - - }



                   { - - - - INICIO MODULO CONTAR_NODOS - - - - }
function CONTAR_NODOS (L:L_arch):integer;
begin
  if (L = NIL) then
    CONTAR_NODOS:= 0;
  else
    CONTAR_NODOS:= CONTAR_NODOS (L^.sig) + 1;
end;
                   { - - - - FIN MODULO CONTAR_NODOS - - - - }











// PROGRAMA PRINCIPAL
var
  L: lista_archivos;
  A: arbol;
  tam_arch: real;
  nro_arch: integer;
  lim_inf: real;
  lim_sup: real;
  cant_arch: integer;
begin
  L:= NIL;
  A:= NIL;
  tam_arch:= 300;       // INICIALIZO EN CUALQUIER VALOR.-
  nro_arch:= 25;        // INICIALIZO EN CUALQUIER VALOR.-
  lim_inf:= 1024;
  lim_sup:= 102400;
  cant_arch:= 0;

  CARGAR_LISTA (L);  // SE DISPONE.-
  GENERAR_ESTRUCTURA (L,A);
  MODULO_i (A,tam_arch,nro_arch)
  MODULO_ii (A,lim_inf,lim_sup,cant_arch);
  write ('Cantidad de archivos entre',lim_inf,'y',lim_sup,'es de : ',cant_arch);
end.

