;; Define cast functions between Nat and Number
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; Knowledge base
!(bind! &kb (new-space))
!(add-atom &kb (Evaluation generates GPT))
!(add-atom &kb (Evaluation learns GPT))
!(add-atom &kb (Evaluation plays AlphaGo))
!(add-atom &kb (Inheritance GPT AI_Model))
!(add-atom &kb (Evaluation builds BostonDynamics))
!(add-atom &kb (Evaluation learns NeuralNetworks))
!(add-atom &kb (True))

;; Rule base
!(bind! &rb (new-space))
(=(generation-ai-rule) 
    (-> (Evaluation generates $x) 
          (Evaluation learns $x)
          (Inheritance $x AI_Model)))

(=(game-ai-rule) 
    (-> (Evaluation plays $x) 
          (Evaluation strategizes $x)
          (Inheritance $x Game_AI)))

(=(robotics-engineer-rule)
    (-> (Evaluation builds $x)
          (Evaluation designs $x)
          (Inheritance $x Robotic_Engineer)))

(=(deep-learning-rule) 
    (-> (Evaluation learns $x)
          (Evaluation processes $x)
          (Inheritance $x Neural_Network)))

!(add-reduct &rb (generation-ai-rule))
!(add-reduct &rb (game-ai-rule))
!(add-reduct &rb (robotics-engineer-rule))
!(add-reduct &rb (deep-learning-rule))

;; Forward chainer

;; Base case
(= (fc $premise $depth) $premise)
;; Recursive steps
(= (fc $premise1 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise2 (fc $conclusion $k))))

(= (fc $premise2 (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (match &kb $premise1 (fc $conclusion $k))))

!(fc (Evaluation generates GPT) (fromNumber 2))
!(fc (Evaluation designs BostonDynamics) (fromNumber 2))
!(fc (Evaluation processes NeuralNetworks) (fromNumber 2))
!(fc (Evaluation plays AlphaGo) (fromNumber 2))
