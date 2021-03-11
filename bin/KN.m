% K normalized model
function infected = KN(p,time)
g  = p(1);
c  = p(2);
a  = p(3);
k0 = p(4);
x0 = p(5:7);
    [~,Sol] = ode23s(@model, time', x0);
    function dS = model(t, x)
            xdot = zeros(3,1);
            xdot(1) = -c*x(1)*x(2)*x(3);
            xdot(2) = c*x(1)*x(2)*x(3) - g*x(2);
            xdot(3) =  -a*x(3) + 1/(1+k0*x(2));
            dS = xdot;
    end
    infected = -diff(Sol(:,1));
    % assuming that system is at steady state at the end
    infected(end+1) = infected(end);
end