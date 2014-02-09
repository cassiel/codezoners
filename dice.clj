(defn roll-dice [n]
  (if (= n 0)
    0
    (+ 1
       (rand-int 6)
       (roll-dice (dec n)))))

(roll-dice 3)
