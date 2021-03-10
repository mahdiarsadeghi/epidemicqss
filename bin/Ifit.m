function q = Ifit(model,time,data)
    pop = 20;                  % normalized population
    p0 = [0.1111,0.0019,0.0679,8e-4,pop,1,0.0283];
    lb = p0/5; lb(5)=pop; lb(6)=1;       % lower bound
    ub = p0*5; ub(5)=pop; ub(6)=1e2;     % upper bound
    q = lsqcurvefit(model, p0, time, data, lb, ub);
end