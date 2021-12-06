options = optimoptions('ga', 'StallGenLimit',80, 'PopulationSize', 60);
[X] = ga(@aproksymacja_fun,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)

options = optimoptions('ga', 'StallGenLimit',80, 'PopulationSize', 60);
[X] = ga(@aproksymacja_fun_Z,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)