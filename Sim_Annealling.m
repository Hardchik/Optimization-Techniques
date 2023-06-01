function sa_demo
disp('Simulating ... it will take a minute or so!')
% Lower and upper bounds
Lb = [-2 -2];
Ub = [2 2];
nd = length(Lb);

%Initializing parameters and settings
T_init = 1.0;
T_min = 1e-10;
F_min = -1e+100;
max_rej = 250;
max_run = 150;
max_accept = 15;
k = 1;
alpha = 0.95;
Enorm = 1e-2;
guess = Lb+(Ub-Lb).*rand(size(Lb));
%initializing the counter i,j etc
i = 0; j = 0; accept = 0; totaleval = 0;
%Initializing various values
T = T_init;
E_init = f_obj(guess);
E_old = E_init; E_new = E_old;
best = guess;

%Started Simulated Annealling
while((T>T_min) && (j <= max_rej) && (E_new > F_min))
    i = i+1;
    if(i >= max_run) || (accept >= max_accept)
        T = alpha*T;
        totaleval = totaleval + i;
        i = 1; accept = 1;
    end
    
    %Function evals at new locations
    s = 0.01*(Ub-Lb);
    ns = best+s.*randn(1,nd);
    E_new = f_obj(ns);
    %Decide to accept new solution
    DeltaE = E_new - E_old;

    %Accept if improved
    if(-DeltaE>Enorm)
        best = ns; E_old = E_new;
        accept = accept+1; j = 0;
    end
    
    %Accept with a small probability if not improved
    if(DeltaE <= Enorm && exp(-DeltaE/(k*T))>rand)
        best = ns; E_old = E_new;
        accept = accept+1;
    else
    end
    
    %Update estimated optimal solution
    f_opt = E_old;
end
%Displaying Results
disp(strcat('Evaluations : ', num2str(totaleval)))
disp(strcat('Best solution : [', num2str(best), ']'))
disp(strcat('Best objective : ', num2str(f_opt)))

function z=f_obj(u)
%Rosenbrock's function with f+=0 at (1,1)
z=(u(1)-1)^2+100*(u(2)-u(1)^2)^2;