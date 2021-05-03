function q = fitqssmodel(model,time,data,pop)
    p0 = [0.11111, 0.0019, 0.0679, 8e-4,  1, 0.0283, pop];
    lb = p0*1e-2; lb(7)=pop; lb(5)=10;lb(1)=1/14;     % lower bound
    ub = p0*1e+2; ub(7)=pop; ub(5)=1000; ub(1)=1;     % upper bound
    q = lsqcurvefit(model, p0, time, data, lb, ub);
end