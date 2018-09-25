function [p_vector,spot_vector,fr_vector,LL_forward,LL_spot]=smith_wilson_engine(cashflow_time_grid_input,cashflow_input,m_vector,UFR,alpha_rev,Umat,n_peryear)


% %param example
% UFR=4.5*10^-2;
% alpha_rev=0.1;
% Umat=100;
% n_peryear=12;
% 
% %input example

% cashflow_time_grid_input=cell(n_inst,1);
% cashflow_time_grid_input{1}=[1];
% cashflow_time_grid_input{2}=[2];
% cashflow_time_grid_input{3}=[3];
% cashflow_time_grid_input{4}=[4];
% cashflow_time_grid_input{5}=[7];
% cashflow_time_grid_input{6}=[10];
% cashflow_time_grid_input{7}=[20];
% 
% cashflow_input=cell(n_inst,1);
% cashflow_input{1}=[1];
% cashflow_input{2}=[1];
% cashflow_input{3}=[1];
% cashflow_input{4}=[1];
% cashflow_input{5}=[1];
% cashflow_input{6}=[1];
% cashflow_input{7}=[1];
% 
% m_vector=zeros(n_inst,1);
% 
% m_vector(1)=exp(-0.01*1);
% m_vector(2)=exp(-0.02*2);
% m_vector(3)=exp(-0.03*3);
% m_vector(4)=exp(-0.04*4);
% m_vector(5)=exp(-0.04*7);
% m_vector(6)=exp(-0.04*10);
% m_vector(7)=exp(-0.04*20);

n_inst=size(m_vector,1);

u_j_grid=cashflow_time_grid_input{1};
for i=2:n_inst
    u_j_grid=union(u_j_grid,cashflow_time_grid_input{i});
end
n_j=length(u_j_grid);
%calculate the idx 
% ct_store=zeros(n_inst,n_cashflow);
cashflow_matrix=zeros(n_inst,n_j);

for i=1:n_inst
    [~,ia,~]=intersect(u_j_grid,cashflow_time_grid_input{i});
%     ct_store(i,ia)=cashflow_time_grid_input{i};
    cashflow_matrix(i,ia)=cashflow_input{i};        
end    
%matrix solving
% cashflow_matrix=zeros(n_inst,n_j);
w_matrix=zeros(n_j,n_j);
% marketprice_vector=zeros(n_inst,1);

for i=1:n_j
    for j=1:n_j
        w_matrix(i,j)=w_function(u_j_grid(i),u_j_grid(j),UFR,alpha_rev);
    end
end

mu_vector=exp(-UFR*u_j_grid)';
zeta_coef=cashflow_matrix*w_matrix*cashflow_matrix';
x=zeta_coef\(m_vector-cashflow_matrix*mu_vector);

p_vector=zeros(1,n_peryear*Umat);
for i=1:n_peryear*Umat
    p_vector(i)=p_function(x,n_inst,i/n_peryear,n_j,cashflow_matrix,u_j_grid,UFR,alpha_rev);
end
% plot(1:100,p_vector)
%spot rate 추출
spot_vector=-(n_peryear./(1:(n_peryear*Umat))).*log(p_vector);

% plot(1:100,spot_vector)

%forward rate 추출
fr_vector=zeros(1,n_peryear*Umat);
% fr_vector(1)=-log(p_vector(1));
fr_vector(1)=spot_vector(1);
for i=2:n_peryear*Umat
   fr_vector(i)=n_peryear*log(p_vector(i-1)/p_vector(i));
end

LL_forward=fr_vector(end);

LL_spot=spot_vector(end);

x_toplot=(1:n_peryear*Umat)/n_peryear;
% figure
% subplot(1,3,1)
% plot(x_toplot,p_vector)
% xlabel('time to maturity')
% ylabel('discount factor')
% % 
% subplot(1,3,2)
% plot(x_toplot,spot_vector)
% xlabel('time to maturity')
% ylabel('spot rate')
% 
% subplot(1,3,3)
% plot(x_toplot,fr_vector)
% xlabel('time to maturity')
% ylabel('forward rate')
