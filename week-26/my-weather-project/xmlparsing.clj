(require '[clojure.xml :as xml]
         '[clojure.zip :as zip])


(def output
(xml/parse (java.io.ByteArrayInputStream.
            (.getBytes "<a href='nakkaya.com'>AAA<div>Fooble</div><div>Hello World</div>ZZZ</a>"))))

output



(:attrs output)

(:href (:attrs output))

((((output :content) 1) :content) 0)

(:attrs output)

(-> output (:attrs)
           (:href))

(-> output (:content)
           (nth 1)
           (:content)
           (nth 0))

(get-in output [:content 1 :content 0])

;; First steps: look at google.com headers and content.

(require '[clj-http.client :as client])

(get
    (:headers (client/get "http://google.com"))
     "Content-Type")

(-> (client/get "http://google.com")
    (:headers)
    (get "Content-Type"))

(-> (client/get "http://google.com")
    (:headers)
    (keys))

(-> (client/get "http://google.com")
    (:body))


(get my-map :X 4 "A")

(-> my-map
    (get     :X 4 "A")
    (foo 1 2 3))


(map inc [1 10 -3 20])

(->> [1 10 -3 20]
     (map inc)
     (filter even?))

(filter even? [1 2 3 4 5 6 7 8 10 -4 12])

;; Second steps: look at weather API.

(count "Hello World")

(->> "Hello World"
    (sort)
    (reduce str))



(-> (client/get "http://api.openweathermap.org/data/2.5/weather?q=London&mode=xml")
    ;;(get "Transfer-Encoding")
    :body
   )


;; See all the tags provided within :content :

(->> (xml/parse "http://api.openweathermap.org/data/2.5/weather?q=London&mode=xml")
    :content

    )

;; Get the entry with :tag = :city, then get latitude :

(as-> (xml/parse "http://api.openweathermap.org/data/2.5/weather?q=London&mode=xml") x
      (:content x)
      ;; get me the one where :tag has the value :city
      (filter (fn [x] (= (:tag x) :city)) x)
      (nth x 0)           ;; See also "some".
      (:content x)
      (nth x 0)
      (:attrs x)
      (:lat x)
      (Float/parseFloat x)
    )

;; Do the same in a single `get-in` call (note that we have to re-vectorise in order to
;; use array index as a key):

(as-> (xml/parse "http://api.openweathermap.org/data/2.5/weather?q=London&mode=xml") x
      (:content x)
      ;; get me the one where :tag has the value :city
      (filter (fn [x] (= (:tag x) :city)) x)
      (vec x)
      (get-in x [0 :content 0 :attrs :lat])
      (Float/parseFloat x)
    )

(get-in (range 10) [2])

([1 2 3 4 5 6 7] 4)

(let [x (+ 2 4)]
  [x x 22 x x (/ 1 x)])

(defn lat [city]
  (as-> (xml/parse (str "http://api.openweathermap.org/data/2.5/weather?q=" city "&mode=xml")) x
      (:content x)
      ;; get me the one where :tag has the value :city
      (filter (fn [x] (= (:tag x) :city)) x)
      (vec x)
      (get-in x [0 :content 0 :attrs :lat])
      (Float/parseFloat x)
    ))

(lat "London")
(lat "Toronto")
(lat "Berlin")
(lat "Svalbard")
(lat "Lagos")
(lat "Canberra")

;; Think about error handling:

(lat 5754367676934674398)

;; Wrap everything up into a function which takes city name as argument:

(defn info [city]
  ...
) ;; => {:lat 51.51 :lon -0.13 :temp 18.0}

(info "London")
