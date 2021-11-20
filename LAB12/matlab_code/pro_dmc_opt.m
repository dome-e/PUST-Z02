lb = [1, 1, 0.01]; % ogr dolne
ub = [114, 114, inf]; % ogr gorne
opt = optimoptions('ga', 'MaxStallGenerations', 80, 'PopulationSize', 20); 
[P,fval,exitflag] = ga(@dmc_opt,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2],opt);
N = P(1)
Nu = P(2)
lambda = P(3)