function w=w_function(t,u_j,UFR,alpha_rev)
w=exp(-UFR*(t+u_j))*(alpha_rev*min(t,u_j)-0.5*exp(-alpha_rev*max(t,u_j))*(exp(alpha_rev*min(t,u_j))-exp(-alpha_rev*min(t,u_j))));