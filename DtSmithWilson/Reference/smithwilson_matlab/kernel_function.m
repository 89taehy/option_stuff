function k=kernel_function(i,t,n_j,cashflow,u_j_grid,UFR,alpha_rev)
k=0;
for j=1:n_j
    k=k+cashflow(i,j)*w_function(t,u_j_grid(j),UFR,alpha_rev);
end
