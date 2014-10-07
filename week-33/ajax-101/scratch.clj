(ns user
  (require [clj-http.client :as client]
           [clojure.data.json :as json]))

(:trace-redirects (client/get "http://google.com"))

(keys (client/get "http://google.com"))

(:body (client/post "http://localhost:3000/data/?rows=2&cols=2"))

(-> (client/post "http://localhost:3000/data/?rows=2&cols=2")
    :body
    (clojure.string/split #"\n")
    rest
    )


;; Playing with threading forms:

(->> [1 2 3 12 56 53]
     (map inc))


(as-> [1 2 3 35 65 2]
      X
      (map inc X)
      (map (fn [a] (* a a)) X)
      )

(  (fn [s] (Integer/parseInt s))
   "219"
)

(  #(Integer/parseInt %)
   "219"
)


(Integer/parseInt "23")

(as-> (client/post "http://localhost:3000/data/?rows=2&cols=2")
       X
       (:body X)
       (clojure.string/split X #"\n")
       (rest X)
       (map (fn [s] (clojure.string/split s #",")) X)
       (map (fn [int-str-seq] (map #(Integer/parseInt %)
                                   int-str-seq))
            X)
    )

(let [X (client/post "http://localhost:3000/data/?rows=2&cols=2")
      X (:body X)
      X (clojure.string/split X #"\n")
      X (rest X)]
  X)


(let [response (client/post "http://localhost:3000/data/?rows=2&cols=2")
      body (:body response)
      limit 100                              ;; Not part of the threading
      lines (clojure.string/split body #"\n")
      my-file (java.io.File. "MyFile.txt")   ;; Also not part of the threading
      content-lines (rest lines)]
  content-lines)

;; Is this better than the original "->" form? We get to name the intermediate
;; forms, but we lose the clean, obvious structure of the threading.
