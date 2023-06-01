function [best, fmin, N_iter] = de(para)

for fun=24:1:26
for rep=1:1:10

if nargin<1
    para = [10,0.7,0.9];
end

n = para(1);
F = para(2);
Cr = para(3);

Function_name=['F',num2str(fun)]
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

% Iteration Parameters
tol=10^(-5);
N_iter = 0;

% Simple bounds
% Lb = [-1 -1 -1];
% Ub = [2 2 2];
Lb = ones(1,dim) * lb;
Ub = ones(1,dim) * ub;

% Dimension of the search variables
d = length(Lb);

% Initialize the population/solutions
for i=1:n
    Sol(i,:) = Lb+(Ub-Lb).*rand(size(Lb));    
    % Fitness(i) = Fun(Sol(i,:));
    Fitness(i) = fobj(Sol(i,:));
end

% Find the current best
[fmin, I] = min(Fitness);
best = Sol(I,:);

cgcurve = [];
%start the iterations by differential evolution
while (N_iter<1000)
    % Obtain donor vectors by permutation
    k1=randperm(n); k2=randperm(n);
    k1sol = Sol(k1,:); k2sol=Sol(k2,:);
    % Random crossover index/matrix
    K = rand(n,d)<Cr;
    %DE/RAND/1 scheme
    V = Sol+F*(k1sol-k2sol);
    V = Sol.*(1-K)+V.*K;

    % Evaluate new solutions
    for i=1:n
        % Fnew = Fun(V(i,:))
        Fnew = fobj(V(i,:));
        % If the solution improves
        if Fnew<=Fitness(i)
            Sol(i,:) = V(i,:);
            Fitness(i) = Fnew;
        end
        %Update the current best
        if Fnew<=fmin
            best=V(i,:);
            fmin=Fnew;
        end
        cgcurve(N_iter + i)=fmin
    end
    N_iter = N_iter + n;

plot(cgcurve)
writematrix(cgcurve,['Result_DE_',Function_name,'.xlsx'],'Sheet',1,'Range',['A',num2str(rep)])

%Output/Diplay
disp(['Number of evals:',num2str(N_iter)]);
disp(['Best=',num2str(best),', fmin=',num2str(fmin)]);
end
end

end
% Objective function -- Rosenbrock's 3D function
function z=Fun(u)
z = (1-u(1))^2+100*(u(2)-u(1)^2)^2+100*(u(3)-u(2)^2)^2;