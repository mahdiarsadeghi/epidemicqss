function q = lsfit(model,time,data)
    pop = 2e7;            % population
    % p0 = (gamma,K,alpha,c,k0,S0,I0,beta0)
    p0 = [0.1111, 0.0019, 0.0679, 1e-6, 8e-4, pop, 1, 0.0283];
    lb = p0/4; lb(6)=pop; % lower bound
    ub = p0*4; ub(6)=pop; % upper bound
    q = lsqcurvefit(model, p0, time, data, lb, ub);
end