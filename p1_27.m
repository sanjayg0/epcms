% Problem 1.27

% Program to calculate the invariants, eigenvalues values
% and eigenvectors of a symmetric second-order tensor S

% Input Matrix
S=[2,0,0;0,3,4;0,4,-3];

% Calculate Invariants
invariants=[trace(S),(trace(S)^2-trace(S*S))/2,det(S)]

[V,L]=eig(S);

% Principal Values are the Diagonal Elements of the L Matix
principal_values=[L(1,1),L(2,2),L(3,3)]

% Principal Directions are the Columns of the V Matrix
principal_directions=V
