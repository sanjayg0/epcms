% Problem 4_5(c)

sigma = [200 100 0; 100 400 200; 0   200 300];

% call the principal function to evaluate the principal
% stresses and principal directions
[s1, s2, s3, n1, n2, n3] = principal(sigma);

% call the traction function to evaluate the traction
% for each of the principal directions
t1 = traction(sigma,n1)
t2 = traction(sigma,n2)
t3 = traction(sigma,n3)

% multiply the principal direction by the principal stress
% these should be equal to the tractions calculated above
t1 = s1*n1
t2 = s2*n2

t3 = s3*n3

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

function [t] = traction(sigma,n)
t = sigma * n;
end
