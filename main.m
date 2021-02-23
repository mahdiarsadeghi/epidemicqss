%close all;
clear all;
clc
%% load data
load nydata
time = 1:200;
data = NewCases(time);
figure 
plot(time, data, 'r*')
%% fit to newly updated cases
q = dSfit(@dS, time, data);
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
plot(time, newinfected, 'b-', 'LineWidth', 3)
%% fit to average infections
data2 = NewCases9(time);
p = Ifit(@dS, time, data2);

% visualize
gamma = p(1);
K     = p(2);
alpha = p(3);
c     = p(4);
k0    = p(5);
x0    = p(6:8);

% qss-sir model 
% states: (S,I,beta)
F=@(t,x) [-c*x(1)*x(2)*x(3); ...
          c*x(1)*x(2)*x(3) - x(2)*gamma;...
          K/(1+x(2)*k0)-alpha*x(3)];
[tspan,Y]=ode45(F,time,x0);

newinfected2 = -diff(Y(:,1));
newinfected2(end+1) = newinfected2(end);
% visualize 
plot(time, newinfected2, 'c-', 'LineWidth', 3)
legend(["Data", "dS/dt fit", "I(t) fit"])
grid on
xlabel("Time (days)")
ylabel("Number of newly infected indinviduals")
title("NY COVID new infected data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/newI.jpg')
saveas(gcf,'results/newI','epsc')
saveas(gcf,'results/newI.fig')


figure
plot(time, data2, 'r*')
hold on
plot(time, X(:,2), 'b-', 'LineWidth', 3)
plot(time, Y(:,2), 'c-', 'LineWidth', 3)
legend(["Data", "dS/dt fit", "I(t) fit"])
grid on
xlabel("Time (days)")
ylabel("Number of active infected indinviduals")
title("NY COVID average infected data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/I.jpg')
saveas(gcf,'results/I','epsc')
saveas(gcf,'results/I.fig')


