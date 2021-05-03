% data should be a 1d array 
% population should be reported in millions
% output is a figure and fitted parameters
% 
function q = qssfit(data, population, maxdays, text, n)
%
newcases = diff(data);
starttime = newcases>10;
% start after having 10 new cases in one day
pointer = find(starttime,1,'first');
timepoints = 1:maxdays;
newcases = newcases(pointer:pointer+maxdays-1)';
% 7 days moving average
newcases = movmean(newcases, 14);
% fit qss model to the data
q = fitqssmodel(@equation11, timepoints, newcases, population);
F = @(t,x) [(population*x(2)-q(1)) * x(1);...
            q(2)/(1+x(1)*q(4))-q(3)*x(2)];
[~,X]=ode45(F,timepoints,q(5:6));

fitdata = population.*X(:,1).*X(:,2);

figure 
hold on
plot(timepoints, fitdata*n, 'b-', 'LineWidth', 3)
plot(timepoints, newcases*n, 'r*'); 
legend(["Model", "Data"])
grid on
xlabel("Time (days after having 10 daily new COVID cases)")
ylabel("Number of newly infected indinviduals")
title(text)
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
saveas(gcf,strrep(join(['results/' text '.jpg']),' ',''))
saveas(gcf,strrep(join(['results/' text]),' ',''),'epsc')
saveas(gcf,strrep(join(['results/' text '.fig']),' ',''))

end