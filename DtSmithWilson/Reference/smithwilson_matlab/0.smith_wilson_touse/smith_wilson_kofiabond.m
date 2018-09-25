function [p_vector,spot_vector,fr_vector,LL_forward,LL_spot]=smith_wilson_kofiabond(ttm,ytm,UFR,alpha_rev,Umat,n_peryear)
% clear all;clc;close all
% test_smith_wilson_kofiabond
n_inst=length(ttm);

cashflow_time_grid_input=cell(1,1);
cashflow_input=cell(1,1);
m_vector=zeros(n_inst,1);

ttm_quarter=int16(round(ttm*4));

for i=1:n_inst
    cashflow_time_grid_input{i}=double(flip(ttm_quarter(i):(-2):1))/4;
    cashflow_input{i}=ytm(i)/2*ones(1,size(cashflow_time_grid_input{i},2));
    cashflow_input{i}(1,end)=cashflow_input{i}(1,end)+1;    
%     m_vector(i)=cashflow_input{i}*exp(-ytm(i)*cashflow_time_grid_input{i})';
    if abs(cashflow_time_grid_input{i}(1)-0.5)<0.001
        m_vector(i)=1; 
    else        
        m_vector(i)=cashflow_input{i}*((1+ytm(i)/2).^(-(2*(cashflow_time_grid_input{i}-cashflow_time_grid_input{i}(1))+1)))';                
        m_vector(i)=m_vector(i)*(1+ytm(i)/2)/(1+ytm(i)*cashflow_time_grid_input{i}(1));        
    end
%     
%     disp(i)
%     disp(cashflow_input{i})
%     disp(isa(cashflow_time_grid_input{i},'double'))
%     disp('bback')
end
% m_vector
[p_vector,spot_vector,fr_vector,LL_forward,LL_spot]=smith_wilson_engine(cashflow_time_grid_input,cashflow_input,m_vector,UFR,alpha_rev,Umat,n_peryear);
