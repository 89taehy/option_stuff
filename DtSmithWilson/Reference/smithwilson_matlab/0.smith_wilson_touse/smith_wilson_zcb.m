function [p_vector,spot_vector,fr_vector,LL_forward,LL_spot]=smith_wilson_zcb(ttm,ytm,UFR,alpha_rev,Umat,n_peryear)
% clear all;clc;close all
% test_smith_wilson_kofiabond
n_inst=length(ttm);

cashflow_time_grid_input=cell(1,1);
cashflow_input=cell(1,1);
m_vector=zeros(n_inst,1);

for i=1:n_inst
    cashflow_time_grid_input{i}=ttm(i);
    cashflow_input{i}=1;    
%     m_vector(i)=cashflow_input{i}*exp(-ytm(i)*cashflow_time_grid_input{i})';
    m_vector(i)=cashflow_input{i}*exp(-ytm(i)*cashflow_time_grid_input{i})';
%     
%     disp(i)
%     disp(cashflow_input{i})
%     disp(isa(cashflow_time_grid_input{i},'double'))
%     disp('bback')
end
[p_vector,spot_vector,fr_vector,LL_forward,LL_spot]=smith_wilson_engine(cashflow_time_grid_input,cashflow_input,m_vector,UFR,alpha_rev,Umat,n_peryear);
