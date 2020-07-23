program merge4listas;
const
     Valor_Alto = 9999 ;
     DF = 4;
type
    lista = ^nodo ;
    nodo = record
         dato: integer;
         sig: lista ;
    end;
    vector = array [1..DF] of lista;


{-----------------------------------------------------------------------------
IMPRIMIR - Imprime la toda la lista}

Procedure Imprimir_Lista (pri:lista);
Begin
   while (pri <> NIL) do begin
     writeln (pri^.dato) ;
     pri:= pri^.sig;
  end;
end;


{-----------------------------------------------------------------------------
INCERTAR - Incerta en la lista al final }
procedure agregar_al_final (var lm,ult:lista; min:integer);
var
 nue:lista;
begin
	new (nue);
	nue^.dato:=min;
	nue^.sig:=nil;
	if (lm=nil) then
	   lm:=nue
    else
        ult^.sig:=nue;
    ult:= nue;
end;


 {------------------------------------------------------------------------------
   BORRA UN ELEMENTO (LIBRO) DE LA LISTA}
 procedure borrarLibro( var pri: lista);
 var
    aux: lista;
 begin
      aux:=pri;
      pri:= pri^.sig;
      dispose(aux);
 end;



 {-----------------------------------------------------------------------------
 BUSCO EL MINIMO DEL VECTOR Y LO DEVUELVO O EN CASO DE VACIO DEVUELVO VALOR_ALTO}
 procedure minimo_vector(var v:vector; var min:integer);
 var
   vmin,i:integer;
 begin
      for i := 1 to DF do begin                      {busco el minimo dentro del vector, me quedo con la posicion del minimo y el minimo}
          if (v[i]<> nil) then begin
             if (v[i]^.dato<min) then begin
                min:= v[i]^.dato;
                vmin:= i;
             end;
          end;
      end;
      if (min <> Valor_Alto) then
         borrarLibro(v[vmin]);
  end;



{---------------------------------------------------------------------------------------------------------------------------------
UNA VEZ ENCONTRADO EL MINIMO, IMPRIMO EL VALOR PARA CONTROLAR QUE SE HAYA ENCONTRADO CORRECTAMENTE Y AVANZO EN LA LISTA DEL VECTOR}
procedure avanzar_cargarmerge( var lm,ult: lista; min:integer);
begin
     writeln (' El valor minimo del vector actual es ', min , ' y corresponde a la lista numero ');
     agregar_al_final(lm,ult,min);
end;


{--------------------------------------------------------------------------------------------------------------------------------
BUSCO EL MINIMO EN EL VECTOR, LO CARGO EN LA MERGE Y AVANZO EN LA LISTA}
 procedure procesar_vector_y_listamerge(var v:vector; var lm:lista) ;
 var
   min:integer;
   ult: lista;
 begin
      ult:= nil;
      min:= Valor_Alto;                            {inicializo el minimo, para la primer busqueda}
      minimo_vector(v,min);
      while (min<>Valor_Alto)do begin
            avanzar_cargarmerge(lm,ult,min);       {en este proceso avanzo en la lista y cargo en la lista mergue}
            min:= Valor_Alto;
            minimo_vector(v,min);                 {inicializo y busco el siguiente minimo, hasta que todas las listas esten vacias}
      end;
 end;


 {-------------------------------------------------------------------------------
IMPRIMO LOS VALORES LAS LISTAS DEL VECTOR}
Procedure Imprimir (v:vector);
var
   i:integer;
Begin
   for i := 1 to DF do begin
        writeln (' valores de la lista numero ', i);
        imprimir_Lista (v[i]) ;
   end;

end;



 {-----------------------------------------------------------------------------
INSERTAR - Inserta num en la lista pri manteniendo el orden creciente}
Procedure Insertarordenado ( var pri: lista; n: integer);
var ant, nue, act: lista;
begin
   new (nue);
   nue^.dato := n;
   act := pri;
   ant := pri;
  { Recorro mientras no se termine la lista y no encuentro la posicion correcta}
   while (act<>NIL) and (act^.dato < n) do begin
      ant := act;
      act := act^.sig ;
   end;
   if (ant = act) then
      pri := nue                   {el dato va al principio}
   else
       ant^.sig  := nue;           {el dato va entre otros dos o al final}
   nue^.sig := act ;
end;


{------------------------------------------------------------------------------
CREO LAS LISTAS QUE ESTAN DENTRO DEL VECTOR, DE MANERA ORDENADA}
 procedure crearlista_dentrode_vectores (var l: lista);
 var
    n: integer;
 begin
       n:= random(10);
       while (n<>0) do begin
             Insertarordenado(l,n);
             n:= random(10);
       end;
 end;


 {-----------------------------------------------------------------------------
 CREO EL VECTOR DE LISTAS }
 procedure crear_vector(var v:vector) ;
 var
    i: integer;
 begin
      for i := 1 to DF do begin
          crearlista_dentrode_vectores(v[i]);
      end;
 end;



{-----------------------------------------------------------------------------
VARIABLES Y PROGRAMA PRINCIPAL }

Var
 v: vector;
 lm: lista;

begin
 lm:=nil;
 crear_vector(v);
 imprimir (v);
 readln;
 procesar_vector_y_listamerge(v,lm);
 readln;
 readln;
 writeln ('estos son los valores de la lista final ');
 imprimir_Lista(lm);
 readln;
 readln;

end.
