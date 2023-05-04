# Stack

## Consigna

El ejercicio tiene dos partes:

1. El objetivo de la primera parte es encarar un primer modelado de un problema
   y seguir ejercitando reemplazar if por polimorfismo, en particular
   implementando un `Stack`.

Hay que hacer pasar todos los tests del ejercicio y la implementación del Stack
no debe tener if.

No se pueden modificar los tests.

Ayudas:
1. Primero hagan pasar todos los tests usando if y después apliquen la técnica
   para sacar if que vimos.
2. Si les sirve, utilicen una metáfora. Una muy útil es la de representar el
   juego de los bebes donde se apilan platos en una especie de torre de Hanoi.

**Importante**: Tampoco se puede usar handleo de excepciones para ocultar lo que
sería en definitiva un if.

2. El Stack de la primera parte es utilizado para almacenar oraciones de
   cualquier longitud. 

Se debe implementar el mensaje find (elección de nombre del mensaje y
colaboradores externos es parte del ejercicio) de `SentenceFinderByPrefix` que
dado un prefijo se encarga de devolver todas las oraciones almacenadas en el
Stack que contengan dicho prefijo.

Por ej. si el prefijo es 'Wint', y las oraciones en el Stack son 'winter is
coming', 'winning is everything', 'The winds of Winter' y 'Winter is here' sólo
debería devolver la última.

El prefijo es case sensitive, no puede ser vacío, ni contener espacios vacíos y
el Stack al terminar la operación de búsqueda debe de mantener las mismas
oraciones en idéntico orden.

La implementación de find debe ser lo más declarativa posible.

Además de implementar find, se debe testear dicha funcionalidad. Para ello
escriba todos los tests que crea necesario en `SentenceFinderByPrefixTest`.

Aclaración: No se pueden agregar mensajes adicionales a Stack y la idea es se
trabaje sobre el stack original y no clonarlo, ni transformarlo en otro tipo de
colección para utilizarlo. La respuesta del `SentenceFinder` podría ser una
`OrderedCollection` con las oraciones encontradas.

## Devolución

Hola,

Pueden abrir la solución en nuestro repo usando la contraseña <teaEarlGreyHot!>.
La nota de esta entrega es: 7.39 ( 8.55*.3 + 6.89*.7 )
La misma se obtiene de la sumatoria de la nota de cada tema evaluado.

Los temas evaluados según su puntaje son:

- Teóricos: **8.55**

  1.1. (V o F) Justificar (max. 3 renglones) sólo en caso de ser Falso. (Fran)(1/10): 1

  1.2. Explique en 3 renglones cuál es el concepto de "Alcance" dentro del apartado Lenguaje (Fran)(1.5/10): **1.5**

  2.1. Explique a qué se refiere el autor en este párrafo: (Maxi)(1.5/10): **1.2**

  2.2. Explique el concepto de "failing safely" (Maxi)(1/10): 1

  3.1. Para que dos métodos sean polimórficos basta con pedir que: (Fran)(1.5/10): **1.5**

  3.2. Compare la definición de polimorfismo visto en clase con la presentada en el paper (máx. 5 líneas) (Fran)(1.5/10): **1.35**

  4.1.  La solución presentada en el paper, llamada Double-Dispatch utiliza polimorfismo para: (Fran)(1/10): 1

  4.2. Teniendo en cuenta el ejemplo del paper (Graphical Objects y Display Ports). (Fran)(1/10): 0

