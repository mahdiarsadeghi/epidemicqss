% inputs: parameter vector p, and time array
% output: qss epidemic ode model for fitting
% mahdiar sadeghi
% 
function newinfections = equation11(p,time)
g  = p(1);
K  = p(2);
a  = p(3);
u  = p(4);
x0 = p(5:6);
pop = p(7);
    [~,Sol] = ode23s(@model, time', x0);
    function dX = model(t, x)
            xdot = zeros(2,1);
            xdot(1) =  (pop*x(2) - g) * x(1);
            xdot(2) =  -a*x(2)+K/(1+x(1)*u);
            dX = xdot;
    end
    % I'(t) = -S'(t) = S*I*beta
    newinfections = pop*Sol(:,1).*Sol(:,2);
end