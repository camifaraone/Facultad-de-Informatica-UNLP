program merge4listas;
const
     Valor_Alto = 9999 ;

type
    cadena =string[30];
    consumo = record
            tipo: cadena;
            monto: real;
    end;

    lista = ^nodo ;
    nodo = record
         dato: consumo;
         sig: lista ;
    end;

    vector = array [1..dimf] of lista;

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
INSERTAR - Inserta en la lista al final }
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
 BUSCA EL MINIMO EN LAS 2 LISTAS}
procedure minimo (var l1,l2:lista; var min:consumo);
var
   act:lista;
begin
     if (l1<>nil) and (l2<>nil) then begin
        if (l1^.dato<l2^.dato) then begin
           min:= l1^.dato.tipo;
           act:= l1;
           l1:= l1^.sig;
           dispose (act);
        end
        else begin
             min:= l2^.dato.tipo;
             act:= l2;
             l2:= l2^.sig;
             dispose (act);
        end;
     end;
     if (l1=nil) and (l2=nil) then
        min.tipo:= Valor_Alto;
end;


{---------------------------------------------------------------------------------------------------------------------------------
UNA VEZ ENCONTRADO EL MINIMO, IMPRIMO EL VALOR PARA CONTROLAR QUE SE HAYA ENCONTRADO CORRECTAMENTE Y AVANZO EN LA LISTA DEL VECTOR}
procedure avanzar_cargarmerge( var lm,ult: lista; min:integer);
begin
     writeln (' El valor minimo del vector actual es ', min , ' y corresponde a la lista numero ');
     agregar_al_final(lm,ult,min);
end;


{------------------------------------------------------------------------------
MERGE ACUMULADOR Y EL TOTAL}
procedure mergeAcumulador (l1,l2:lista; var lm:lista);
var
    min:integer; aux:consumo;
    ult:lista;
begin
    aux.monto:=0;
    ult:=nil;
    min:= Valor_Alto;
    while (l1<> nil) or (l2<>nil) do begin
          minimo(l1,l2,min);
          aux.tipo:= min.tipo;
          while( (l1<>nil)or(l2<>nil) and (aux.tipo=min.tipo)do begin           // si hay elementos en las listas (1o2) y existen 1 o mas tipos
                 aux.motno:= aux.monto + min.tipo;                             //acumulo el monto total de cada tipo de consumo
                 minimo (l1,l2,min);
          end;
          avanzar_cargamerge(lm,ult,aux);                                     //cargo la merge
    end;
end;



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
INSERTAR DATOS POR TIPO DE CONSUMO}
Procedure Insertarordenado ( var pri: lista; c: consumo);
var ant, nue, act: lista;
begin
   new (nue);
   nue^.dato :=c ;
   act := pri;
   ant := pri;
  { Recorro mientras no se termine la lista y no encuentro la posicion correcta}
   while (act<>NIL) and (act^.dato.tipo < nuevo^.dato.tipo) do begin
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
 LEER EL REGISTRO "LA_FECHA"}
procedure leer_la_fecha ( var f:la_fecha);
begin
        f.dia:= random (31);
        f.mes:= random (12);
        f.año:= random (2018);
end;

{-------------------------------------------------------------------------------
 LEER EL REGISTRO CONSUMO Y LLAMAR AL OTRO REGISTRO}
procedure leer (var c.consumo);
begin
     c.tipo:=random(20);
     if (c.tipo <> 0) then
        c.monto:=random(20.7);
end;


{------------------------------------------------------------------------------
CREO LAS Lista DE CONSUMO}
 procedure crearlista (var l: lista);
 var
   c:consumo;
 begin
       leer(c);
       while (p.tipo<>0) do begin
             Insertarordenado(l,c);
             leer(c);
       end;
 end;


{-----------------------------------------------------------------------------
VARIABLES Y PROGRAMA PRINCIPAL }

Var
 lm,l1,l2: lista;

begin
 randomize;
 lm:=nil; l1:=nil; l2:=nil;
 crearlista (l1);
 crearlista (l2);

 writeln('lista l1:');
 Imprimir_Lista (l1);
 radln();
 writeln ('listal2:');
 Imprimir_Lista (l2);
 readln();

 mergeAcumulador(l1,l2,lm);
 readln;
 readln;
 writeln ('estos son los valores de la lista final ');
 imprimir_Lista(lm);
 readln;
 readln;

end.
