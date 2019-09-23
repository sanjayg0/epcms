% Problem 4_5(d)

% define the components of sigma
sigma = [200 100 0; 100 400 200; 0  200 300];

% evaluate the principal stresses and directions
[s1, s2, s3, n1, n2, n3] = principal(sigma);

% define Q based on the principal directions
Q = [n1 n2 n3]'

% define Qt as the transpose of Q
Qt = Q'

% multiply Q & Qt, this should be the identity matrix
Q*Qt

% Second part of 4.5(d)
% define the components of sigma
sigma = [200 100 0; 100 400 200; 0   200 300];

% evaluate the principal stresses and directions
[s1, s2, s3, n1, n2, n3] = principal(sigma);

% define Q based on the principal directions
% note that Q = [n1'; n2'; n3'] would also work
Q = [n1 n2 n3]';

% define Qt as the transpose of Q
Qt = Q';

% calculate the rotated sigma
sigma_prime = Q * sigma * Qt

% sigma_prime should be the same as
diag([s1 s2 s3])



function [s1, s2, s3, n1, n2, n3] = principal(sigma)

[vectors, values] = eig(sigma);

% select the eigenvalues from "values"
% these are also the principal stresses
s1 = values(1,1);
s2 = values(2,2);
s3 = values(3,3);

% select the columns of vectors as the eigenvectors
% these are also the principal directions
n1 = vectors(:,1);
n2 = vectors(:,2);
n3 = vectors(:,3);

end

