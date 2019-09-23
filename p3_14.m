% Problem 3.14

% Part a 
[a,b] = eig(strainhw3([1;2;3]))

% Part b
eps= strainhw3([2;2;0]);
n = [1;1;1]/sqrt(3);
n'*eps*n

% Part c
eps= strainhw3([1;1;1]);

v1=[1;1;1]/sqrt(3);
v2=[2;1;3]/norm([2;1;3]);

((v1'*v2)*(v1'*eps*v1 + v2'*eps*v2) - 2*v1'*eps*v2)/ ...
sin(acos(v1'*v2))

% Part d
eps= strainhw3([0;0;0]);

trace(eps)

function [eps]=strainhw3(x)
%
% Input: x(3) coordinates of point
% Output: eps(3,3) strain tensor components at x(3)

eps= [3*x(1) 5*x(2)+6*x(3) x(3)^3;
    5*x(2)+6*x(3) 0 x(1)^2+x(2)^2;
    x(3)^3 x(1)^2+x(2)^2 exp(x(1))]*10^-6;
end


