%close all;
clear all;
clc
%% load data
load NewCases
time = 1:200;
data = NewCases(time);
figure 
plot(time, data, 'r*')
%% automatic fit
q = lsfit(@qss, time, data);
% visualize
gamma = q(1);
K     = q(2);
alpha = q(3);
c     = q(4);
k0    = q(5);
x0    = q(6:8);
% 
% qss-sir model 
% states: (S,I,beta)
F=@(t,x) [-c*x(1)*x(2)*x(3); ...
          c*x(1)*x(2)*x(3) - x(2)*gamma;...
          K/(1+x(2)*k0)-alpha*x(3)];
[tspan,X]=ode45(F,time,x0);
newinfected = -diff(X(:,1));
newinfected(end+1) = newinfected(end);
% visualize 
hold on
plot(time, newinfected, 'b-')
legend(["Data", "Automatic Fit"])
% %% manual fit from M Ali
% gamma=1/9;
% K=.048*0.04;
% alpha=0.0679;
% T=250;
% c=1e-6;
% k0=((K*20e6*c)/(alpha*gamma)-1)/5000;
% x0 = [20e6,1,K/alpha];
% % qss-sir model 
% % states: (S,I,beta)
% F=@(t,x) [-c*x(1)*x(2)*x(3); ...
%           c*x(1)*x(2)*x(3) - x(2)*gamma;...
%           K/(1+x(2)*k0)-alpha*x(3)];
% [tspan,X]=ode45(F,[min(time), max(time)],x0);
% % visualize 
% hold on
% plot(tspan, X(:,2), 'm:')
% legend(["Data", "Automatic Fit", "Manual Fit"])