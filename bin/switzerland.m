%close all;
clear all;
clc

%% germany
load switzerland
sz = diff(sz);
s = sz(1:50)>10;
pointer = find(s,1,'first');
st = 1:120;
sz = sz(pointer:pointer+119)';
sz05 = movmean(sz, 5);

% fit qss-sir model states: (S,I,beta) to raw data 
q = dSfit(@dS, st, sz);

F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,st,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(st, sz, 'r*'); 
plot(st, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Switzerland Fit to Raw Data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/srawfit.jpg')
saveas(gcf,'results/srawfit','epsc')
saveas(gcf,'results/srawfit.fig')

%% fit to moving mean 5 points
f05 = dSfit(@dS, st, sz05);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,st,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(st, sz05, 'r*'); 
plot(st, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Switzerland Fit to Moving Mean (5 points)")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/smafit05.jpg')
saveas(gcf,'results/smafit05','epsc')
saveas(gcf,'results/smafit05.fig')