% fitness_func: the fitness function to be optimized
% n_vars: the number of variables in the problem
% lb: lower bounds for each variable
% ub: upper bounds for each variable
% max_iters: maximum number of iterations
% swarm_size: number of particles in the swarm
% inertia_weight: inertia weight parameter
% cognitive_weight: cognitive weight parameter
% social_weight: social weight parameter

fitness_func = @(x) sum(x.^2);
n_vars = 2
lb = -10
ub = 10
max_iters = 100
swarm_size = 50
inertia_weight = 0.729
cognitive_weight = 1.49445
social_weight = 1.49445

% Initialize the swarm particles
swarm = lb +(ub - lb)*rand(swarm_size, n_vars)
velocities = zeros(swarm_size, n_vars);
fitnesses = zeros(swarm_size, 1);
pbests = swarm;
pbest_fitnesses = inf(swarm_size, 1);
gbest = zeros(1, n_vars);
gbest_fitness = inf;