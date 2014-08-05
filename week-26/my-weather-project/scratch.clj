;; Java calls
(new java.util.Date)

;; Function calls
(+ 1 2 3 4)

;; Declaring functions
(defn foo [x y] (+ x (* x y)))

;; Declaring plain values

(def a 10)
(def b "Hello world")

(def f
  (fn [x] (+ x x)))

(f 10)

(f (f 10))

[1 2 3 4 5]

(nth [1 2 3 4 5] 3)

:A
"A"

;; Maps:
(def my-map {:A 1
             :B 5
             "KEY" "Hello world"})

my-map

(get my-map :A)

(:A my-map)

(my-map :A)
(my-map "KEY")

;; "Updating" a map using assoc:

(assoc my-map :A "New value")
my-map

;; Vector as function:
([1 2 3 4] 3)

(map f [1 10 -3 0.7 2/3])

(map (fn [i] (/ 2 (inc i))) (range))
