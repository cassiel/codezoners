(ns weather-server.handler
  (:require [compojure.core :refer :all]
            [compojure.handler :as handler]
            [compojure.route :as route]))

(defroutes app-routes
  (GET "/" [] (format "<HTML><HEAD></HEAD><BODY><H1>%s</H1></BODY></HTML>" (java.util.Date.)))
  (route/resources "/resource/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
