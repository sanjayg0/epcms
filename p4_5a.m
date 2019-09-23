% Problem 4.5(a)

% define cartesian base vectors
e1=[1; 0; 0];
e2=[0; 1; 0];
e3=[0; 0; 1];

% define the normal vector and normalize it
n = (e1 + e2 + e3);
n = n/norm(n);

% define the components of sigma
sigma = [200 100 0; 100 400 200; 0   200 300];

% call the traction function to evaluate the traction
t = traction(sigma,n)

function [t] = traction(sigma,n)
 t = sigma * n;
end


