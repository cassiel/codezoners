(ns user
  (require [clj-http.client :as client]
           [clojure.data.json :as json]))

(client/get "http://www.google.com")
