%% load data
load nydata
time = 1:200;
data = NewCases9(time);
data2 = NewCases9(time);
% figure 
subplot(1,3,1)
% title("Active Infections")
plot(time, data, 'r*')
% visualize
p = [0.1111, 0.0019, 0.0679, 1e-6, 8e-4, 2e7, 1, 0.0283];
% qss-sir model not notmalized 
% states: (S,I,beta)
F=@(t,x) [-p(4)*x(1)*x(2)*x(3); ...
          p(4)*x(1)*x(2)*x(3) - x(2)*p(1);...
          p(2)/(1+x(2)*p(5))-p(3)*x(3)];
[tspan,X]=ode45(F,time,p(6:8));

% visualize 
hold on
plot(time, X(:,2), 'b-', 'LineWidth', 3)
subplot(1,3,2)
plot(time, X(:,3), 'b-', 'LineWidth', 3)
% title("\beta(t) Not-normalized")

% visualize
q = [0.1111, 0.0019, 0.0679, 8e-4, 20, 1, 0.0283];
% qss-sir model normalized
% states: (S,I,beta)
F=@(t,x) [-x(1)*x(2)*x(3)*1e-6; ...
          x(1)*x(2)*x(3) - x(2)*q(1);...
          q(2)/(1+x(2)*q(4))-q(3)*x(3)];
[tspan,Y]=ode45(F,time,q(5:7));

newinfected = -diff(Y(:,1));
newinfected(end+1) = newinfected(end);
% visualize
subplot(1,3,1)
hold on
plot(time, Y(:,2), 'b-', 'LineWidth', 3)
hold off
subplot(1,3,3)
% title("\beta(t) Normalized")
plot(time, Y(:,3), 'b-', 'LineWidth', 3)

figure
subplot(1,2,1)
hold on
plot(time, X(:,2), 'b-', 'LineWidth', 3)
plot(time, data, 'r*')
subplot(1,2,2)
hold on
plot(time, Y(:,2), 'b-', 'LineWidth', 3)
plot(time, data2, 'r*')