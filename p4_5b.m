% Problem 4.5(b)

% define the components of sigma
sigma = [200 100 0; 100 400 200; 0   200 300];

% call the principal function to evaluate the principal 
% stresses and principal directions
[s1, s2, s3, n1, n2, n3] = principal(sigma)

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
