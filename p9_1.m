% Problem 9.1

% Matlab Script for analyzing Tension-Compression experiments.
%
% Material: 316 Stainless Steel, annealed
% Tension Test Strain Rate: 0.001/s
% Gauge Length (postn): Lo = 50.800(mm)
% Initial Diamter: Do = 6.350(mm)
% Disp.(mm)	Force(kN)

clear all; close all; clc

% Specimen geometry
L_0 = 50.8e-3;      % m
d_0 = 6.35e-3;      % m
A_0 = pi*(d_0^2)/4; % initial cross-sectional area in m^2

% Filename
filename = '316_SS_tension.txt';

% Import Data
dataset = dlmread(filename);
disp    = dataset(1:end-3,1)*(1e-3); % m
force   = dataset(1:end-3,2)*(1e3);  % N

% Zero the displacement and force data
disp  = disp - disp(1);   % m
force = force - force(1); % N

%  Compute Engineering Strain and Stress
estrain = disp/L_0; % Engineering Strain
estress = force./A_0; % Engineering Stress in Pa

% Plot Engineering Stress vs Strain
fig1 = figure(1);
plot(estrain*100,estress*1e-6,'k','LineWidth',2);
xlabel('Engineering Strain (\%)','FontSize',16,...
  'Interpreter','Latex');
ylabel('Engineering Stress (MPa)','FontSize',16,...
  'Interpreter','Latex');
set(gca,'Position',[0.15 0.15 0.8 0.75])

% Find E and Y0
range = 10; % How many points to use for the slope of E. 
            % Found by inspection.

% Perform Linear Regression
ff = fit(estrain(1:range),estress(1:range),'poly1');
E  = (ff.p1);

% Plot Eng. Stress Strain with E slope and 0.2% offset
fig2 = figure(2);
hold on
plot(estrain*100,estress*(1e-6),'k','LineWidth',2);
plot(estrain(1:15)*100,(E*estrain(1:15))*1e-6,...
    'k--','LineWidth',2);
plot((estrain(1:15)*100 + 0.2),(E*estrain(1:15))*1e-6,...
    'k-.','LineWidth',2);
hold off
leg = legend('Eng. Stress Strain Curve','Elastic Slope',...
    '0.2\% Offset Line');
set(leg,'FontSize',16,'Location','SouthEast',...
  'Interpreter','Latex')
xlabel('Engineering Strain (\%)','FontSize',16,...
  'Interpreter','Latex');
ylabel('Engineering Stress (MPa)','FontSize',16,...
  'Interpreter','Latex');
set(gca,'Position',[0.15 0.15 0.8 0.75])
xlim([0 5])

% From inspection the yield strength is
Y0 = 267e6; % Pa

% Find Maximum Eng. Stress and index
[max_estress,max_stress_ind] = max(estress);

% Compute True Stress Strain Curve
lambda = estrain + 1;
tstrain = log(lambda(1:max_stress_ind));
tstress = estress(1:max_stress_ind).*lambda(1:max_stress_ind);

% Plot Eng. and True Stress Strain
fig3 = figure(3);
hold on
plot(estrain(1:max_stress_ind)*100,...
  estress(1:max_stress_ind)*1e-6,'-k','LineWidth',2)
plot(tstrain*100,tstress*1e-6,'--k','LineWidth',2)
hold off
xlabel('Strain (\%)','FontSize',16,'Interpreter','Latex');
ylabel('Stress (MPa)','FontSize',16,'Interpreter','Latex');
leg = legend('Engineering','True');
set(leg,'FontSize',16,'Location','SouthEast',...
  'Interpreter','Latex')
set(gca,'Position',[0.15 0.15 0.8 0.75])

% Calculate True Plastic Strain
[trash,Y0_ind] = min(abs(tstress - Y0));
p_tstrain = tstrain(Y0_ind:end) - tstress(Y0_ind:end)./E;
p_tstrain = p_tstrain - p_tstrain(1);
p_tstress = tstress(Y0_ind:end);

% Plot True Stress vs. True Plastic Strain
fig4 = figure(4);
plot(p_tstrain*100,p_tstress*1e-6,'k','LineWidth',2)
xlabel('True Plastic Strain $\epsilon^p$ (\%)',...
  'FontSize',16,'Interpreter','Latex');
ylabel('True Stress $\sigma$ (MPa)','FontSize',16,...
    'Interpreter','Latex');
ylim([0 1000])
set(gca,'Position',[0.15 0.15 0.8 0.75])

% Find Hardening Parameters
% First we will perform a regression with the Voce style 
% hardening (r=1) and use the results for Ys and H0 as 
% guesses in the next regression

% Voce Fitting
s = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[300e6,1e6],...
               'Upper',[2000e6,100e9],...
               'Startpoint',[1200e6,4e9]);

f = fittype('a - (a - n)*exp(-(b/a)*x)',...
    'problem','n','options',s);

% c1.a = Ys, c1.b = H0
[c1,gof1] = fit(p_tstrain,p_tstress,f,'problem',Y0);

% Brown Hardening
s = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[300e6,1.1,1e6],...
               'Upper',[2000e6,3,100e9],...
               'Startpoint',[c1.a,1.5,c1.b]);

f = fittype('a - ( (a-n)^(1-b) + (b-1)*(c/(a^b))*(x) )^(1/(1-b))',...
    'problem','n','options',s);

% Exponential (for Part b)

%  s = fitoptions('Method','NonlinearLeastSquares',...
%                 'Lower',[1e6,0],...
%                 'Upper',[100e9,5],...
%                 'Startpoint',[4e9,1.5]);
%  
%  f = fittype('Yyield + a*(x^b)',...
%     'problem','Yyield','options',s);
%  
%  [c1,gof1] = fit(p_tstrain,p_tstress,f,'problem',Y0);
%  
%  K = c1.a
%  n = c1.b

[c2,gof2] = fit(p_tstrain,p_tstress,f,'problem',Y0);

Ys = c2.a
r = c2.b
H0 = c2.c

% Compute the Fit
Y_fit = Ys - ( (Ys-Y0)^(1-r) ...
  + (r-1)*(H0/(Ys^r))*p_tstrain ).^(1/(1-r));

fig5 = figure(5);
hold on
plot(p_tstrain*100,p_tstress*1e-6,'k','LineWidth',2)
plot(p_tstrain(1:100:end)*100,Y_fit(1:100:end)*1e-6,...
  '--ok','LineWidth',2)
hold off
xlabel('True Plastic Strain $\epsilon^p$ (\%)',...
  'FontSize',16,'Interpreter','Latex');
ylabel('True Stress $\sigma$ (MPa)','FontSize',16,...
    'Interpreter','Latex');
ylim([0 1000])
set(gca,'Position',[0.15 0.15 0.8 0.75])
leg = legend('Experiment','Fit');
set(leg,'FontSize',16,'Location','SouthEast',...
  'Interpreter','Latex')

