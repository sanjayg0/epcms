% Problem 11.16

clear all
% Discretize time axis
ts = linspace(0,100,1000);

% Set material properties
tau   = 1.5;     % sec
Ere   = 10;      % MPa
Erg   = 100;     % MPa
E1    = Erg-Ere; % MPa
beta  = .010;    % K/sec
gamma = 5.0;     % K
To    = 200;     % K
C1    = 10;      % [-]
C2    = 100;     % K

% Extract time step
dt = ts(2)-ts(1);

% Initialize state
hn     = 0;
aTold  = 1;
T(1)   = To;
e(1)   = 0;
sig(1) = 0;
xi(1)  = 0;
k      = 2;

% Loop and compute using Taylor, Pister, Goudreau (1970)
for t = ts(2:end)

  e(k)   = 0.1*sin(t/tau);
  de     = e(k) - e(k-1);
  T(k)   = To + beta*t + gamma*cos(t/(2*tau));

  aT     = 10^(-C1*(T(k)-To)/(C2+T(k)-To));
  xi(k)  = xi(k-1) + dt*(1/aT + 1/aTold)/2;
  dxi    = xi(k) - xi(k-1);

  hnp1   = hn*exp(-dxi/tau) + E1*de*exp(-dxi/(2*tau));

  sig(k) = Ere*e(k) + hnp1;

  aTold  = aT;
  hn     = hnp1;

  k      = k + 1;
end

subplot(3,2,1); plot(ts,e);
xlabel('Time (s)');
ylabel('Strain [-]');
subplot(3,2,2); plot(ts, T);
xlabel('Time (s)');
ylabel('Temperature (K)');
subplot(3,2,3); plot(ts,sig);
xlabel('Time (s)');
ylabel('Stress (MPa)');
subplot(3,2,4); plot(ts,xi);
xlabel('Time (s)');
ylabel('Fictitious Time (s)');
subplot(3,2,5); plot(e,sig);
xlabel('Strain [-]');
ylabel('Stress (MPa)'); grid on;

