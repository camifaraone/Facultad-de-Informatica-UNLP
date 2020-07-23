program E7P3;
const
	valor_alto = 999;
type
	aves_extincion = record
		cod: integer;
		nom_especie: string[20];
		fam: string[20];
		desc: string[50];
		zona_geo: string[30];
		end;
	file_aves = file of aves_extincion;
	procedure leer (var A_aves: file_aves; var reg: aves_extincion);
	begin
		if (EOF(A_aves)) then read(A_aves,reg);
		else reg.cod:= valor_alto;
	end;
	procedure Compact_Arch(var A_aves: file_aves);
	type
		function UltimoValorValido(var A_aves:file_aves): integer;
		var
			ok: boolean;
			reg: aves_extincion;
			i, p: integer;
		begin
			ok:= true;
			reset(A_aves);
			i:= 1;
			while (ok) do begin
				seek(A_aves, filesize(A_aves) - i);
				read(A_aves, reg);
				if(reg.cod > 0) then ok:= false;
				i:= i + 1;
			UltimoValorValido:= p;
		end;
	var
		reg: aves_extincion;
		pos: integer;
	begin
		reset(A_aves);
		leer(A_aves,reg);
		while(reg.cod <> valor_alto) do begin
			aux:= UltimoValorValido(A_aves);
			truncate(A_aves, aux + 1);
			if (reg.cod < 0) then begin
				pos:= filepos(A_aves) - 1;
				seek(A_aves, aux);
				read(A_aves,reg);
				seek(A_aves, pos);
				write(A_aves,reg);
				truncate(A_aves,aux);
			end;
		end;
	end;

	procedure Elim_Datos (var A_aves: file_aves);
	type
		procedure Buscar (var A_aves: file_aves);
		var
			ok: boolean;
		begin
			reset(A_aves);
			leer(A_aves,reg);
			ok:= true;
			while(reg.cod <> valor_alto) AND (ok) do begin
				if (reg.cod = cod) then begin
					reg.cod:= reg.cod * -1;
					ok:= false;
				leer(A_aves,reg);
			end;
			if (reg.cod = valor_alto)then writeln('No se encontro el dato a borrar en el archivo');
		end;
	var
		cod: integer;
		reg: aves_extincion;
	begin
		writeln('Ingrese el codigo de especie que desee borrar, cuando no quiera borrar mass datos ingrese 100000');
		read(cod);
		while(cod <> 100000)do begin
			Buscar(A_aves);
			read(cod);
		end;
	end;

var
	A_aves: file_aves;
begin
	assign(A_aves,'aves en extinsion');
	Elim_Datos(A_aves);
	Compact_Arch(A_aves);
end.