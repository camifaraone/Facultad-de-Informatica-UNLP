
{14.  La editorial X, autora de diversos semanarios, 
* posee un archivo maestro con la información 
* correspondiente a las diferentes emisiones de 
* los mismos. De cada emisión se registra: 
* 	fecha, 
* 	código de revista, 
* 	nombre del revista, 
* 	descripción, 
* 	precio, 
* 	total de ejemplares y 
* 	total de ejemplares vendido.
* 
* 
* Mensualmente se reciben 100 archivos detalles con las ventas 
* de los semanarios en todo el país. La información que poseen 
* los detalles es la siguiente: 
* 	fecha, 
* 	código de revista y 
* 	cantidad de ejemplares vendidos. 
* 
* Realice las declaraciones necesarias, 
* la llamada al procedimiento y el procedimiento que 
* recibe el archivo maestro y los 100 detalles 
* y realice la actualización del archivo maestro en función de las ventas 
* registradas. 
* Además deberá informar fecha y semanario que tuvo más ventas
* y la misma información del semanario con menos ventas. 
* Nota: Todos los archivos están ordenados por fecha y código de semanario. 
* No se realizan ventas de semanarios si no hay ejemplares para hacerlo
}

program revistas;
uses 
	sysutils;
const
	valoralto:= 9999;
	n = 100;
type 
	st4: string[4];
	st10 = string[10];
	st20 = string[20];
	st50 = string[50];
	
	fecha = record 
		sem:byte;
		mes:byte;
		anio:st4;
	end;
	
	emision = record 
		cod: integer; // clave primaria
		fe: fecha;  // clave secundaria 
		nom: st20;
		desc: st50;
		precio: real;
		total: integer;
		ventas: integer;
	end;
file_em = file of emision;
	ventas_sem = record 
		cod: integer; // clave primaria
		fe: fecha;  // clave secundaria
		ventas: integer;
	end;
file_vent = file of ventas_sem;

_det = array [1..n] of file_vent;
_reg = array [1..n] of ventas_sem;

procedure leer(var d:file_vent; var v:ventas_sem);
begin
	if (not eof(d)) then 
		read(d, v)
	else
		v.cod:= valoralto;
end;


procedure minimo (var d: _det; reg:_reg; var min: ventas_sem);
var 
	i: integer; minpos: integer;
begin 
	min.cod:= valoralto;
		
	for i:= 1 to n do begin 	
	
		leer(d[i], reg[i]);
		
		if (reg[i].cos <> valoralto) then begin		
			if reg[i].cod < min.cod then 			
				min:= reg[i];
				minpos:=i;				
		end;
	end;	
	
	if (min.cod <> valoralto) then 
		leer(d[minpos], reg[minpos]);		
end;

procedure actualizar(var detArray:_det; var regArray:_reg; var det: file_vent; var mae: file_em);
var 
em: emision; min: ventas_sem; 
actual_cod: integer; act_fecha: fecha;
mayor, menor: ventas_sem; total: integer;
aux: emision; 
begin
	mayor.ventas:=-1;  // mayor cantidad de ventas
	menor.ventas:=valoralto; // menor cantidad de ventas
	
	reset(mae);
	read(mae, em);
	minimo(detArray, regArray, min);
	while (min.cod <> valoralto) do begin 
		while (em.fecha <> min.fecha) && (em.cod <> min.cod) do 
			read(mae, em);
		aux:=em;
		actual_cod:= min.cod;
		total:=0; // total ventas para cada codigo;
		while (actual_cod = min.cod) do begin 
				act_fecha:= min.fecha;
				while (act_fecha = min.fecha) do begin 
					total:=em.ventas+min:=ventas;
					if total < menor.ventas then
						menor.ventas:= min;
					if total > mayor.ventas then
						mayor.ventas:= min;		
				minimo(detArray, regArray, min);
				end;
			aux.fecha:=min.fecha;
			aux.cod:=min.cod;
			aux.ventas:=total;
			seek(mae, FilePos(mae)-1);
			write(mae, aux);
		end;
	close(mae)
	writeln('el semanario con mayor ventas fue codigo: ', mayor.cod,
			' en la semana ', mayor.fe.sem, ' del mes ', mayor.fe.mes, 
			'del anio', mayor.fe.anio);
	writeln('el semanario con menor ventas fue codigo: ', menor.cod,
			' en la semana ', menor.fe.sem, ' del mes ', menor.fe.mes, 
			'del anio', menor.fe.anio);	
end;

var 
	det: file_vent; mae: file_em;
	detArray: _det; regArray: _reg;
begin
	assign(mae, 'emisiones.dat');

	for i:= 1 to n do begin     
		assign(detArray[i], 'det'+IntToStr(i)+'.dat');
		reset(detArray[i]);
	end;
	actualizar(detArray, regArray, det, mae);
	for i:= 1 to n do begin 
			close(detArray[i]);
	end
end.
