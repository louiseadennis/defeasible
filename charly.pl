strict(r1, [whale(X)], mammal(X)).
strict(r4, [fox(X)], mammal(X)).

defeasible(r2, [mammal(X)], lives_on_land(X)).
defeater(r3, [whale(X)], not(lives_on_land(X))).

precedence(r3, r2).

fact(whale(charly)).
fact(fox(reynard)).

