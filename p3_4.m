% Problem 3.4

function [] = problem34( )

% Define the Deformation Gradient
F = [3 -1 0; 2 2 0;0 0 1];

% Define the Right Cauchy Green Tensor
C = F'*F;

%Calculate the eigenvalues and eignevectors of C
[vectors, values] = eig(C);

% select the eigenvalues from "values"
omega1 = values(1,1);
omega2 = values(2,2);
omega3 = values(3,3);

% Calculate the principal stretches
lambda1=sqrt(omega1);
lambda2=sqrt(omega2);
lambda3=sqrt(omega3);

% Select the columns of vectors as the eigenvectors
r1 = vectors(:,1);
r2 = vectors(:,2);
r3 = vectors(:,3);

% Construct U in the principal basis
U(1,1) = lambda1;
U(2,2) = lambda2;
U(3,3) = lambda3;

% Map the matrix back to the original coordinates
U = vectors*U*vectors';

% The rotation tensor R is
R = F*inv(U);

% Green Strain
E_g = (1/2)*(C - eye(3));

% To find the Hencky strain we need the logarithm of U so we
% use the same procedure as we did for taking the square
% root of C
[eigenvectors, eigenvalues] = eig(U);
E_h(1,1) = log(lambda1);
E_h(2,2) = log(lambda2);
E_h(3,3) = log(lambda3);
E_h = vectors*E_h*vectors';

%Display Results
disp('Right Cauchy-Green Tensor C'); C
disp('first principal stretch'); lambda1
disp('second principal stretch'); lambda2
disp('third principal stretch'); lambda3
disp('first principal stretch direction'); r1
disp('second principal stretch direction'); r2
disp('third principal stretch direction'); r3
disp('Stretch Tensor'); U
disp('Rotation Tensor'); R
disp('Green-Strain'); E_g
disp('Hencky Strain'); E_h 

