(defproject my-weather-project "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [clj-http "0.9.2"]
                 [org.clojure/data.json "0.2.5"]
                 [lein-light-nrepl "0.0.18"]]
  :repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops]
                 :port 9876})
