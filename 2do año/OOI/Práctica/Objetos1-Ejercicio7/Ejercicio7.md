# Ejercicio 7: Method lookup con empleados
Sea la jerarquía de Empleado como muestra la figura de la izquierda, cuya
implementación se incluye en la tabla de la derecha (**Ver imagen en Cuadernillo de Actividades**)

Analice cada uno de los siguientes fragmentos de código y resuelva las tareas indicadas
abajo:

a) Liste los métodos que son ejecutados como resultado del envío del último
mensaje (por ejemplo, método #aportes de la clase X, ...)
b) Responda qué retorna la última expresión en cada caso

## Fragmento 1
```
| gerente |
gerente := Gerente new.
gerente aportes
```

**a)** **aportes** de la clase **Gerente**, **montoBasico** de la clase **Gerente**

**b)** (1000 * 0.05) = **50**

## Fragmento 2
```
| gerente |
gerente := Gerente new.
gerente calcularSueldo
```

**a)** **calcularSueldo** de la clase **EmpleadoJerarquico**, **sueldoBasico** de la clase **Empleado**, **montoBasico** de la clase **Gerente**, **aportes** de la clase **Gerente**, **montoBasico** de la clase **Gerente**, **bonoPorCategoria** de la clase **EmpleadoJerarquico**
**b)** (1000 - (1000 * 0.05)) + 200 = **1150**
