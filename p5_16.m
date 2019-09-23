% Problem 5.16

% LiMgSnPt
% Set up Moduli in a coordinate system aligned with the
% cubic axes of the material in GPa. (ie in the crystal axes)

alpha= 111.84; lambda=76.39; mu=67.05; rho = 8.35;
% alpha = 2*mu+lambda; ! Uncomment this line
% for the isotropic material test case

% Create a grid of specimen orientations according to their
% polar angle phi  and azimuthal angle theta wrt the 
% crystal axes

phis   = linspace(0,2*pi,100);
thetas = linspace(0,  pi,  50);

% Loop over the grid computing the wave speed
% for each direction

idxp = 0;
for phi = phis

    % Set up looping counters
    idxp = idxp + 1;
    
    idxt = 0;
    for theta = thetas

        % Set up looping counters
        idxt = idxt + 1;

        % Compute wave speed for direction n

        n = [sin(theta)*cos(phi); sin(theta)*sin(phi); ...
             cos(theta)];

        A = (alpha-2*mu-lambda)*[n(1)^2 0 0 ; 0 n(2)^2 0; ...
                                 0 0 n(3)^2]/rho + ...
            mu*[1 0 0; 0 1 0; 0 0 1]/rho +...
            (lambda+mu)*[n(1)^2 n(1)*n(2) n(1)*n(3); 
                   n(2)*n(1) n(2)^2 n(2)*n(3); 
                   n(3)*n(1) n(3)*n(2) n(3)^2]/rho;

        [vec,vals] = eig(A);
        c = sqrt(diag(vals));

        v(idxp,idxt) = min(c);
        r = v(idxp,idxt);
        x1(idxp,idxt) = r*sin(theta)*cos(phi);
        y1(idxp,idxt) = r*sin(theta)*sin(phi);
        z1(idxp,idxt) = r*cos(theta);
    end
end

% Plot Wave Speeds
surf(x1,y1,z1,v)
xlabel('${\bf e}_1$', 'Interpreter', 'latex','FontSize',16);
ylabel('${\bf e}_2$', 'Interpreter', 'latex','FontSize',16); 
zlabel('${\bf e}_3$', 'Interpreter', 'latex','FontSize',16)

colorbar 
title('Min wave speed (km/s)', 'FontSize',16)
axis equal

