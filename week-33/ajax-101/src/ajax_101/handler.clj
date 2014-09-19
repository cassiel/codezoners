(ns ajax-101.handler
  (:require [compojure.core :refer :all]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [hiccup.core :refer :all]
            [hiccup.page :as page]))

(defn create-CSV [rows cols]
  (let [text-rows
        (for [r (range rows)
              c (range cols)]
          (format "%d,%d,5" (* (inc c) 20) (* (inc r) 20)))]
    (clojure.string/join "\n"
                         (conj text-rows "x,y,r"))))

(defn page
  "We can return the same page content (containing an SVG) differing only by the
   particular JS file it includes."
  [i]
  (html [:head
         [:title (format "Testing Circles [%d]" i)]

         (page/include-js "https://cdnjs.cloudflare.com/ajax/libs/d3/3.4.1/d3.min.js")
         (page/include-js (format "/__js/circles%d.js" i))
         ;; See also: (include-css ...)
         ]
        [:body
         [:svg {:width 720 :height 360}]
         [:div
          [:span "Rows:"]
          (for [r (range 1 6)]
                 [:input {:name "updateButton"
                          :type "button"
                          :value (str r)
                          :onclick (format "clickRow(%d)" r)}])]
         [:div
          [:span "Cols:"]
          (for [c (range 1 6)]
                 [:input {:name "updateButton"
                          :type "button"
                          :value (str c)
                          :onclick (format "clickCol(%d)" c)}])]]))

(defroutes app-routes
  (GET "/" [] (html [:ul (for [i (range 1 4)] [:li [:a {:href (format "/circles/%d" i)}
                                                    (format  "Circles example %d" i)]])]))
  (GET "/circles/:id" [id] (page (Integer/parseInt id)))
  (POST "/data/" [rows cols] (create-CSV (Integer/parseInt rows)
                                         (Integer/parseInt cols)))
  (route/resources "/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
