%close all;
clear all;
clc
%% load data
load nydata
time = 1:200;
data = NewCases(time);
ma05 = movmean(data, 5);
ma20 = movmean(data,20);

%% fit to raw data
fr = dSfit(@dS, time, data);
q  = fr;
% visualize
% qss-sir model 
% states: (S,I,beta)
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,time,q(5:7));

newinfected = -1e6*diff(X(:,1));
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
saveas(gcf,'results/nyrawfit.jpg')
saveas(gcf,'results/nyrawfit','epsc')
saveas(gcf,'results/nyrawfit.fig')


%% fit to moving mean 5 points
f05 = dSfit(@dS, time, ma05);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,time,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(time, ma05, 'r*'); 
plot(time, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days)")
ylabel("Number of newly infected indinviduals")
title("NY Fit to Moving Mean (5 points)")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/nymafit05.jpg')
saveas(gcf,'results/nymafit05','epsc')
saveas(gcf,'results/nymafit05.fig')

%% fit to moving mean 20 points
f20 = dSfit(@dS, time, ma20);
q   = f20;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,time,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(time, ma20, 'r*'); 
plot(time, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days)")
ylabel("Number of newly infected indinviduals")
title("NY Fit to  Moving Mean (20 points)")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/nymafit20.jpg')
saveas(gcf,'results/nymafit20','epsc')
saveas(gcf,'results/nymafit20.fig')


figure
hold on
grid on
xlabel("Time (days)")
ylabel("Moving Mean of Newly Infected Data")
title("NY COVID new infected data")
plot(time, data,'LineWidth', 3)
plot(time, ma05,'LineWidth', 3)
plot(time, ma20,'LineWidth', 3)
legend(["Raw Data", "Moving Mean (5 points)" "Moving Mean (20 points)"])
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/nydata.jpg')
saveas(gcf,'results/nydata','epsc')
saveas(gcf,'results/nydata.fig')