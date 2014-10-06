(defproject ajax-weather "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [compojure "1.1.8"]
                 [clj-http "1.0.0"]
                 [org.clojure/data.json "0.2.5"]
                 [hiccup "1.0.5"]
                 [lein-light-nrepl "0.0.18"]]
  :plugins [[lein-ring "0.8.11"]
            ;; This line for connecting to a REPL from Emacs:
            [cider/cider-nrepl "0.7.0"]]
  :ring {:handler ajax-weather.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring-mock "0.1.5"]]}}
  :repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops]
                 :port 9876})
