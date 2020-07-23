{ - - - - - - - - - - - - - - - - - ENUNCIADO - - - - - - - - - - - - - - - - -}
Un supermercado dispone de una lista donde se tiene almacenada la información de
las ventas que se realizaron durante el año. De cada venta se conoce: código de
producto, cantidad vendida, fecha y numero de cliente. Este estructura esta
ordenada por código de producto y puede haber varias ventas que tengan el mismo
código de producto.
Además, el supermercado dispone de otra estructura (que permite realizar la
búsqueda de manera eficiente) donde almacena para cada codigo de producto el
stock actual, precio por unidad  y el stock mínimo permitido. Esta última
estructura se encuentra ordenada por código de producto.

a) A partir de la estructuras disponibles se píde:

1) Realizar una actualización del stock actual de cada producto vendido.
2) Generar una nueva estructura donde para cada código de producto vendido
aparezca el monto total recaudado (ordenada en forma ascendente por código de
producto):

b) Informar el código del producto con mayor stock actual entre aquellos
productos cuyo código de producto se encuentre entre 10 y 50.

Nota: Modularizar. Definir claramente el programa principal y las estructuras de
datos que utilicen. Para los incisos de a) debe recorrer una sola vez la lista
disponible.
{ - - - - - - - - - - - - - - - - - ENUNCIADO - - - - - - - - - - - - - - - - -}



Program Parcial_2º:3ra.Fecha;
type
                   { - - - - INICIO ESTRUTURAS - - - - }
  lista = ^nodo;
  nodo = record
           datos:venta;
           sig:lista;
  end;
  venta = record                       // LISTA.-  SE DISPONE.-
            cod:integer;
            cant:integer;
            fecha:string;
            nro_cliente:integer;
  end;

  arbol = ^nodo_A;
  nodo_A = record
             izq:arbol;
             der:arbol;
             cod_prod:integer;
             dato:reg;                  // ARBOL.-  SE DISPONE.-
  end;
  reg = record
          stock_actual:integer;
          stock_min:integer;
          precio:real;
  end;

  listas_montos = ^nodo;
  nodo = record
           datos:producto;
           sig:listas_montos;          // LISTA MONTOS.-  HAY QUE GENERAR.
  end;
  producto = record
               cod:integer;
               monto:real;
  end;




               { - - - - INICIO MODULO OBTENER_MONTO - - - - }
function OBTENER_MONTO (A:arbol,cod:integer;):real;
begin
  if (A <> NIL) then
    if (A^.cod_prod = cod) then
      OBTENER_MONTO:= A^.dato.precio;
    else
      if (A^.cod_prod < cod) then
        OBTENER_MONTO (A^.der,cod);
      else
        OBTENER_MONTO (A^.izq,cod);
end;
               { - - - - FIN MODULO OBTENER_MONTO - - - - }



              { - - - - INICIO MODULO RECORRER_ESTRUCTURAS - - - - }
procedure RECORRER_ESTRUCTURAS (L:lista; A:arbol; var LM:lista_montos);
{Paso arbol x valor xq no modifico estructura del mismo, solo stock}
var
  cod_actual:integer;
  tot_cod:integer;
  monto_prod:real;

begin
  while (L <> NIL) do begin
    cod_actual:= L^.datos.cod;
    tot_cod:= 0;
    while (L <> NIL) and (cod_actual = L^.datos.cod) do begin
      tot_cod:= tot_cod + 1;
      L:= L^.sig;
    end;
    ACTUALIZAR_STOCK (A,tot_cod,cod_actual);
    monto_prod:= (OBTENER_MONTO (A,cod_actual) * tot_cod);
    GENERAR_LISTA (LM,monto_prod,cod_actual);

  end;
end;
              { - - - - FIN MODULO ACTUALIZAR_STOCK - - - - }



              { - - - - INICIO MODULO ACTUALIZAR_STOCK - - - - }
procedure ACTUALIZAR_STOCK (A:arbol; tot_cod:integer; codigo:integer);
begin
  if (A <> NIL) then
    if (A^.cod_prod = codigo) then
      if (A^.dato.stock_actual - A^.dato.stock_min) >= tot_cod then
        DESCONTAR_STOCK (A^.dato.stock_actual,tot_cod);
    else
      if (A^.cod_prod < codigo) then
        ACTUALIZAR_STOCK (A^.der,tot_cod,cod_actual);
      else
        ACTUALIZAR_STOCK (A^.izq,tot_cod,cod_actual);
end;
              { - - - - FIN MODULO DESCONTAR_STOCK - - - - }



              { - - - - INICIO MODULO DESCONTAR_STOCK - - - - }
procedure DESCONTAR_STOCK (var stock_actual:integer; tot_cod:integer);
begin
  stock_actual:= stock_actual - tot_cod;
end;              { - - - - FIN MODULO DESCONTAR_STOCK - - - - }


// PROGRAMA PRINCIPAL
var
  L:lista;
  A:arbol;
  LM:lista_montos;
begin
  L:= NIL;
  A:= NIL;
  LM:= NIL;
  CARGAR_LISTA (L);   // SE DISPONE.-
  CARGAR_ARBOL (A);   // SE DISPONE.-
  RECORRER_ESTRUCTURAS (L,A,LM);




















                   { - - - - FIN ESTRUTURAS - - - - }



