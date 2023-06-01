% Lower and upper bounds
Lb = [-2 -2]
Ub = [2 2]
nd = length(Lb);

%Initializing parameters and settings
T_init = 1.0
T_min = 1e-10
F_min = -1e+100
max_rej = 250
max_run = 150
max_accept = 15
k = 1
alpha = 0.95
Enorm = 1e-2
guess = Lb+(Ub-Lb).*rand(size(Lb))
%initializing the counter i,j etc
i = 0; j = 0; accept = 0; totaleval = 0;
%Initializing various values
T = T_init;
E_init = f_obj(guess)
E_old = E_init; E_new = E_old;
best = guess;


function z=f_obj(u)
%Rosenbrock's function with f+=0 at (1,1)
z=(u(1)-1)^2+100*(u(2)-u(1)^2)^2;
end