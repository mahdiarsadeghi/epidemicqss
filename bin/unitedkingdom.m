%% data
pop = 0.348;
load unitedkingdom
uk = diff(uk);
s = uk>10;
pointer = find(s,1,'first');
ut = 1:130;
uk = uk(pointer:pointer+129)';
uk07 = movmean(uk, 7);

% fit qss-sir model utates: (S,I,beta) to raw data 
q = dSfit(@dS, ut, uk, pop);

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
title("United Kingdom Islands")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/ukrawfit.jpg')
saveas(gcf,'results/ukrawfit','epsc')
saveas(gcf,'results/ukrawfit.fig')

%% fit to moving mean 7 points
q = dSfit(@dS, ut, uk07, pop);
F = @(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,X]=ode45(F,ut,q(5:7));

newinfected = -1e6*diff(X(:,1));
newinfected(end+1) = newinfected(end);

figure 
hold on
plot(ut, uk07, 'r*'); 
plot(ut, newinfected, 'b-', 'LineWidth', 3)
legend(["Data", "Fit"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title("United Kingdom Islands")
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,'results/ukfit07.jpg')
saveas(gcf,'results/ukfit07','epsc')
saveas(gcf,'results/ukfit07.fig')