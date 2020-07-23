https://codeshare.io/2WAYnb

// Explicaciones Anteriores las pueden bajar en goo.gl/ojnuZB
// Este directorio lo vamos a actualizar con soluciones de los ejercicios de T(n) 

package tp06.ejercicio6;

import tp02.ejercicio2.ListaEnlazadaGenerica;
import tp02.ejercicio2.ListaGenerica;s
import tp06.ejercicio4.Arista;
import tp06.ejercicio4.Grafo;
import tp06.ejercicio4.Vertice;

public class Mapa {
  Grafo <String> mapaCiudades;
  
  ListaGenerica <String> caminoExceptuando;	//Ej  6b
	
	public Grafo<String> getMapaCiudades() {
		return mapaCiudades;
	}

	public void setMapaCiudades(Grafo<String> mapaCiudades) {
		this.mapaCiudades = mapaCiudades;
	}
  public ListaGenerica <String> devolverCaminoExceptuando(String c1, String c2, ListaGenerica<String> ciudades){
		Vertice <String> vIni = null;
		Vertice <String> vFin = null;
    // boolean[] marca = new boolean[grafo.listaDeVertices().tamanio()+1];
		ListaGenerica <Vertice<String>> vertices = this.mapaCiudades.listaDeVertices();
		vertices.comenzar();
		while(!vertices.fin()){  // Si no me pasan los vertices y me pasan el dato tengo que buscar lso vertices con esos datos.
			Vertice <String> vAux = vertices.proximo(); //retorna el vertice y avanza
			if(vAux.dato().equals(c1)){
				vIni = vAux;
			}
			if(vAux.dato().equals(c2)){
				vFin = vAux;
			}
		}
		ListaGenerica <String> caminoActual = new ListaEnlazadaGenerica <String>();  // camino actual
		this.caminoExceptuando = new ListaEnlazadaGenerica <String>(); //camino a devolver
		dfsCaminoExc(vIni,vFin,caminoActual,ciudades);  //el dfs se dispara una sola vez a partir del vertice inicial
		return this.caminoExceptuando;
	}

	private void dfsCaminoExc(Vertice<String> vIni, Vertice<String> vFin, 
                            ListaGenerica<String> caminoActual, ListaGenerica<String> ciudades) {
    
		caminoActual.agregarFinal(vIni.dato());
		if(vIni == vFin){   // La recursión termina cuando llegó al caso base, que el camino termina cuando llego a la ciudad destino vFin
			this.caminoExceptuando = caminoActual.clonar();
      // copiarElementos https://codeshare.io/GrafosEjemplo; 
    }
		else{
			ListaGenerica <Arista<String>> ady = this.mapaCiudades.listaDeAdyacentes(vIni);
			ady.comenzar();
			while(!ady.fin()){
				Vertice <String> vAux = ady.proximo().verticeDestino();
				if(!caminoActual.incluye(vAux.dato()){  
          //Si mi camino actual no lo tiene es porque todavía no pasé por ese vértice, 
          //Lo mismo que: 
          //if !marca[vAux.posicion()]
           if (!ciudades.incluye(vAux.dato())){
					    dfsCaminoExc(vAux,vFin,caminoActual,ciudades);
				   }
        }  
			}
		}
		caminoActual.eliminarEn(caminoActual.tamanio());
	}

  // EJERCICIO CAMINO MAS CORTO         
  ListaGenerica <String> caminoMasCorto;        //variable de instancia de clase Mapa
    int largoMin;    //variable de instancia de clase Mapa
        
          
  public ListaGenerica <String> caminoMasCorto(String c1, String c2){
        Vertice <String> vIni = null;
        Vertice <String> vFin = null;
        ListaGenerica <Vertice<String>> vertices = this.mapaCiudades.listaDeVertices();
        vertices.comenzar();
        while(!vertices.fin()){
            Vertice <String> vAux = vertices.proximo();
            if(vAux.dato().equals(c1)){
                vIni = vAux;
            }
            if(vAux.dato().equals(c2)){
                vFin = vAux;
            }
        }
        ListaGenerica <String> caminoActual = new ListaEnlazadaGenerica <String>();
        this.largoMin = -1;
        this.caminoMasCorto = new ListaEnlazadaGenerica <String>();
        dfsCaminoMasCorto(vIni,vFin,caminoActual);
        return this.caminoMasCorto;
    }

    private void dfsCaminoMasCorto(Vertice<String> vIni, Vertice<String> vFin, ListaGenerica<String> caminoActual) {
        caminoActual.agregarFinal(vIni.dato());
        if(vIni == vFin){ //caso que llego al final
            if(caminoActual.tamanio() <= this.largoMin || this.largoMin == -1){ //me fijo si es mas corto que el que tenía
                this.caminoMasCorto = caminoActual.clonar();  //clono
                this.largoMin = caminoActual.tamanio();  // me guardo el tamaño del camino en una variable, es opcional se puede preguntar directamente por tamano
            }
        }
        else{
            ListaGenerica <Arista<String>> ady = this.mapaCiudades.listaDeAdyacentes(vIni);
            ady.comenzar();
            while(!ady.fin()){
                Vertice <String> vAux = ady.proximo().verticeDestino();
                if(!caminoActual.incluye(vAux.dato())){ //si no pasé por ahí...
                    dfsCaminoMasCorto(vAux,vFin,caminoActual);
                }
            }
        }
        caminoActual.eliminarEn(caminoActual.tamanio()); //lo elimino cuando termino para considerar otros caminos cuando vuelva de la recursioń.
    }
										
          
} 