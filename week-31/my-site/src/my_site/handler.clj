(ns my-site.handler
  (:require [compojure.core :refer :all]
            [compojure.handler :as handler]
            [compojure.route :as route]))

(defroutes app-routes
  (GET "/" [] (str "<H1>" (java.util.Date.) "</H1>"))
  (GET "/test/" [] (str "<P>" (-> (slurp "/Users/nick/Desktop/foo.text")
                                  (clojure.string/replace "\n" "<BR/>"))
                        "</P>"))
  (route/resources "/static/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
