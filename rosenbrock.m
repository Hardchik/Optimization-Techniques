function z=rosenbrock(u)
%Rosenbrock's function with f+=0 at (1,1)
z=(u(1)-1)^2+100*(u(2)-u(1)^2)^2;