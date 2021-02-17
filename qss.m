function infected = qss(p,time)
g  = p(1);
K  = p(2);
a  = p(3);
c  = p(4);
k0 = p(5);
x0 = p(6:8);
    [~,Sol] = ode23s(@model, time', x0);
    function dS = model(t, x)
            xdot = zeros(3,1);
            xdot(1) = -c*x(1)*x(2)*x(3);
            xdot(2) =  c*x(1)*x(2)*x(3) - x(2)*g;
            xdot(3) =  -a*x(3)+K/(1+x(2)*k0);
            dS = xdot;
    end
    infected = -diff(Sol(:,1));
    % assuming that system is at steady state at the end
    infected(end+1) = infected(end);
end