program E4P3;
const
	valor_alto: ;
	
type
	tTitulo = String [50];
	tArchRevistas = file of tTitulo;
	procedure eliminar (var Arch_rev: tArchRevistas; titulo: tTitulo);
	var
		str_baja, str, aux: tTitulo;
		pos: integer;
	begin
		readln(str_baja);
		read(Arch_rev, str);
		while (not EOF (Arch_rev)) AND (str_baja <> str) do begin
			read(Arch_rev, str);
		end;
		if (not EOF(Arch_rev)) then begin
			pos:= filepos(Arch_rev) - 1;
			seek (Arch_rev, 0);
			read(Arch_rev,aux); //Me guardo lacabezera
			str:= IntToStr(pos) * -1;
			write(Arch_rev, str); //Escribo el indice del archivo borrado en la cabezera
			seek(Arch_rev, pos);
			//*
			read(Arch_rev, str); 							//Agarro el dato del 
			seek(Arch_rev, filepos(Arch_rev) - 1);			//archivo a borrar para 
			write(Arch_rev, (IntToStr(aux * -1) + str)); 	//ponerlo en formato(-Ndato)
			//*
		end
		else writeln('No se encontro esa revista en el archivo');
	end;
	
	procedure agregar (var Arch_rev: tArchRevistas; titulo: tTitulo);
	var
		str, aux: tTitulo;
		pos, cod_error: integer;
	begin
		reset(Arch_rev);
		read(Arch_rev,str);
		if (str <> '0') then begin
			val(str, pos);
			seek(Arch_rev, pos * -1);
			read(Arch_rev,aux);
			seek(Arch_rev, filepos(Arch_rev) - 1);
			write(Arch_rev, titulo);
			seek(Arch_rev, 0);
			val(aux, pos, cod_error);
			val(copy(aux,1,cod_error - 1),pos);
			write(Arch_rev, pos);
		end
		else begin
			seek(Arch_rev, filesize(Arch_rev));
			write(Arch_rev,titulo);
		end;
	end;
	
	procedure Creo_arch(var Arch_rev: tArchRevistas);
	var
		str: tTitulo;
		n,cod: integer;
	begin
		rewrite(Arch_rev);
		str = '0';
		write(Arch_rev,str);
		readln(str);
		while(str <> 'ZZ') do begin
			write(Arch_rev, str);
			readln(str);
		end;
		close(Arch_rev);
	end;
	
	procedure Listar_arch(var Arch_rev: tArchRevistas);
	var
		dato: tTitulo;
	begin
		reset(Arch_rev);
		writeln('Lista de novelas:');
		while(not eof(Arch_rev)) do begin
			read(Arch_rev, dato);
			val(dato,n,cod);
			if(cod = 1) then writeln(dato);
		end;
	end;
	
var
	Arch_rev: tArchRevistas;
	t: tTitulo;
begin
	assing(Arch_rev, 'Revistas');
	Creo_arch(Arch_rev);
	readln(t);
	agregar(Arch_rev, t);
	Listar_arch(Arch_rev);
	readln(t);
	eliminar(Arch_rev, t);
end;	