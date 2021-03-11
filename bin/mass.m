%close all;
clear all;
clc

%% germany
load mass
ma = diff(ma);
s = ma>10;
pointer = find(s,1,'first');
mt = 1:180;
ma = ma(pointer:pointer+179)';
ma05 = movmean(ma, 5);

% fit qss-sir model mtates: (S,I,beta) to raw data 
q = dSfit(@dS, mt, ma);

F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,mt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(mt, ma, 'r*'); 
plot(mt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Massachuesets")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/mrawfit.jpg')
saveas(gcf,'results/mrawfit','epsc')
saveas(gcf,'results/mrawfit.fig')

%% fit to moving mean 5 points
f05 = dSfit(@dS, mt, ma05);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,mt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(mt, ma05, 'r*'); 
plot(mt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Massachuesets")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/mmafit05.jpg')
saveas(gcf,'results/mmafit05','epsc')
saveas(gcf,'results/mmafit05.fig')