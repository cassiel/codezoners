;; A general protocol for vehicles:

(defprotocol VEHICLE
  (model-name [x])
  (start [x])
  (stop [x])
  (accelerate [x amount])
  (reverse [x])
  (get-speed [x]))

;; A way of making cars:

(defn make-car [speed]
  (reify VEHICLE
    (model-name [x] "Ford Cortina")
    (start [x] x)
    (stop [x] x)
    (accelerate [x amount] (make-car (+ speed amount)))
    (reverse [x] (make-car (- speed)))
    (get-speed [x] speed)))

(def c (make-car 50))

(get-speed (reverse c))

(get-speed (accelerate c 10))

(defprotocol TREE
  (data [x])
  (left [x])
  (right [x])
  (tostring [x]))

(defn leaf [d]
  (reify TREE
    (data [x] d)
    (left [x] nil)
    (right [x] nil)
    (tostring [x] (str d))))

(defn node [d l r]
  (reify TREE
    (data [x] d)
    (left [x] l)
    (right [x] r)
    (tostring [x] (str "[" d ","  (when l (tostring l))
                                  ","
                                  (when r (tostring r))
                       "]"))))

(str nil)

(defn make-list [items]
  (let [h (first items)
        t (rest items)]
    (if (empty? t)
      (leaf h)
      (node h (make-list t) nil))
    )
  )

(tostring (make-list (range 10)))

(tostring (leaf 34))

(tostring (node 34 (leaf 99) (node "Hello" (leaf 1) (leaf 2))))


(defn my-runnable []
  (reify Runnable
    (run [x]
      (doseq [x (range 500)]
        (Thread/sleep 10)
        #_ (println "DONE " x)))))

(doseq [x (range 100)]
  (.start (Thread. (my-runnable))))


(println "Hello")

(doseq [x (range 5)]
  (Thread/sleep 1000)
  (println "DONE " x))



