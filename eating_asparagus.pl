ought(not(eat_with_fingers)).
strict(r1, [eating_asparagus], ought(eat_with_fingers)).

fact(eating_asparagus).    

fact(none).
defeasible(dummy, [dummy], none).
defeater(dummy, [dummy], none).
precedence(dummy, dummy).    
