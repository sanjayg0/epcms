% Problem 5.8

% Cubic Analysis

C = [166 64 64 0 0 0;
     64 166 64 0 0 0;
     64 64 166 0 0 0;
     0  0  0  80 0 0;
     0  0  0  0 80 0;
     0  0  0  0 0 80]*1e3;
 
% Components of the transformation matrix 
% Q_{ij}=e_i^c . e_j:

s = 1/sqrt(2);
Q = [0  1  0;
     -s  0  s;
      s  0  s];
  
sig = [0 10 50;
       10 3  9;
       50 9 -3];
   
% Convert stress matrix from the e_i basis to the e^c_i
% basis
sig = Q*sig*Q';

% Convert to the Voigt vector notation
sigv=[sig(1,1) sig(2,2) sig(3,3) sig(2,3) sig(3,1) sig(1,2)]';
 
% Calculate the strain in the Voigt vector notation
epsv = inv(C)*sigv;
 
% Convert the strain into the tensor notation in 
% the e^c_i frame
eps_c = [epsv(1)   epsv(6)/2 epsv(5)/2;
        epsv(6)/2 epsv(2)   epsv(4)/2;
        epsv(5)/2 epsv(4)/2 epsv(3)];
    
disp('Matrix of strain in crystal basis')
eps_c
    
% Convert the strain into the tensor notation in 
% the e_i basis

eps_g = Q'*eps_c*Q;
disp('Matrix of strain in global basis')
eps_g
