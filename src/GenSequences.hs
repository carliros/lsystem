-- | Describes how to generate the sequences of an L-System grammar
module GenSequences where

import SistemaL

generate :: SistemaL -> Int -> [Simbolo]
generate (SistemaL _ _ init prods) n = generate' init prods n
    where generate' seq prods 0 = seq
          generate' seq prods n = let seq' = concat [lst | s1 <- seq, (s2,lst) <- prods, s1 == s2]
                                  in generate' seq' prods (n-1)