- Prácticos (Francisco): **6.89**
  - Resolucion (**2.5/14.75**): **1.825**
    - Resuelven el problema SIN IF (ya sea con State u otra opción válida) 2.25*0.7: 1.**575**
    - No tienen código repetido (por ej. entre #top y #pop. pop debería usar top) 0.25*1: **0.25**
  - Si usaron State: (**4.5/14.75**): **3.25**
    - La jerarquía de estados tiene superclase común abstracta 1*1: **1**
    - Los nombres de las clases de estados son buenos (hablan del estado y no si la pila ES vacía o ES NO vacía) 0.25*1: **0.25**
    - Los estados no rompen encapsulamento del stack, haciendo double dispatch para devolverle la responsabilidad al mismo 2*1: **2**
    - Nombre de contenido es bueno (contents o similar) 0.15*0: **0**
    - Usan #canHandle: o similar para transicion de estado 1.1*0: **0**
  - Si ron reificacion de base, tope, y celdaDeElementoStackeado: (4.5/14.75): **0**
    - Crearon jerarquia con superclase común abstracta 1*: **0**
    - El primer elemento está bien implementado, tipo Null Object 1.15*: **0**
    - El nombre para representar lo "no base" es bueno (azul con flecha) y está instanciado al problema (Ej PushedObjectCell vs Non-Empty Node) 0.25*: **0**
    - El nombre para representar lo "base" es bueno (cuadrado negro) y está instanciado al problema (Ej. StackBase vs. NullNode) 0.25*: **0**
    - El nombre del padre de la jerarquía es bueno y está instanciado al problema (Ej. StackTop vs Node) 0.25*: **0**
    - Usan buenos nombres para el elemento previo (ej: previous, y no next) 0.25*: **0**
    - StackBase no sabe responder previo y PushedObject #previous no requiere manejar errores 0.2*: **0**
    - Size lo resolvieron con Object Recursion (no hay optimizaciones tempranas de performance y potenciales problemas de mantenimiento de integridad) 1.15*: **0**
    - Si usaron hack (o sea closure base con envío de error dentro de una colección). Recordar que no es un stack general realmente ya que no admite guardar objetos que sepan responder value de forma no default: (0.25/14.75): **0**
    - Nombre de contenido es bueno (contents o similar) 0.25*: **0**
  - Testing (**3/14.75**): **2.81**
    - El metodo "find" y todos sus métodos auxiliares tienen código declarativo, no operacional (por ej. evitando do:). Recibe y utiliza un stack y no una lista para funcionar. 0.9*1: **0.9**
    - Llegaron a un Method Object, donde el prefijo puede validarse antes de incluso crearse la instancia de sentenceFinder 0.1*0: 0
    - Testean prefijo vacio, prefijo espacio/s y prefijo con espacios dan error (tres tests diferentes) 0.3*0.7: **0.21**
    - Testean búsqueda contra una pila vacia (que obviamente no encuentra nada) 0.2*1: **0.2**
    - Testean búsqueda con un prefijo válido que está en el stack 0.2*1: **0.2**
    - Testean búsqueda con un prefijo válido que no está en el stack 0.2*1: **0.2**
    - Testean que la búsqueda sea case sensitive (por ej. buscar un prefijo que exista en el stack pero con diferente case) 0.2*1: **0.2**
    - Testean la búsqueda de un prefijo válido en un stack de más de una oración y el resultado es más de una oración 0.2*1: **0.2**
    - Se testea que el stack quede en el mismo estado por lo menos con un test que busca en un stack con un elemento 0.5*1: **0.5**
    - Quita código repetido en los tests/aumenta su declaratividad creando y utilizando buenas abstracciones auxiliares por ej. para crear al stack de prueba 0.2*1: **0.2**

Comentarios del docente:

- No se debería crear un nuevo objeto `OOStackNonEmptyState` cada vez que se hace `push`.
- `ifEmpty` no es un buen nombre de mensaje. Queda muy acoplado el nombre del mensaje con la idea de una de las clases. Es una solución a medio camino del double-dispatch.
- Desde el punto de vista de representación de la realidad, no es correcto encadenar estados.
- La solución es un híbrido entre la solución con `state` y la solución con `base` y `elemento stackeado`, luego el diseño presentado no es simple de seguir.
- `OOStackState#elementCount` no es un buen nombre.

Saludos
