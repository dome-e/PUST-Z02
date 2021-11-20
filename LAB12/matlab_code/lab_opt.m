opt = optimoptions('ga', 'MaxStallGenerations', 80, 'PopulationSize', 20);
[T] = ga(@zad3_opt,3,[],[],[],[],[],[],[],[],opt);
T1 = T(1)
T2 = T(2)
K = T(3)