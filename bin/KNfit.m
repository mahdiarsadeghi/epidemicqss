function q = KNfit(model,time,data)
    p0 = [0.1111, 1e-6, 0.0679, 10, 2e7, 1, 0.0283]; % initial guess
    lb = [0.1111, 1e-6, 0.0679, 10, 2e7, 1, 0.0283];   % lower bound
    ub = p0*20; ub(5)=2e7; ub(6)=100;                  % upper bound
    q = lsqcurvefit(model, p0, time, data, lb, ub);      % LS method
end