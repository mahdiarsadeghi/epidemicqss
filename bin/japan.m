%close all;
clear all;
clc

%% gerjpny
load japan
jp = diff(gp);
s = jp>10;
pointer = find(s,1,'first');
jt = 1:130;
jp = jp(pointer:pointer+129)';
jp05 = movmean(jp, 5);

% fit qss-sir model jtates: (S,I,beta) to raw data 
q = dSfit(@dS, jt, jp);

F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,jt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(jt, jp, 'r*'); 
plot(jt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Japan Fit to Raw Data")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/japanrawfit.jpg')
saveas(gcf,'results/japanrawfit','epsc')
saveas(gcf,'results/japanrawfit.fig')

%% fit to moving mean 5 points
f05 = dSfit(@dS, jt, jp05);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,jt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(jt, jp05, 'r*'); 
plot(jt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Japan Fit to Moving Mean (5 points)")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/jmafit05.jpg')
saveas(gcf,'results/jmafit05','epsc')
saveas(gcf,'results/jmafit05.fig')