function [best_solution, best_fitness] = pso(fitness_func, n_vars, lb, ub, max_iters, swarm_size, inertia_weight, cognitive_weight, social_weight)
% fitness_func: the fitness function to be optimized
% n_vars: the number of variables in the problem
% lb: lower bounds for each variable
% ub: upper bounds for each variable
% max_iters: maximum number of iterations
% swarm_size: number of particles in the swarm
% inertia_weight: inertia weight parameter
% cognitive_weight: cognitive weight parameter
% social_weight: social weight parameter
for fun=24:1:26
for rep=1:1:10
Function_name=['F',num2str(fun)]
[lb,ub,dim,fitness_func]=Get_Functions_details(Function_name);
% fitness_func = @(x) sum(x.^2);
n_vars = dim;
% lb = -100;
% ub = 100;
max_iters = 1000;
swarm_size = 13;
inertia_weight = 0.729;
cognitive_weight = 1.49445;
social_weight = 1.49445;

% Initialize the swarm particles
swarm = lb +(ub - lb)*rand(swarm_size, n_vars);
velocities = zeros(swarm_size, n_vars);
fitnesses = zeros(swarm_size, 1);
pbests = swarm;
pbest_fitnesses = inf(swarm_size, 1);
gbest = zeros(1, n_vars);
gbest_fitness = inf;

%For each particle calculate the fitness value 
cgcurve = [];
for i = 1:max_iters
    % Evaluate fitness for each particle
    for j = 1:swarm_size
        fitnesses(j) = fitness_func(swarm(j,:));
	%if the fitness value is better than the pbest before, 
    %set the current value as new pbest
        if fitnesses(j) < pbest_fitnesses(j)
            pbests(j,:) = swarm(j,:);
            pbest_fitnesses(j) = fitnesses(j);
        end
        if fitnesses(j) < gbest_fitness
            gbest = swarm(j,:);
            gbest_fitness = fitnesses(j);
        end
    end

    cgcurve(i)=gbest_fitness;
    
    % Update velocities and positions for each particle
    for j = 1:swarm_size
        r1 = rand(1, n_vars);
        r2 = rand(1, n_vars);
        velocities(j,:) = inertia_weight * velocities(j,:) + cognitive_weight * r1 .* (pbests(j,:) - swarm(j,:)) + social_weight * r2 .* (gbest - swarm(j,:));
        swarm(j,:) = swarm(j,:) + velocities(j,:);
    end
end

% Return the best solution and best fitness found
fprintf('Best solution and best fitness is:')
best_fitness = gbest_fitness;
best_solution = gbest;
disp(best_fitness);
disp(best_solution);
plot(cgcurve);

writematrix(cgcurve,['Result_PSO_',Function_name,'.xlsx'],'Sheet',1,'Range',['A',num2str(rep)])

end
close all;
clc;
end
end
