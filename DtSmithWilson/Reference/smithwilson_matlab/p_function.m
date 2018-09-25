function p=p_function(x,n_inst,t,n_j,cashflow,u_j_grid,UFR,alpha_rev)
%x:parameters. length of n_inst.
p=exp(-UFR*t);
for i=1:n_inst
    p=p+x(i)*kernel_function(i,t,n_j,cashflow,u_j_grid,UFR,alpha_rev);
end