function [best_solution, best_fit] = firefly_algorithm(func, lb, ub, dim, nFireflies, maxGen)
% func - function to be optimized
% lb - lower bound of the solution space
% ub - upper bound of the solution space
% dim - dimension of the solution space
% nFireflies - number of fireflies in the population
% maxGen - maximum number of generations

% Define the optimization function
func = @(x) (x(1) - 5)^2 + (x(2) - 3)^2;

% Set the lower and upper bounds of the solution space
lb = -5;
ub = 5;

% Set the number of fireflies and dimensions
nFireflies = 100;
dim = 2;

% Set the maximum number of generations
maxGen = 50;

% Initialize the fireflies
fireflies = lb + (ub - lb)*rand(nFireflies, dim);

% Evaluate the fitness of the fireflies
fit = zeros(nFireflies,1);
for i = 1 : nFireflies
    fit(i) = func(fireflies(i,:));
end

% Find the best firefly
[best_fit, bestIdx] = min(fit);
best_solution = fireflies(bestIdx, :);

% Set the algorithm parameters
beta0 = 1;
gamma = 1;
alpha = 0.2;

% Iterate through generations
for g = 1 : maxGen
    for i = 1 : nFireflies
        for j = i+1 : nFireflies
            % Calculate the distance between fireflies i and j
            dist = norm(fireflies(i,:) - fireflies(j,:));
            
            % If firefly j is brighter than firefly i, move firefly i towards j
            if fit(j) < fit(i)
                beta = beta0 * exp(-gamma * dist.^2);
                fireflies(i,:) = fireflies(i,:) + beta * (fireflies(j,:) - fireflies(i,:)) + alpha * randn(1, dim);
                
                % Update the fitness of firefly i
                fit(i) = func(fireflies(i,:));
                
                % Update the best firefly
                if fit(i) < best_fit
                    best_fit = fit(i);
                    best_solution = fireflies(i,:);
                end
            end
        end
    end
end
fprintf('Best solution: [%f, %f]\n', best_solution(1), best_solution(2));
fprintf('Best fitness: %f\n', best_fit);
end
