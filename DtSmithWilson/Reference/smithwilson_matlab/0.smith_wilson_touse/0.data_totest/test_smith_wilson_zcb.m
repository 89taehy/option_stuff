clear all;clc;close all
raw_data=xlsread('zcb_data.xlsx');

ttm=raw_data(1,:);
ytm=raw_data(2,:);


ytm=ytm(mod(ttm,1)==0);
ttm=ttm(mod(ttm,1)==0);

UFR=4.5*10^-2;
alpha_rev=0.1;
Umat=100;
n_peryear=12;
tic
[p_vector,spot_vector,fr_vector,LL_forward,LL_spot]=smith_wilson_zcb(ttm,ytm,UFR,alpha_rev,Umat,n_peryear);
toc