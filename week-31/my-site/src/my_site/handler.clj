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
  (GET "/foo/" request
       #_ (html [:ul [:li (get-in request [:params :val1])]])
       (html [:ul (for [[fst snd] (get-in request [:params])]
                    [:li [:tt fst] " -> " [:tt snd]])])
       #_ (str request))
  (GET "/test/" [] (str "<P>" (-> (slurp "/Users/nick/Desktop/foo.text")
                                  (clojure.string/replace "\n" "<BR/>"))
                        "</P>"))
  (GET "/form/" []
       (html [:form {:action "/foo/" :method "GET"}
                [:input {:type "text" :name "val1"}]
                [:input {:type "text" :name "val2"}]
                [:input {:type "text" :name "another-val"}]
                [:input {:type "text" :name "and-another"}]
                [:input {:type "submit" :value "Submit"}]]))
  (route/resources "/static/")
  (route/not-found "Not Found"))

(def app
  (handler/site app-routes))
