%% data
pop = 19.5;
load ny
ny = diff(ny);
s = ny>10;
pointer = find(s,1,'first');
nt = 1:200;
ny = ny(pointer:pointer+199)';
ny05 = movmean(ny, 7);

% fit qss-sir model ntates: (S,I,beta) to raw data 
q = dSfit(@dS, nt, ny, pop);

F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,nt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(nt, ny, 'r*'); 
plot(nt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("State of New York")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/nyrawfit.jpg')
saveas(gcf,'results/nyrawfit','epsc')
saveas(gcf,'results/nyrawfit.fig')

%% fit to moving mean 7 points
f05 = dSfit(@dS, nt, ny05, pop);
q   = f05;
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,nt,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(nt, ny05, 'r*'); 
plot(nt, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("State of New York")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/nyfit07.jpg')
saveas(gcf,'results/nyfit07','epsc')
saveas(gcf,'results/nyfit07.fig')