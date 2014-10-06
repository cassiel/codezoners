(ns ajax-weather.handler
  (:require [compojure.core :refer :all]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [hiccup.core :refer :all]
            [hiccup.page :as page]
            [clj-http.client :as client]
            [clojure.data.json :as json]))

(defn create-CSV
  "This is the meat and potatoes of the app: request an area by latitude and longitude,
   turn the results into a CSV file."
  [lat lon]
  (let [items (-> (client/get (format "http://api.openweathermap.org/data/2.5/find?lat=%f&lon=%f&cnt=10"
                                      (float lat)
                                      (float lon)))
                  :body
                  (json/read-str :key-fn keyword)
                  :list)
        text-rows (map (fn [x] (format "%s,%s,%s"
                                      (get-in x [:coord :lat])
                                      (get-in x [:coord :lon])
                                      (:name x))) items)]
    (clojure.string/join "\n"
                         (conj text-rows "x,y,name"))))

(create-CSV 0 0)

(defn page
  "We can return the same page content (containing an SVG) differing only by the
   particular JS file it includes."
  [i]
  (html [:head
         [:title (format "Testing Maps [%d]" i)]

         (page/include-js "https://cdnjs.cloudflare.com/ajax/libs/d3/3.4.1/d3.min.js")
         (page/include-js (format "/__js/map%d.js" i))
         ;; See also: (include-css ...)
         ]
        [:body
         [:svg {:width 500 :height 500}]]))

(defroutes app-routes
  (GET "/" [] (html [:ul (for [i (range 1 3)] [:li [:a {:href (format "/map/%d" i)}
                                                    (format  "Map example %d" i)]])]))
  (GET "/map/:id" [id] (page (Integer/parseInt id)))
  (POST "/data/" [lat lon] (create-CSV (Float/parseFloat lat) (Float/parseFloat lon)))
  (route/resources "/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
