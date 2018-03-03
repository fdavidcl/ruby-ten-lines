#' ---
#' title: "Ruby en 10 líneas"
#' author: David Charte
#' date: 3 de marzo
#' institute: LibreIM
#' theme: metropolis
#' mainfont: Lato
#' monofont: Fira Mono
#' numbersections: true
#' header-includes: 
#'  - \metroset{
#'    background=light,
#'    sectionpage=progressbar,
#'    subsectionpage=none,
#'    numbering=none,
#'    progressbar=frametitle,
#'    block=fill,
#'    }
#'  - \definecolor{accent}{RGB}{151, 186, 88}
#'  - \colorlet{darkaccent}{accent!70!black}
#'  - \definecolor{foreground}{RGB}{0, 0, 0}
#'  - \definecolor{background}{RGB}{255, 255, 255}
#'  - \setbeamercolor{normal text}{fg=foreground, bg=background}
#'  - \setbeamercolor{alerted text}{fg=darkaccent, bg=background}
#'  - \setbeamercolor{example text}{fg=foreground, bg=background}
#'  - \setbeamercolor{frametitle}{fg=background, bg=accent}
#'  - \setbeamercolor{headtitle}{fg=background!70!accent,bg=accent!90!foreground}
#'  - \setbeamercolor{headnav}{fg=background,bg=accent!90!foreground}
#'  - \setbeamercolor{section in head/foot}{fg=background,bg=accent}
#'  - \hypersetup{
#'      colorlinks=false,
#'      linkbordercolor=background,
#'      urlbordercolor=accent,
#'      pdfborderstyle={/S/U/W 1}
#'    }
#' ---

#' # Sintaxis
#' ## 1. Saludar
#' ```ruby
#' puts "Hello #{gets.strip}!"
#' ```

#' . . .

#' Acepta una string por pantalla, la limpia e imprime un saludo que la contiene.

#' - Se pueden omitir paréntesis por legibilidad
#' - `puts` escribe, `gets` lee
#' - `#{...}` interpreta el contenido y lo incluye

#' ## 2. Are you bored yet?
#' ```ruby
puts "boooored".upcase unless Time.now.saturday?
#' ```

#' . . .

#' Ejemplo auto-descriptivo

#' - Los literales son objetos y aceptan métodos
#' - Estructuras `if`, `unless`, `while` y `until` en una línea
#' - Convención: los métodos booleanos acaban en `?`, los que tienen efectos secundarios no explícitos en `!`

#' ## 3. Partes real e imaginaria
#' ```ruby
real, imag = (1 + 3i).rectangular
#' ```

#' . . .

#' Asigna la parte real a `real` y la parte imaginaria a `imag`.

#' - Soporte para complejos (y enteros grandes, y racionales simbólicos...)
#' - La asignación permite *splat* de vectores. El *splat operator* `*` hace más cosas:
#'   ```ruby
#'   x, *xs = [1, 2, 3, 4]
#'   ```
#'   También hay un *double-splat* `**` para hashes


#' # Orientación a objetos
#' ## 4. Excepciones personalizadas
#' ```ruby
class DeadPlayerError < StandardError; end
#' ```

#' . . .

#' Define una clase que se puede utilizar para devolver errores.

#' - Las clases se definen con `class`
#' - Herencia simple con `<`
#' - Lanza un error con `raise DeadPlayerError`

#' ## 5. Estructuras simples
#' ```ruby
Point = Struct.new :x, :y, :z
#' ```

#' . . .

#' Crea una clase con métodos de acceso y asignación para los atributos dados.

#' - Los datos miembro de una clase son **siempre** privados. El punto sólo llama a métodos: `objeto.metodo`
#' - Se pueden añadir métodos en la definición mediante un block
#' - Se crean objetos con `Point.new`

#' # Iteración y estructuras de datos
#' ## 6. Mostrar array como lista numerada
#' \footnotesize
#' ```ruby
puts %w[such elegant wow].each_with_index.map { |w,i| "#{i}. #{w}" }
#' ```
#' \normalsize

#' . . .

#' Recorre el array, obtiene un array de strings *índice. elemento* y lo imprime.

#' - `%w[]` separa por espacios una tira de palabras
#' - `each_with_index` recorre dando cada elemento e índice
#' - `map` aplica una función sobre cada elemento y devuelve el resultado
#' - `{...}` o `do ... end` denotan *blocks*

#' ## 7. Producto escalar
#' \footnotesize
#' ```ruby
dot = ->(v1, v2) { v1.zip(v2).reduce(0) { |p, (n, m)| p + n * m } }
#' ```
#' \normalsize

#' . . .

#' Uso: `dot.([1, 2, 3], [-1, 0, 2])`

#' - Funciones lambda con `->`
#' - `zip` empareja los elementos de dos o más arrays
#' - `reduce` acumula resultados de una función binaria

#' ## 8. Cálculo perezoso de Fibonacci
#' \scriptsize
#' ```ruby
fib = Hash.new { |h, i| h[i] = h[i - 2] + h[i - 1] }.update(0 => 0, 1 => 1)
#' ```
#' \normalsize

#' . . .

#' Crea un Hash que contiene en cada índice el término correspondiente de la secuencia de Fibonacci.

#' - `Hash` tiene una inicialización por defecto (normalmente `nil`)
#' - `Hash#update` asigna varios valores a la vez
#' - Equivalente a una función recursiva memoizada

#' ## 9. Algoritmo de escalada simple
#' \scriptsize
#' ```ruby
#' solution.neighborhood.detect { |attempt, fitness| fitness > @current_fitness }
#' ```
#' \normalsize

#' . . .

#' Encuentra la primera solución del vecindario que mejora la función rendimiento. Uso real: <https://git.io/vPxQ6>

#' - `detect` recibe un predicado y devuelve el primer elemento del array que lo cumple
#' - Máxima pendiente? `max_by`
#' - Muchos más métodos de iteración: [`Enumerable`](https://ruby-doc.org/core-2.5.0/Enumerable.html)

#' # I/O
#' ## 10. Compilar una presentación
#' ```ruby
open(DATA.read, "w").write IO.read($0).gsub(/^#' /, "")
#' ```
#' \normalsize

#' . . .

#' Lee el propio programa, descomenta los comentarios marcados con `#'` 
#' y pasa el resultado como entrada al programa abierto por `Kernel#open`.

#' - `$0` es el nombre del programa en ejecución
#' - `gsub` hace sustitución global

#' . . .

#' *La trampa* \ La sección de datos de este mismo archivo contiene el comando
#' de terminal a ejecutar:
#' ```sh
#' __END__
#' |pandoc -t beamer -o test.pdf --pdf-engine=xelatex
#' ```

#' # Fin
#' ## Enlaces
#' ### Documentación

#' - `objeto.methods.sort` para buscar *a ojo*
#' - Para todo lo demás, [ruby-doc.org](http://ruby-doc.org/)

#' ### Misc

#' - [Hello Ruby](http://www.helloruby.com/)
#' - [awesome-ruby](https://github.com/markets/awesome-ruby)

#' \iffalse
__END__
|pandoc -t beamer -o test.pdf --standalone --pdf-engine=xelatex
#' \fi
