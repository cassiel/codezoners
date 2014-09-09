(ns my-site.handler
  (:require [compojure.core :refer :all]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [hiccup.core :refer :all]))

(defroutes app-routes
  (GET "/" [] (html [:html
                     [:head [:title "Random Numbers"]]
                     [:body
                      [:h1 (java.util.Date.)]
                      [:ul (for [x (range 1 21)] [:li x
                                                  " -> "
                                                  [:tt (rand)]])]]]))
  (GET "/test/" [] (str "<P>" (-> (slurp "/Users/nick/Desktop/foo.text")
                                  (clojure.string/replace "\n" "<BR/>"))
                        "</P>"))
  (route/resources "/static/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
