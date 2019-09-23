% Problem 5.24

%
% MATLAB program for the warping of the cross-section
% of a 1 mm^2 bar. The method used involves using the
% first few terms in an expansion of the linear theory
% of elasticity solution
%
% Inputs:
%  T = torque in N.mm
%  G = shear modulus in N/mm^2
%
% Outputs:
%  a = twist rate in rad/mm
%  max | tau |
%  Plot of warped cross-section
%

T = 10;
G = 100e3;

J = (1/12) - (16/pi^5)*(tanh(pi/2) + ...
       tanh(3*pi/2)/3^5 + tanh(5*pi/2)/5^5);
a = T/(G*J)

tau = 0;
for n = 1:2:51
    tau = tau - G*a*8*sin(n*pi/2)*tanh(n*pi/2)/(n^2*pi^2);
end
tau=abs(tau)

x = -0.5:0.05:0.5;
y = -0.5:0.05:0.5;
for i = 1:length(x)
  for j = 1:length(y)
    b = 0;
    for n = 4:-1:0
     l = (2*n+1)*pi;
     b = b + ((-1)^n/(2*n+1)^3)*(sinh(l*x(i))/ ...
          cosh(l/2.0))*sin(l*y(j));
   end
    u(i,j) = -a*x(j)*y(i) + (8.0*a/pi^3)*b;
  end
end
surfc(x,y,u);
set(gca,'FontSize',16);
zlabel('$\varphi$', 'Interpreter', 'latex','FontSize',24);
ylabel('$x_2$', 'Interpreter', 'latex','FontSize',24);
xlabel('$x_1$', 'Interpreter', 'latex','FontSize',24);

