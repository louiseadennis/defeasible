defeasible(d1, [dec_hem_lev_low(X)], anemia(X)).
defeasible(d2, [anemia(X)], stomach_bleeding(X)).
defeasible(d3, [stomach_bleeding(X), not(do(treat, X))], death(X)).
defeasible(d4, [hemorrhoids(X)], anemia(X)).

defeasible(d5, [stomach_bleeding(X)], ought(doctor, do(examine, X))).
defeasible(d6, [death(X)], ought(doctor, do(treat, X))).

defeasible(d7 , [not(right_mind(X))], not(refuse_consent(X, Action))).
defeasible(d8 , [anemia(X)], not(right_mind(X))).
defeasible(d9 , [living_will(X)], right_mind(X)).
defeasible(d10 , [not(right_mind(X))], ought(doctor, do(consult_next_of_kin(X), X))).

defeasible(d11, [ought(X, do(examine, Y))], ought(X, do(obtain_consent, Y))).
defeasible(d12, [ought(X, do(treat, Y))], ought(X, do(obtain_consent, Y))).

defeater(df1, [refuse_consent(X, Action)], ought(doctor, not(do(Action, X)))).
defeater(df2, [hemorrhoids(X)], not(stomach_bleeding(X))).

precedence(df2, d2).
precedence(df1, d5).
precedence(df1, d6).
precedence(df1, d11).
precedence(df1, d12).
precedence(df1, d10).
precedence(d9, d8).
precedence(d7, df1).
