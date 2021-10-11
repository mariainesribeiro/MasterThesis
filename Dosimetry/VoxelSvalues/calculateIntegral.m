function [N] = calculateIntegral(halfLife,t0,t1)

fun = @(t) exp(-(log(2)/halfLife)*t);

N = integral(fun,t0,t1);