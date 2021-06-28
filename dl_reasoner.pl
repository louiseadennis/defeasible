:- dynamic ought/2.
:- dynamic fact/1.
:- dynamic precendence/2.

converse(ought(not(X)), ought(X)):- !.
converse(ought(X), ought(not(X))) :-!.
converse(not(X), X):- !.
converse(X, not(X)).

precedence(C1, C3):-
    ground(C3),
    precedence(C1, C2),
    precedence(C2, C3).

provable(definite, X, [X]):- fact(X).
provable(definite, X, [X | [R | Derivation]]):-
    strict(R, Antecedants, X),
    provable_list(definite, Antecedants, Derivation).

provable_list(_, [], []).
provable_list(Type, [H|T], Out):-
    provable(Type, H, Out1),
    provable_list(Type, T, Out2),
    append(Out1, Out2, Out).

not_provable(definite, X):- \+ fact(X),
    \+ (strict(R, Antecedants, X),
    provable_list(definite, Antecedants, _)).

not_provable_list(_, []) :- fail.
not_provable_list(Type, [H|T]):-
    not_provable(Type, H).
not_provable_list(Type, [H|T]):-
    not_provable_list(Type, T).

rule_sd(R, Antecedants, X):- strict(R, Antecedants, X).
rule_sd(R, Antecedants, X):- defeasible(R, Antecedants, X).
rule_sd(R, [], ought(X)):- ought(R, X).

rule(R, Antecedants, X):- strict(R, Antecedants, X).
rule(R, Antecedants, X):- defeasible(R, Antecedants, X).
rule(R, Antecedants, X):- defeater(R, Antecedants, X).
rule(R, [], ought(X)):- ought(R, X).

provable(defeasible, X, Derivation) :- provable(definite, X, Derivation).
provable(defeasible, X, [X | [R | Derivation]]):-
    rule_sd(R, Antecedants, X),
    provable_list(defeasible, Antecedants, Derivation),
    converse(X, Xc),
    not_provable(definite, Xc),
    \+ (rule(R1, A, Xc), none_not_defeasible(A), precedence(R1, R), write("b")).
     
none_not_defeasible([]).
none_not_defeasible([H|T]):-
     not_provable(defeasible, H), !,
     fail.
none_not_defeasible([H|T]):-
     none_not_defeasible(T).

not_provable(defeasible, X):-
    not_provable(definite, X),!,
    not_provable2(defeasible, X).
not_provable2(defeasible, X):-
    \+ (rule_sd(R, Antecedants, X),
        none_not_defeasible(Antecedants)).
not_provable2(defeasible, X):-
    converse(X, Xc),
    provable(definite, Xc, _).
not_provable2(defeasible, X):-
    converse(X, Xc),
    rule(R, Antecedants, Xc),
    provable_list(defeasible, Antecedants, _),
    \+(rule_sd(R1, A, X);
    none_not_defeasible(A),
    precedence(R1, R)).

ought(dummy, dummy).
