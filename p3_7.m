% Problem 3.7

function [] = problem37( )

% Define the Deformation Gradient
E = 1.E-3*[2 -2 0; -2 -4 1;0 1 6];

% Calculate the eigenvalues and eigenvectors of E
[vectors, values] = eig(E);

% Select the eigenvalues from "values"
epsilon1 = values(1,1);
epsilon2 = values(2,2);
epsilon3 = values(3,3);

% Select the columns of vectors as the eigenvectors
r1 = vectors(:,1);
r2 = vectors(:,2);
r3 = vectors(:,3);

% Compute trace
trace = epsilon1+epsilon2+epsilon3;

% Construct spherical part
Espherical =  (1/3)*trace*eye(3);

% Construct deviator
Eprime = E-(1/3)*trace*eye(3);

%Display Results
disp('first principal strain'); epsilon1
disp('second principal strain'); epsilon2
disp('third principal strain'); epsilon3
disp('first principal strain direction'); r1
disp('second principal strain direction'); r2
disp('third principal strain direction'); r3
disp('Spherical strain'); Espherical
disp('Strain deviator'); Eprime

