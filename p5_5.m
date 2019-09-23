% Problem 5.5

% Set up Elastic  Moduli in a coordinate system
% aligned with the cubic axes of the material
% in GPa. (ie in the crystal axes)
c11 = 240.2;
c12 = 125.6;
c44 = 28.2;



C = [c11 c12 c12 0   0   0;
     c12 c11 c12 0   0   0;
     c12 c12 c11 0   0   0;
     0    0   0  c44 0   0;
     0    0   0   0  c44 0;
     0    0   0   0   0  c44];

% Invert moduli to get compliances

S = inv(C);

% Create a grid of specimen orientations according to their
% polar and azimuthal angles wrt to the crystal axes

phis   = linspace(0,2*pi,100);
thetas = linspace(0,  pi,  50);


% Loop over the grid computing the Young's Modulus 
% for each direction d

idxp = 0;
for phi = phis

    % Set up looping counters
    idxp = idxp + 1;
    idxt = 0;

    for theta = thetas

        % Set up looping counters
        idxt = idxt + 1;

        % Set up some direction vector d aligned with the 
        % specimen

        d = [sin(theta)*cos(phi); sin(theta)*sin(phi); ...
             cos(theta)];
 
        % Convert the uniaxial stress state from the 
        % coordinates aligned with the specimen into
        % the crystal coordinate system; store in
        % Voigt form.  Assume magnitude 1 stress.

        sigv= [d(1)*d(1); d(2)*d(2); d(3)*d(3); 
               d(2)*d(3); d(3)*d(1); d(1)*d(2)];
  
        % Compute strains in Voigt form in the original 
        % coordinate system

        epsv = S*sigv;
        
        % Set strains in tensor form

        eps = [epsv(1) epsv(6)/2 epsv(5)/2;
               epsv(6)/2 epsv(2) epsv(4)/2;
               epsv(5)/2 epsv(4)/2 epsv(3)];

        % Extract needed strain component

        epsd = d'*eps*d;

        % Compute Young's modulus and store for plotting

        Ed(idxp,idxt) = 1/epsd;
        rho = Ed(idxp,idxt);
        x1(idxp,idxt) = rho*sin(theta)*cos(phi);
        y1(idxp,idxt) = rho*sin(theta)*sin(phi);
        z1(idxp,idxt) = rho*cos(theta);
    end
end

% Plot Young's modulus  
surf(x1,y1,z1,Ed)
xlabel('${\bf e}_1$', 'Interpreter', 'latex','FontSize',16);
ylabel('${\bf e}_2$', 'Interpreter', 'latex','FontSize',16); 
zlabel('${\bf e}_3$', 'Interpreter', 'latex','FontSize',16)
colorbar 
title('Young''s Modulus (GPa)','FontSize',16)


