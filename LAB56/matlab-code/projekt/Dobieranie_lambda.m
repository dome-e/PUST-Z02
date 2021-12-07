options = gaoptimset('StallGenLimit', 10, 'PopulationSize', 30);
[X] = ga(@lambda_opt,2,[],[],[],[],[],[],[],[],options)
