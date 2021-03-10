%close all;
clear all;
clc
%% load data
load nydata
time = 1:200;
data = NewCases(time);
figure 
plot(time, data, 'r*'); hold on
%% fit to newly updated cases
q = dSfit(@dS, time, data);
% visualize
% qss-sir model 
% states: (S,I,beta)
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,time,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);
plot(time, newinfected, 'b-', 'LineWidth', 3)

legend(["Data", "Fit"])
grid on
xlabel("Time (days)")
ylabel("Number of newly infected indinviduals")
title("NY COVID new infected data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/newI.jpg')
saveas(gcf,'results/newI','epsc')
saveas(gcf,'results/newI.fig')