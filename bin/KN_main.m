%close all;
clear all;
clc
%% load data
load nydata
time = 1:200;
data = NewCases(time);

%% fit to raw data
q = KNfit(@KN, time, data);
% qss-sir model states: (S,I,beta)
F=@(t,x) [-q(2)*x(1)*x(2)*x(3); ...
          q(2)*x(1)*x(2)*x(3) - x(2)*q(1);...
          1/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,time,q(5:7));

newinfected = -diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(time, data, 'r*'); 
plot(time, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days)")
ylabel("Number of newly infected indinviduals")
title("NY Fit to Raw Data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/knfit.jpg')
saveas(gcf,'results/knfit','epsc')
saveas(gcf,'results/knfit.fig')