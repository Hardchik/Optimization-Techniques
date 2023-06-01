% func - function to be optimized
% lb - lower bound of the solution space
% ub - upper bound of the solution space
% dim - dimension of the solution space
% nFireflies - number of fireflies in the population
% maxGen - maximum number of generations

% Define the optimization function
func = @(x) (x(1) - 5)^2 + (x(2) - 3)^2;

% Set the lower and upper bounds of the solution space
lb = -5
ub = 5

% Set the number of fireflies and dimensions
nFireflies = 100
dim = 2

% Set the maximum number of generations
maxGen = 50

% Initialize the fireflies
fireflies = lb + (ub - lb)*rand(nFireflies, dim)

% Evaluate the fitness of the fireflies
fit = zeros(nFireflies,1);
for i = 1 : nFireflies
    fit(i) = func(fireflies(i,:));
end

% Find the best firefly
[best_fit, bestIdx] = min(fit)
best_solution = fireflies(bestIdx, :)

% Set the algorithm parameters
beta0 = 1
gamma = 1
alpha = 0.2