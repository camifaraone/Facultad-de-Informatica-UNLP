program E3P3;
const
	valor_alto = 999;
type
	Novela = record
		cod: integer;
		gen: string;
		nom: string;
		dur: string;
		dir: string;
		pre: real;
		end;
	File_nov = file of Novela;
	
	procedure leer (var Arch_Nov: File_nov; var reg: Novela);
	begin
		if (eof(Arch_Nov)) then begin
			read(Arch_Nov,reg);
		end
		else begin
			reg.cod:= valor_alto;
		end;
	end;
	procedure IngresarEmp (var reg: Novela);
	begin
		repeat
		write(Ingrese el codigo de la Novela: );
		readln(reg.cod);
		if (reg.cod <= 0) then writeln('Codigo no valido, es necesario un codigo mayor a cero');
		until(reg.cod > 0);
		if (reg.cod = -1) then begin
			write(Ingrese el genero de la novela: );
			readln(reg.gen);
			write(Ingrese el nombre de la novela: );
			readln(reg.nom);
			write(Ingrese la duracion de la novela: );
			readln(reg.dur);
			write(Ingrese el director de la novela: );
			readln(reg.dir);
			write(Ingrese el precio de la novela: );
			readln(reg.pre);
		end;
	end;
	procedure CreoArchivo (var Arch_Nov: File_nov);
	var
		reg: Novela;
	begin
		rewrite(Arch_Nov);
		reg.cod = 0;
		write(Arch_Nov,reg);
		IngresarEmp(reg);
		while(reg.cod <> -1) do begin
			write(Arch_Nov,reg);
			IngresarEmp(reg);
		end;
		close (Arch_Nov);
	end;
	procedure BorroReg(var Arch_Nov: File_nov);
	var
		Pos, Codigo: integer;
		R_elim, R_cabecera: Novela;
	begin
		write('Ingrese el codigo de novela la cual desee borrar: ');
		readln(Cod);
		repeat
		leer(Arch_Nov, reg);
		until ((reg.cod <> valor_alto) AND (reg.cod <> Codigo));
		if (reg.cod <> valor_alto) then begin
			seek(Arch_Nov,filepos(Arch_Nov) - 1;
			Pos:= 0 - filepos(Arch_Nov);
			read(Arch_Nov, R_elim);
			seek(Arch_Nov, 0);
			read(Arch_Nov,R_cabecera);
			R_elim.cod:= R_cabecera.cod;
			R_cabecera.cod:= Pos;
			seek(Arch_Nov,0);
			write(Arch_Nov, R_elim);
			seek(Arch_Nov,Pos);
			write(Arch_Nov,R_cabecera);
		end;
		else writeln('Esa novela no se encuentra en el archivo');
		close(Arch_Nov);
	end;
	procedure DarAlta(var Arch_Nov: File_nov);
	var
		reg_nuevo,reg_arch,reg_aux: Novela
	begin
		reset(Arch_Nov);
		IngresarEmp(reg_nuevo);
		read(Arch_Nov, reg_arch);
		if (reg_arch.cod <> 0) then begin
			seek(Arch_Nov, reg_arch.cod * -1);
			read(Arch_Nov, reg_aux);
			seek(Arch_Nov, filepos(Arch_Nov) - 1);
			write(Arch_Nov, reg_nuevo);
			seek(Arch_Nov, 0);
			write(Arch_Nov, reg_aux);
		end
		else begin
			seek(Arch_Nov, filesize);
			read(Arch_Nov, reg_nuevo);
		end;
		close(Arch_Nov);
	end;
	procedure ModDatos (var Arch_Nov);
	type	
		procedure mod(var R: Novela);
		var
			N: integer;
			str_aux: string;
			r_aux: real;
		begin
			repeat
				writeln('Ingrese uno de los siguientes numeros para modificar los diferentes datos');
				writeln()
				writeln('1: modificar genero');
				writeln('2: modificar nombre');
				writeln('3: modificar duracion');
				writeln('4: modificar director');
				writeln('5: modificar precio');
				writeln('0: Dejar de modificar');
				readln(N);	
				case N of
					1: 	begin
						writeln('Ingresar el genero nuevo');
						readln(str_aux);
						reg.gen:= str_aux;
						end;
					2:	begin
						writeln('Ingresar el nombre nuevo');
						readln(str_aux);
						reg.nom:= str_aux;
						end;
					3:	begin
						writeln('Ingresar el duracion nuevo');
						readln(str_aux);
						reg.dur:= str_aux;
						end;
					4:	begin
						writeln('Ingresar el director nuevo');
						readln(str_aux);
						reg.dir:= str_aux;
						end;
					5:	begin
						writeln('Ingresar el precio nuevo');
						readln(r_aux);
						reg.pre:= r_aux;
						end;
					else writeln('Numero incorrecto');
			until(N <> 0);
		end;
	var
		Codigo: integer;
		reg: Novela;
	begin
		reset(Arch_Nov);
		writeln('Ingrese el codigo de novela a modificar');
		readln(Codigo);
		while (not EOF(Arch_Nov)) AND (reg.cod <> Codigo) do begin
			read(Arch_Nov, reg);
		end;
		if (not EOF(Arch_Nov)) then begin
			seek(Arch_Nov, filepos(Arch_Nov) - 1);
			mod(reg);
			write(Arch_Nov, reg);
		end
		else begin
			writeln('Esa novela no se encuentra en el archivo');
		end;
		close(Arch_Nov);
	end;
	procedure Gen_txt(var Arch_Nov: File_nov);
	var
		A_txt: Text;
		reg: Novela;
		cant: integer;
	begin
		assing(A_txt, 'Novelas.txt');
		rewrite(A_txt);
		cant:= 0;
		while(not EOF(Arch_Nov)) do begin
			read(Arch_Nov, reg);
			cant:= cant + 1;
			writeln(A_txt,'Novela ' + cant);
			writeln(A_txt, 'codigo: ' + reg.gen);
			writeln(A_txt, 'nombre: ' + reg.nom);
			writeln(A_txt, 'duracion: ' + reg.dur);
			writeln(A_txt, 'director: ' + reg.dir);
			writeln(A_txt, 'percio: ' + reg.pre);
			writeln();
			close(A_txt);
		end;
	end;
	procedure printOptions();
	begin
		writeln();
		writeln('MENU: (Ingrese uno de los siguientes numeros para realizar la funcion correspondiente)');
		writeln('1: Creo el archivo de novelas');
		writeln('2: Dar de alta una novela en el registro');
		writeln('3: Modificar datos de una novela');
		writeln('4: Eliminar archivo');
		writeln('0: Salir');
		writeln();
	end;
var
	Arch_Nov: File_nov;
	Nom_Fis: string;
	N: integer;
begin
	repeat
	printOptions();
	readln(N);
		while(N <> 0) do begin
			printOptions();
			case N of 
				1: 	begin
						write(Ingrese el nombre del archivo);
						readln (Nom_Fis);
						assing(Arch_Nov, Nom_Fis);
						CreoArchivo(Arch_Nov);
					end;
				2: 	begin
						write(Ingrese el nombre del archivo);
						readln (Nom_Fis);
						assing(Arch_Nov, Nom_Fis);
						DarAlta(Arch_Nov);
					end;
				3: 	begin
						write(Ingrese el nombre del archivo);
						readln (Nom_Fis);
						assing(Arch_Nov, Nom_Fis);
						ModDatos(Arch_Nov);
					end;
				4: 	begin
						write(Ingrese el nombre del archivo);
						readln (Nom_Fis);
						assing(Arch_Nov, Nom_Fis);
						BorroReg(Arch_Nov);
					end;
				5: 	begin
						write(Ingrese el nombre del archivo);
						readln (Nom_Fis);
						assing(Arch_Nov, Nom_Fis);
						Gen_txt(Arch_Nov);
					end;
				else writeln('Numero Incorrecto');
	until(N <> 0);
end;