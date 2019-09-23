% Problem 1.20

% Program to calculate the components of  a matrix  of a 
% second-order tensor under a change in basis
% Q = Rotation Matrix, S = Original Matrix to be Transformed,
% S_star= Transformed Matrix

% Input Matrices in MATLAB Format
Q=[sqrt(3)/2,1/2,0;-1/2,sqrt(3)/2,0;0,0,1];
u=[1;4;2];
S=[1,0,3;0,2,2;3,2,4];

% Apply Transformation Laws
u_star = Q*u;
S_star=Q*S*Q';

% Display Segement
disp('Original vector u=')
disp(u)
disp('Original Matrix S=')
disp(S)
disp('Rotation Matrix, Q=')
disp(Q)
disp('Transformed Matrix, u_star=Q*u')
disp(u_star)
disp('Transformed Matrix, S_star=Q*S*Q')
disp(S_star)
