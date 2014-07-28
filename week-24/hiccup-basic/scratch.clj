(ns user (:require [hiccup.core :as h]))

(h/html [:body [:span {:class "foo"} "bar"]])

;; To output to a file, look at `spit`, http://clojuredocs.org/clojure_core/clojure.core/spit
