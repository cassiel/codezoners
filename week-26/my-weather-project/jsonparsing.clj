;; First steps: look at google.com headers and content.

(require '[clj-http.client :as client])
(require '[clojure.data.json :as json])

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

(keyword "HELLO")


(defn get-city [name]
  (let [result (-> (client/get (str "http://api.openweathermap.org/data/2.5/weather?q=" name))
                   (:body)
                   (json/read-str :key-fn keyword))
        code (str (:cod result))]
    (if (= code "404")
       nil
       result)
      ))


(get-city "London")

(get-city "fejifewhfwiofhioweh")

(defn lat [city]
  (-> (get-city city)
      (get-in [:coord :lon])
    ))

(defn lat' [city]
  (let [c (get-city city)]
    (get-in c [:coord :lon])))

(lat' "London")


(defn info [city]
  ...
) ;; => {:lat 51.51 :lon -0.13 :temp 18.0}




;; See all the tags provided within :content :

;; This no longer helps us: we need to parse JSON, because errors come back as
;; JSON even if we ask for XML.

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

(lat "London")
(lat "Toronto")
(lat "Berlin")
(lat "Svalbard")
(lat "Lagos")
(lat "Canberra")

;; Think about error handling:

(lat "123456789")

;; Wrap everything up into a function which takes city name as argument:

(defn info [city]
  ...
) ;; => {:lat 51.51 :lon -0.13 :temp 18.0}

(info "London")
