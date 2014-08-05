(require '[clojure.xml :as xml]
         '[clojure.zip :as zip])


(def output
(xml/parse (java.io.ByteArrayInputStream.
            (.getBytes "<a href='nakkaya.com'>AAA<div>Fooble</div><div>Hello World</div>ZZZ</a>"))))

output



(:attrs output)

(:href (:attrs output))

((((output :content) 1) :content) 0)

(:attrs output)

(-> output (:attrs)
           (:href))

(-> output (:content)
           (nth 1)
           (:content)
           (nth 0))

(get-in output [:content 1 :content 0])





(require '[clj-http.client :as client])


(client/get "http://google.com")
