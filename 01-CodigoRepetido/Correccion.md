# Correcciones del ejercicio

Va con algunos comentarios extra.

La nota de esta entrega es: $8.2 \times .3 + 6.63 \times .7=7.1$. La misma se
obtiene de la sumatoria de la nota de cada tema evaluado.

Los temas evaluados según su puntaje son:

- Teóricos: **8.2**
1. 1. Describa en un parrafo breve a que se refiere Naur con "construir teoria"
   (Maxi)(1.25/10): **1.25**
1. 2. Relacione el paper con la idea de documentar (Maxi)(1.25/10): **1**
2. 1. Los tipos de visibilidad que discutimos en clase son: (Nico)(1.25/10):
   **0.83**
2. 2. Describa cada uno de los tipos de visibilidad vistos, el modelo conceptual
   y los affordances de los interruptores de luz del labo 1108. (Nivo)(1.25/10):
   **0.88**
3. 1. Describa un ejemplo en no mas de 4 lineas sobre complejidad accidental.
   (Maxi)(1.25/10): **1.25**
3. 2. Como relaciona Brooks la ley de Moore con el software ? (Maxi)(1.25/10):
   **1.25**
4. 1. Nombre y explique las 3 ideas en las que se basa Self. (Fran)(1.25/10):
   **1.13**
4. 2. a. En Self los objetos se crean a partir de: (Fran)(0.63/10): **0.63**
4. 2. b. En Self, la noción de Blending state and behavior se refiere a ...
(Fran)(0.63/10): **0**

- Prácticos (Julian): **6.63**
    - Resolución (5/10.5): **3.625**
        - Resolver correctamente la primera parte (parametrizan closure y
          tiempo). Si lo que envian como colaborador de tiempo es un número sin
          la unidad, resta puntos. 1.5*1: **1.5**
        - Hacen abstracción intermedia propia en primera parte para mejorar
          declaratividad #timeToRun o similar dentro del should... (_Fines
          estadísticos_) 0*0: 0
        - Utilizan abstracción intermedia ya provista por el lenguaje como
        #timeToRun de closure en primera parte para mejorar declaratividad dentro
        del should... (_Fines estadísticos_) 0*0: 0
        - Resolver correctamente la segunda parte (param. closure, exc. type y
          handler) (Si no incluye la colaboración self fail en el nuevo objeto,
          la nota es 0) Los test 07 y 08 se suman a los 03 y 04... 1.5*0.75: **1.125**
        - Resolver correctamente la tercera parte del ejercicio (código repetido
          en removeCustomerNamed: de CustomerBook) 2*0.5: **1**
        - Hacen abstracción intermedia propia en la tercera parte
          #remove:on:ifAbsent o similar (_Fines estadísticos_) 0*0: 0
        - Utilizan abstracción intermedia ya provista por el lenguaje como
          #remove:ifAbsent de colecciones en tercera parte (_Fines estadísticos_) 0*0: 0
    - Código Repetido (3/10.5): **2**
        - Sacar el código repetido de suspend usando la nueva abstracción creada
        0.5*0: **0**
        - Sacar el código repetido del addCustomerNamed: utilizando el
          includesCustomerNamed: 0.5*0: **0**
        - Sacar el código repetido de los asserts para el test 05 y 06 0.5*1: **0.5**
        - Buenos nombres de mensajes (assert..., should..., etc) No hace falta
          poner el millisecond en el nombre del mensaje porque se debería pasar
          el tiempo con su unidad 1.5*1: **1.5**
    - Organización del Código (2.5/10.5): **1**
        - Buenos nombres para los colaboradores (limit, exceptionTypeToHandle,
          etc) Malos nombres, genéricos como milliseconds vs limit o anError vs
          exceptionTypeToHandle o aBlock vs aBlockToMeasure van restando, y se puede
          llegar a 0 si son todos genéricos y ninguno referencia al rol que ocupan en la
          colaboración 1*0.75: **0.75**
        - Categorizar los nuevos mensajes? En categorias correctas? 0.5*0.5: **0.25**
        - Usar #millisecondsToRun: o #timeToRun o #remove:ifAbsent: PROPIOS o
          provistos por el lenguaje 0.5*0: **0**
        - (Extra: Usar correctamente setUp para código repetido de todo el test o
          algun método propio similar) 0.5*0: **0**
    - Comentarios del docente:
        - Intenten profundizar un poco mas el nombre de colaboradores internos
          para adaptarlos mejor al rol que cumplen en el metodo. Por ejemplo
          "aBlockToMeasure" en vez de solo "aBlock" en el metodo que miden tiempo,
          "aBlockExpectedToFail" en vez de solo "aBlock" en el metodo que toma closures
          que tienen que fallar, "aCustomerNameToRemove", en vez de "aName" y asi...
        - Aux methods no es un buen nombre de categoria, que tipos de metodos
          entran ahi y cuales no? Categorias como "private", "assertion", "error
          messages", o cualquier otra que tenga que ver con el dominio especifico del
          problema son mucho mas descriptivas.
        - No hay evidencia para parametrizar el customerBook en #assertThat:
          aCustomerBook after: aBlock throws: anError andHasSingleCustomerNamed:
          aName. Para eso hubiera hecho falta algun test donde se ejerciten dos
          customerBooks distintos (y aun ahi, habria que ver el contexto). Fijense que
          solo alcanzaba con que se ejecute el bloque con el customerBook dentro, que es
          como efectivamente terminaron resolviendo ese metodo.
        - Les quedo codigo repetido en removeCustomerNamed
