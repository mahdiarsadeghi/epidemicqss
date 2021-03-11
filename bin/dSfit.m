function q = dSfit(model,time,data,pop)
    p0 = [0.1111, 0.0019, 0.0679, 8e-4, pop, 1, 0.0283];
    lb = p0/20; lb(5)=pop; lb(6)=1;   lb(1)=1/21;     % lower bound
    ub = p0*20; ub(5)=pop; ub(6)=100; ub(1)=1/7;      % upper bound
    q = lsqcurvefit(model, p0, time, data, lb, ub);
end