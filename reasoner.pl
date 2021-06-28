converse(ought(not(X)), ought(X)):- !.
converse(ought(X), ought(not(X))) :-!.
converse(not(X), X):- !.
converse(X, not(X)).

precedence(C1, C3):-
    ground(C3),
    precedence(C1, C2),
    precedence(C2, C3).

provable(_, X, [X]):- fact(X).
provable(Any, X, [X | [R | Derivation]]):-
    strict(R, Antecedants, X),
    provable_list(Any, Antecedants, Derivation).

provable_list(_, [], []).
provable_list(Type, [H|T], Out):-
    provable(Type, H, Out1),
    provable_list(Type, T, Out2),
    append(Out1, Out2, Out).

not_provable(definite, X):- \+ fact(X),
    \+ (strict(R, Antecedants, X),
    provable_list(definite, Antecedants, _)).

provable(defeasible, X, _) :- not_provable(defeasible, X, _), !, fail.
provable(Type, ought(X), [ought(X), R]):- \+ Type == definite, ought(R, X).    
provable(Type, X, [X | [R | Derivation]]):-
    \+ Type == definite,
    defeasible(R, Antecedants, X),
    write(X),
    write(Antecedants),
    provable_list(Type, Antecedants, Derivation).

not_provable(defeasible, X, _):- converse(X, Xc),
    provable(definite, Xc, _), !.
not_provable(defeasible, X, _):-
    defeasible(R, _, X),
    converse(X, Xc),
    provable(general, Xc, [Xc | [R1 | _]]),
    precedence(R1, R), !.

provable(general, X, [X | [R | Derivation]]):-
    defeater(R, Antecedants, X),
    provable_list(general, Antecedants, Derivation).
