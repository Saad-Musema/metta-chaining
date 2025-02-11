;; Define cast functions between Nat and Number
(: fromNumber (-> Number Atom))
(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))

;; Knowledge base
!(bind! &kb (new-space))
!(add-atom &kb (Evaluation plays GPT))
!(add-atom &kb (Evaluation plays AlphaGo))
!(add-atom &kb (Evaluation strategizes AlphaGo))
!(add-atom &kb (Evaluation generates GPT))
;!(add-atom &kb (Inheritance GPT AI_Model))
;!(add-atom &kb (Inheritance AlphaGo Game_AI))
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

;; Backward chainer
(: bc_ai (-> Atom Nat Atom))
;; Base case
(= (bc_ai $conclusion $depth)
   (match &kb $conclusion $conclusion))

;; Recursive step
(= (bc_ai $conclusion (S $k))
   (match &rb (-> $premise1 $premise2 $conclusion)
          (let* (($premise1 (bc_ai $premise1 $k))
                 ($premise2 (bc_ai $premise2 $k)))
            $conclusion)))

;; Run the backward chainer to find out "What is an AI Model?" by defining a target
!(bc_ai (Inheritance $what AI_Model) (fromNumber 2))
;!(bc_ai (Inheritance $what Game_AI) (fromNumber 2))
