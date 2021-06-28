ought(o1, get_vaccinated(X)).
ought(o2, not(encourage_fraud)).
ought(o3, not(social_division)).
ought(o4, enable_international_travel).

strict(s1, [not(covid(X))], not(maybe_infectious(X))).
strict(s2, [face_mask(X)], face_covering(X)).
strict(s3, [vaccine_allergy(X)], ought(not(get_vaccinated(X)))).
strict(s4, [not(vaccinated(X))], ought(not(pub(X)))).
defeasible(s5, [not(vaccinated(X))], ought(not(work(X)))).
strict(s6, [key_worker(X)], not(work_home(X))).

defeasible(d1, [covid(X)], maybe_infectious(X)).
defeasible(d2, [face_covering(X)], not(maybe_infectious(X))).
defeasible(d3, [health_condition(X)], ought(not(get_vaccinated(X)))).

defeasible(d4, [vaccine_passport], social_division).
defeasible(d5, [social_division], encourage_fraud).
defeasible(d6, [vaccine_passport], enable_international_travel).

defeater(df1, [not(face_mask(X))], infectious(X)).
defeater(df2, [valid_justification(X)], travel_internationally(X)).
defeater(df3, [not(work_home(X))], ought(work(X))).

precedence(s3, o1).
precedence(d3, o1).    
precedence(df3, s5).    
    
    

