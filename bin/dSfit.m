function q = dSfit(model,time,data)
    p0 = [0.1111, 0.0019, 0.0679, 8e-4, 20, 1, 0.0283];
    lb = p0/5; lb(5)=20; lb(6)=1;         % lower bound
    ub = p0*5; ub(5)=20; ub(6)=1;         % upper bound
    q = lsqcurvefit(model, p0, time, data, lb, ub);
end