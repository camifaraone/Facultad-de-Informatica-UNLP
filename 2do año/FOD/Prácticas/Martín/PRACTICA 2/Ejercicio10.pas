program ejercicio10;
const VALOR_ALTO = 9999;
type
	registro = record
		anio:integer;
		dia:integer;
		mes:integer;
		idUser:integer;
		tiempoAcceso:integer;
	end;
	
	arch_registro = file of registro;
	
procedure leer(var arch_reg: arch_registro ; var reg : registro);

begin
	if(not(EOF(arch_reg))) then
		read(arch_reg , reg)
	else
		reg.mes := VALOR_ALTO;
	
end;

procedure cargarDatos(var reg_arch: arch_registro ;  var text_reg : text);
var
	reg:registro;
begin
	reset(reg_arch);
	reset(text_reg);
	
	while(not eof(text_reg)) do begin
	
		readln(text_reg , reg.anio , reg.mes , reg.dia, reg.idUser , reg.tiempoAcceso);
		write(reg_arch , reg)
	end;
	
	close(text_reg);
	close(reg_arch);
end;

procedure imprimirRecord(var reg : registro);

begin
	writeln('Anio: ' , reg.anio);
	writeln('Mes: ' , reg.mes);
	writeln('Dia: ' , reg.dia);
	writeln('Id User: ' , reg.idUser);
	writeln('Tiempo de acceso: ' , reg.tiempoAcceso);
end;

procedure testCarga (var reg_arch: arch_registro);
var
	
	reg: registro;

begin
	reset(reg_arch);
	while(not eof(reg_arch)) do begin
		read(reg_arch , reg);
		imprimirRecord(reg);
		writeln('##########');
	end;
	close(reg_arch);
end;


procedure imprimirArchivo(var reg_arch : arch_registro);
var
	
	reg: registro;
	totalAnio, auxMes,auxDia, auxId, totalMes , totalDia , totalUser , anioRecorrer:integer;
	
begin
	reset(reg_arch);
	anioRecorrer:=2010;
	totalAnio:=0; totalMes:=0 ; totalDia:=0 ; totalUser :=0 ;
	
	while(not eof(reg_arch) and (reg.anio <> anioRecorrer) ) do 
		read(reg_arch , reg);
	if( reg.anio = anioRecorrer ) then 
	begin
		writeln('Anio ' , reg.anio );
		while(not eof(reg_arch) and (reg.anio = anioRecorrer)) do begin
			auxMes:= reg.mes;
			writeln('	MES ' , reg.mes);
			while(reg.mes = auxMes ) do begin
				auxDia:= reg.dia;
				writeln('		DIA ' , reg.dia);
				while(reg.dia = auxDia) do begin
					auxId := reg.idUser;
					while( reg.idUser = auxId ) do begin
						totalUser:= totalUser + reg.tiempoAcceso;
						leer(reg_arch, reg );
					end;
					writeln('			Tiempo de Acceso Usuario ', auxId ,' en el mes ',auxMes, ' y dia ',auxDia,' es de: ' , totalUser );
					writeln('			-----------');
					totalDia:= totalDia + totalUser;
					totalUser:=0;
				end;
				
				writeln('		Tiempo de Acceso TOTAL mes ',auxMes ,' dia ', auxDia , ' es de: ' , totalDia );
				writeln('		-----------');
				totalMes:=totalMes + totalDia;
				totalDia:=0;
			end;
			writeln('	Tiempo total del mes ', auxMes , ' es de: ' , totalMes);
			totalMes:= 0;
			
			writeln('	-----------');
		
		end;
	end
	else 
	begin
		
		writeln('Anio no encontrado');
	
	end;
	close(reg_arch);
end;

var
	text_registro:text;
	reg: arch_registro;
begin
	assign(text_registro , 'registros.txt');
	assign(reg , 'registro_arch');
	rewrite(reg);
	cargarDatos(reg , text_registro);
	
	testCarga(reg);
	imprimirArchivo(reg);
end.
	
	
