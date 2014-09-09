(defproject my-site "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [compojure "1.1.8"]
                 [clj-http "1.0.0"]
                 [hiccup "1.0.5"]]
  :plugins [[lein-ring "0.8.11"]]
  :ring {:handler my-site.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring-mock "0.1.5"]]}})
