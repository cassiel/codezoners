(ns user
  (:require [clj-http.client :as client]))


(:body (client/get "http://www.google.com"))

(get-in (client/get "http://localhost:3000/test/") [:headers])

(get-in (client/get "http://localhost:3000/test/") [:body])


(ancestors (class {:A 2}))


(slurp "/Users/nick/Desktop/foo.text")

(ancestors (class {:A 1}))

(ancestors (class :A))

(class "Hello")

(class :A)

(ancestors (class [1 2 3 4 5]))

(map ["A" "B" 24 5.6 []]
     [0 2 1])

({:A 1 :B 2} :A)

(-> (slurp "/Users/nick/Desktop/foo.text")
    (clojure.string/replace "\n" "<BR/>"))

(:A {:A 1 :B 2})
({:A 1 :B 2} :A)




(seq {:A 1 :B 3})


( (fn [ [x y z] ] {:x x :y y :z z})

  [12 "Hello" :A [1 2 3]]
)


(class {:A 1 :B 23})












(let [x 3] (* x x))



(for [x (range 10)] (* x x))







(ns user (:require [hiccup.core :refer :all]))



(range 10)

(html [:h1 "Hello"])

(html [:script])
(html [:p "F"])

(html [:div#foo.bar.baz "bang"])

(html [:ul (for [x (range 1 4)]
                 [:li x])])

[:h1 (java.util.Date.)]

(html [:h1 (java.util.Date.)])


