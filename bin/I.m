function infected = I(p,time)
g  = p(1);
K  = p(2);
a  = p(3);
k0 = p(4);
x0 = p(5:7);
    [~,Sol] = ode23s(@model, time', x0);
    function dS = model(t, x)
            xdot = zeros(3,1);
            xdot(1) = -1e-6*x(1)*x(2)*x(3);
            xdot(2) =  x(1)*x(2)*x(3) - x(2)*g;
            xdot(3) =  -a*x(3)+K/(1+x(2)*k0);
            dS = xdot;
    end
    infected = Sol(:,2);
end