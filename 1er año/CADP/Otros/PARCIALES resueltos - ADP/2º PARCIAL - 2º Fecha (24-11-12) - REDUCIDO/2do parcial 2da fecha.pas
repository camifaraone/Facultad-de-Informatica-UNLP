                              {EJ.2 - P17}
{------------------------------------------------------------------------------}
TAD Tinvitado
  Interface
    type export invitado;
      procedure crearInvitado (var i:invitado; nombre:string, apellido:string, distancia:string, es_familiar:boolean);
{Crea un invitado con la informacion recibida como parámetro. "Distancia" representa a cuántos kilometros está el invitado del salón de fiestas y "es_familiar" representa si el invitado es familiar o no de Fernandito}
      function verDistancia (i:invitado):integer;
{Retorna la distancia en km al salon de fiestas}
      function verFamiliar (i:invitado):boolean;
{Retorna true si el invitado es familiar de Fernandito}
      procedure VerApellido(i:invitado, Var apellido:string);
{Devuelve el apellido del invitado}

{------------------------------------------------------------------------------}
Se acerca el cumpleaños de Fernandito y está organizando su fiesta, para ello
dispone de una lista siemple con la información de los invitados (tipo exportado
del TAD) ordenada por apellido del invitado (tener en cuenta que puede haber
varios invitados con el mismo apellido)

Realizar un programa que:
  A) Genere a partir de la estructura disponible una nueva estructura que
  contenga por cada distancia en km al salón de fiestas, la cantidad de
  invitados que son familiares de Fernandito. Esta estructura debe estar
  ordenada por distancia en km y debe ser eficiente para la busqueda por dicho
  criterio.
Una vez generada la estructura del punto A, se pide:
  B) Realizar un modulo que calcule eficientemente la cantidad total de
  invitados que son familiares de Fernandito y que se encuentran a menos de
  150km de distancia del salon de fiestas.
{------------------------------------------------------------------------------}

Program Ej_Parcial;
uses Tinvitado
type
  lista = ^nodo;
  nodo = record
           dato:invitado;  // Del tipo exportado.-
           sig:lista;
  end;

  arbol = ^nodo_arbol;
  nodo_arbol = record
                 km:integer;
                 cant_invitados:integer;
                 hi: arbol;
                 hd:arbol;
  end;




            { - - - - INICIO MODULO INSERTAR_EN_ARBOL - - - - }
procedure INSERTAR_EN_ARBOL (var A:arbol; i:invitado);
begin                                    {del tipo exportado !!!}
  if (A = NIL) then begin
    new (A);
    A^.hi:= NIL;
    A^.hd:= NIL;
    A^.cant_invitados:= 0;     // Inicializo en 0 el contador..!!
    A^.km:= verDistancia (i);
    if (verfamiliar (i) = TRUE) then
      A^.cant_invitados:= A^.cant_invitados + 1;
  end
  else
    if (verDistancia (i) < A^.km < ) then
      INSERTAR_EN_ARBOL (A^.hi,i)
    else
      if (verDistancia (i) > A^.km < ) then
        INSERTAR_EN_ARBOL (A^.hd,i)
      else
        if (verfamiliar (i) = TRUE) then
          A^.cant_invitados:= A^.cant_invitados + 1;
end;
            { - - - - FIN MODULO INSERTAR_EN_ARBOL - - - - }


           { - - - - INICIO MODULO GENERAR_ESTRUCTURA - - - - }
procedure GENERAR_ESTRUCTURA (L:lista; var A:arbol);
begin
  while (L <> NIL) do begin
    INSERTAR_EN_ARBOL (A,L^.dato);
    L:= L^.sig;
  end;
end;
           { - - - - FIN MODULO GENERAR_ESTRUCTURA - - - - }



           { - - - - INICIO MODULO RECORRER_ARBOL - - - - }
procedure Cantidadtotal (A:arbol; var cant:integer)
begin                                                       
  if (A <> NIL) then
    if ( A^.km < 150) then begin
      cant:= cant + A^.cant_invitados
      Cantidadtotal (A^.hi,cant)
      Cantidadtotal A^.hd,cant);
    end
    else
      Cantidadtotal (A^.hi,cant)
end;
           { - - - - FIN MODULO RECORRER_ARBOL - - - - }





// PROGRAMA PRINCIPAL.-
var
  L:lista;
  A:arbol;
  cant:integer;
begin
  L:= NIL;
  A:= NIL;
  cant:= 0; (me olvide de inicializar cant en el programa principal del parcial! jaja)
  CARGAR_LISTA (L);  // No se implementa, SE DISPONE.-
  GENERAR_ESTRUCTURA (L,A);
  Cantidadtotal (A,cant);
  write ('La cantidad de invitados que son familiares de Fernandito y que se encuentran a menos de 150km es:', cant);
end.




                          - - - - - - - - - - -
                          {MAS EFICIENTE - SOLO FAMILIARES}

            { - - - - INICIO MODULO INSERTAR_EN_ARBOL - - - - }
procedure INSERTAR_EN_ARBOL (var A:arbol; i:invitado);
begin                                    {del tipo exportado !!!}
  if (A = NIL) then begin
    new (A);
    A^.hi:= NIL;
    A^.hd:= NIL;
    A^.cant_invitados:= 0;     // Inicializo en 0 el contador..!!
    A^.km:= verDistancia (i);
    A^.cant_invitados:= A^.cant_invitados + 1;
  end
  else
    if (verDistancia (i) < A^.km < ) then
      INSERTAR_EN_ARBOL (A^.hi,i)
    else
      if (verDistancia (i) > A^.km < ) then
        INSERTAR_EN_ARBOL (A^.hd,i)
      else
        A^.cant_invitados:= A^.cant_invitados + 1;
end;
            { - - - - FIN MODULO INSERTAR_EN_ARBOL - - - - }


           { - - - - INICIO MODULO GENERAR_ESTRUCTURA - - - - }
procedure GENERAR_ESTRUCTURA (L:lista; var A:arbol);
begin
  while (L <> NIL) do begin
    if (verfamiliar (L^.dato) = TRUE) then
      INSERTAR_EN_ARBOL (A,L^.dato);
    L:= L^.sig;
  end;
end;
           { - - - - FIN MODULO GENERAR_ESTRUCTURA - - - - }

