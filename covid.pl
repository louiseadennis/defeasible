ought(o1, X, get_vaccinated(X)).
ought(o2, X, wear_facemask(X)).

defeasible(d1, [health_contraindication(X)], not(ought(X, get_vaccinated(X)))).
defeasible(d2, [facemask_exemption(X)], not(ought(X, wear_facemask(X)))).
defeasible(d3, [not(vaccinated(X))], ought(X, not(go_to_work(X)))).
defeasible(d4, [not(vaccinated(X))], ought(X, not(pub(X)))).

defeater(df1, [keyworker(X)], not(ought(X, not(go_to_work(X))))).

precedence(d1, o1).
precedence(d2, o2).
precedence(df1, d3).
    
    

