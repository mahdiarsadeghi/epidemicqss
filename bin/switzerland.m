%% germany
pop = 8.5;
load swiss
sz = diff(sz);
s = sz(1:50)>10;
pointer = find(s,1,'first');
st = 1:100;
sz = sz(pointer:pointer+99)';
sz07 = movmean(sz, 7);

% fit qss-sir model states: (S,I,beta) to raw data 
q = dSfit(@dS, st, sz, pop);

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
title("Switzerland")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/srawfit.jpg')
saveas(gcf,'results/srawfit','epsc')
saveas(gcf,'results/srawfit.fig')

%% fit to moving mean 7 points
f05 = dSfit(@dS, st, sz07, pop);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,st,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(st, sz07, 'r*'); 
plot(st, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("Switzerland")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/smafit07.jpg')
saveas(gcf,'results/smafit07','epsc')
saveas(gcf,'results/smafit07.fig')