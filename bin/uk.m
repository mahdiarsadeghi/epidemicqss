%close all;
clear all;
clc

%% gerukny
load unitedkingdom
uk = diff(uk);
s = uk>10;
pointer = find(s,1,'first');
ut = 1:140;
uk = uk(pointer:pointer+139)';
uk05 = movmean(uk, 5);

% fit qss-sir model utates: (S,I,beta) to raw data 
q = dSfit(@dS, ut, uk);

F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,ut,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(ut, uk, 'r*'); 
plot(ut, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("United Kingdom Fit to Raw Data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/ukrawfit.jpg')
saveas(gcf,'results/ukrawfit','epsc')
saveas(gcf,'results/ukrawfit.fig')

%% fit to moving mean 5 points
f05 = dSfit(@dS, ut, uk05);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,ut,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(ut, uk05, 'r*'); 
plot(ut, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("United Kingdom Fit to Moving Mean (5 points)")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/ukfit05.jpg')
saveas(gcf,'results/ukfit05','epsc')
saveas(gcf,'results/ukfit05.fig')