(ns user
  (:require [clj-http.client :as client]
            [clojure.data.json :as json]))

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

;; The future: look at our Compojure headers:
(client/get "http://localhost:3000")

(defn get-city [name]
  (try
    (let [result (-> (client/get (str "http://api.openweathermap.org/data/2.5/weather?q=" name))
                     (:body)
                     (json/read-str :key-fn keyword))
          code (str (:cod result))]
    (if (= code "404")
       {:error (:message result)}
       result))

    (catch Exception e {:error (.getMessage e)})))

(get-city "London")

(defn lat [city]
  (-> (get-city city)
      (get-in [:coord :lat])
    ))

(defn lon [city]
  (-> (get-city city)
      (get-in [:coord :lon])
    ))

(lon "London")

(def does-not-work
  (client/get "http://api.openweathermap.org/data/2.5/find/city?bbox=12,32,15,37,10&cluster=yes"))

;; Get N cities around a latitude and longitude.

(-> (client/get "http://api.openweathermap.org/data/2.5/find?lat=55.5&lon=37.5&cnt=1")
    :body
    (json/read-str :key-fn keyword))

;; Extract the fields we're interested in. (I have no idea how scale is worked out - if at all?)
;; Fold down into SCV form.

(map (fn [x] (format "%s,%s,%s"
                    (get-in x [:coord :lat])
                    (get-in x [:coord :lon])
                    (:name x)))
     (-> (client/get "http://api.openweathermap.org/data/2.5/find?lat=55.5&lon=37.5&cnt=10")
         :body
         (json/read-str :key-fn keyword)
         :list))





;; FUTURE: Can we get the region around a named city? (Remember the lat/lon lookup from last time?)
