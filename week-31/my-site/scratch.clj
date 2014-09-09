(ns user
  (:require [clj-http.client :as client]))


(:body (client/get "http://www.google.com"))

(get-in (client/get "http://localhost:3000/test/") [:headers])

(get-in (client/get "http://localhost:3000/test/") [:body])




(slurp "/Users/nick/Desktop/foo.text")







(-> (slurp "/Users/nick/Desktop/foo.text")
    (clojure.string/replace "\n" "<BR/>"))



































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
