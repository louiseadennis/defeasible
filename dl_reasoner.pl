:- dynamic ought/3.
:- dynamic fact/1.
:- dynamic precendence/2.
:- dynamic strict/3.

complement_o(ought(C, X), ought(C, not(X))):- \+ (X = not(_)).
complement_o(ought(C, not(X)), ought(C, X)).
complement_dl(not(X), X):- !.
complement_dl(X, not(X)):- \+ (X = not(_)).

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
    \+ (strict(_, Antecedants, X),
    provable_list(definite, Antecedants, _)).

not_provable_list(_, []) :- fail.
not_provable_list(Type, [H|_]):-
    not_provable(Type, H).
not_provable_list(Type, [_|T]):-
    not_provable_list(Type, T).

rule_sd(R, Antecedants, X):- strict(R, Antecedants, X).
rule_sd(R, Antecedants, X):- defeasible(R, Antecedants, X).
rule_sd(R, [], ought(I, X)):- ought(R, I, X).

rule(R, Antecedants, X):- strict(R, Antecedants, X).
rule(R, Antecedants, X):- defeasible(R, Antecedants, X).
rule(R, Antecedants, X):- defeater(R, Antecedants, X).
rule(R, [], ought(I, X)):- ought(R, I, X).

provable(defeasible, X, Derivation) :- provable(definite, X, Derivation).
provable(defeasible, ought(C, X), [ought(C, X) | [R | Derivation]]):- !,
    rule_sd(R, Antecedants, ought(C, X)),
    provable_list(defeasible, Antecedants, Derivation),
    complement_dl(X, Xc),
    not_provable(definite, ought(C, Xc)),
    \+ (rule(R1, A, ought(C, Xc)), none_not_defeasible(A), precedence(R1, R)),
    complement_dl(ought(C, X), Y),
    not_provable(definite, Y),
    \+ (rule(R2, A2, Y), none_not_defeasible(A2), precedence(R2, R)).
provable(defeasible, not(ought(C, X)), [not(ought(C, X)) | [R | Derivation]]):- !,
    rule_sd(R, Antecedants, ought(C, X)),
    provable_list(defeasible, Antecedants, Derivation),
    complement_dl(X, Xc),
    not_provable(definite, not(ought(C, Xc))),
    \+ (rule(R1, A, not(ought(C, Xc))), none_not_defeasible(A), precedence(R1, R)),
    complement_dl(not(ought(C, X)), Y),
    not_provable(definite, Y),
    \+ (rule(R2, A2, Y), none_not_defeasible(A2), precedence(R2, R)).
provable(defeasible, X, [X | [R | Derivation]]):-
    rule_sd(R, Antecedants, X),
    provable_list(defeasible, Antecedants, Derivation),
    complement_dl(X, Xc),
write(R),
    write(Xc),
    not_provable(definite, Xc),
    \+ (rule(R1, A, Xc), write(R1), none_not_defeasible(A), write("here"), precedence(R1, R)).
     
none_not_defeasible([]).
none_not_defeasible([H|_]):-
     not_provable(defeasible, H), !,
     fail.
none_not_defeasible([_|T]):-
     none_not_defeasible(T).

not_provable(defeasible, X):-
    not_provable(definite, X),!,
    not_provable2(defeasible, X).
not_provable2(defeasible, X):-
    \+ (rule_sd(_, Antecedants, X),
        none_not_defeasible(Antecedants)).
not_provable2(defeasible, X):-
    complement_dl(X, Xc),
    provable(definite, Xc, _).
not_provable2(defeasible, X):-
    complement(X, Xc),
    rule(R, Antecedants, Xc),
    provable_list(defeasible, Antecedants, _),
    \+(rule_sd(R1, A, X);
    none_not_defeasible(A),
    precedence(R1, R)).

ought(dummy, dummy, dummy).
strict(dummy, [dummy], dummy).
