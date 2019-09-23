% Problem 3.9

VV = [ 0.34 0.45*cosd(63.4);
       0.00 0.45*sind(63.4) ];

vv = [0.41*cosd(25.0) 0.50*cosd(79.9);
      0.41*sind(25.0) 0.50*sind(79.9) ];

F = vv*inv(VV)
C = F'*F

[evec,eval] = eig(C)

U = sqrt(eval(1,1))*evec(:,1)*evec(:,1)' + ...
    sqrt(eval(2,2))*evec(:,2)*evec(:,2)'

