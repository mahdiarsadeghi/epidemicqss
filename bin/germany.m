%close all;
clear all;
clc

%% germany
load germany
gd = diff(gm);
s = gd(1:50)>10;
pointer = find(s,1,'first');
gt = 1:150;
gd = gd(pointer:pointer+149)';
gd05 = movmean(gd, 5);

% fit qss-sir model states: (S,I,beta) to raw data 
q = dSfit(@dS, gt, gd);

F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,gt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(gt, gd, 'r*'); 
plot(gt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Germany Fit to Raw Data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/grawfit.jpg')
saveas(gcf,'results/grawfit','epsc')
saveas(gcf,'results/grawfit.fig')

%% fit to moving mean 5 points
f05 = dSfit(@dS, gt, gd05);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,gt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(gt, gd05, 'r*'); 
plot(gt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Germany Fit to Moving Mean (5 points)")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/gmafit05.jpg')
saveas(gcf,'results/gmafit05','epsc')
saveas(gcf,'results/gmafit05.fig')