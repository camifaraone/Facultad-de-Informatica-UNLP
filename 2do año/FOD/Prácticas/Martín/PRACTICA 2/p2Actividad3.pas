program ejP2Ej3;
uses
    sysutils;              //Lo necesito para usar IntToStr
const
    dimF = 4;
    valor_alto = 99999;
type
    producto = record
        cod: integer;
        precio: real;
        stock_min: integer;
        stock_actual: integer;
    end;

    pedido = record
        cod: integer;
        cant_solicitada: integer;
    end;

    arch_mae = file of producto;
    arch_det = file of pedido;           //Usado para el proceso leerDetalle, que no recibe el vector entero, sino un archivo en particular
    varch_det = array[1..dimF] of file of pedido;
    vreg_det = array[1..dimF] of pedido;

//-------------------------------------------------------------//
procedure leerDetalle (var arch_det: arch_det; var reg_det: pedido);
begin
    if (not eof(arch_det)) then
        read(arch_det, reg_det)
    else
        reg_det.cod := valor_alto;
end;

procedure minimo(var varch_det: varch_det; var vreg_det: vreg_det; var min: pedido; var pos_min: integer);
var
    i: integer;
    cod_min: integer;
begin
    cod_min := 99999;
    for i:= 1 to dimF do
        if (vreg_det[i].cod < cod_min) then begin
            cod_min := vreg_det[i].cod;
            pos_min := i;
        end;
    min := vreg_det[pos_min];
    leerDetalle(varch_det[pos_min], vreg_det[pos_min]);  //NO PODES USAR "i" PORQUE ESTARÍAS ASIGNANDO SIEMPRE AL ÚLTIMO ÍNDICE DEL ARREGLO.
end;

procedure actualizarMaestro(var arch_mae: arch_mae; var varch_det: varch_det);
var
    min: pedido;
    reg_mae: producto;
    vreg_det: vreg_det;  //No necesito el vector con los registros en el programa principal
    cod_actual: integer;
    cant_solicitada: integer;
    sucursal: integer;
    dif: integer;
    i: integer;
begin
    for i := 1 to dimF do begin
        reset(varch_det[i]);
        leerDetalle(varch_det[i], vreg_det[i]);
    end;
    reset(arch_mae);
    read(arch_mae, reg_mae);
    minimo(varch_det, vreg_det, min, sucursal);
    while (min.cod < valor_alto) do begin
        cod_actual := min.cod;
        cant_solicitada := 0;
        while (cod_actual = min.cod) do begin
            cant_solicitada := cant_solicitada + min.cant_solicitada;    //OJO: Acá NO puedo ir restando la cantidad solicitada en el registro maestro
            minimo(varch_det, vreg_det, min, sucursal);                  //porque NO SÉ si el campo va a quedar en negativo, y no se puede tener un campo
        end;                                                             //en negativo (debe ser 0), por eso necesito una variable auxiliar.
        while (reg_mae.cod <> cod_actual) do
            read(arch_mae, reg_mae);                                     //SI PUDIESE modificar el registro maestro sin problemas, este movimiento del maestro
        dif := cant_solicitada - reg_mae.stock_actual;                   //que hago para que coincida con el detalle tendría que hacerlo arriba del while
        if (dif > 0) then begin                                          //que mueve al detalle, porque sino podría perder esa modificación al hacer un read.
            reg_mae.stock_actual := 0;
            writeln('No se pudo satisfacer el pedido de la sucursal ', sucursal, ', producto ',  cod_actual, '. Cantidad que no pudo ser enviada: ', dif)
        end
        else begin
            reg_mae.stock_actual := reg_mae.stock_actual - cant_solicitada;
            if (reg_mae.stock_actual < reg_mae.stock_min) then
                writeln('El pedido se envio. El stock del producto quedo por debajo del minimo.')
            else
                writeln('El pedido se envio correctamente.');
        end;
        seek(arch_mae, filepos(arch_mae)-1);
        write(arch_mae, reg_mae);
        if (not eof(arch_mae)) then
            read(arch_mae, reg_mae);
    end;
    close(arch_mae);
    for i := 1 to dimF do
        close(varch_det[i]);
end;

//-------------------------------------------------------------//
var
    i: integer; //La voy a usar para hacer las asignaciones en un for.
    varch1_det: varch_det;
    arch_mae1: arch_mae;
begin
    for i := 1 to dimF do
        assign(varch1_det[i], 'det ' + IntToStr(i));   //Convierte un integer a string, de otro modo no se puede concatenar
    assign(arch_mae1, 'mae');
    actualizarMaestro(arch_mae1, varch1_det);
    readln;
end.
