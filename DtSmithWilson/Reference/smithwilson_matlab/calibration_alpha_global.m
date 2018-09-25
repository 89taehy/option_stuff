function alpha_rev=calibration_alpha_global(ttm,ytm,UFR,alpha_0,T2,tol_converge,display_option,Umat,n_peryear)
%calibrate alpha, such that |forward_rate(T2)-UFR|<tol
%tol_converge is supposed to be 3*10^-4( suggested, 3bps)
%display_option=1: see progress of calibration
%              =0: not see progress.
if display_option==1
%see progress
alpha_rev=alpha_0;

[~,~,fr_vector,~,~]=smith_wilson_kofiabond(ttm,ytm,UFR,alpha_rev,Umat,n_peryear);

i_lower=12*31;
%fr_vector(i_lower)
if(abs(fr_vector(i_lower)-UFR)<=tol_converge)
    alpha_rev=alpha_0;
    return
end
while((abs(fr_vector(i_lower)-UFR)>tol_converge)&&(i_lower<=12*98))
    i_lower=i_lower+1;
end
disp('initial i_lower is')
disp(i_lower)
disp('initial fr_vector(i_lower) is')
disp(fr_vector(i_lower))
ind_repeat=1;
num_repeat=0;
alpha_stepsize=0.1;
while(ind_repeat==1)
num_repeat=num_repeat+1;
disp(['try #' num2str(num_repeat)])
ind_repeat=0;
iter_number=0;
alpha_stepsize=alpha_stepsize/10;

alpha_before_2=alpha_rev+2;
alpha_before_1=alpha_rev+1;
alpha_before_0=alpha_rev;
% diff_12=i_before_1-i_before_2;
% diff_10=i_before_0-i_before_1;
while((i_lower<12*T2)||(i_lower>12*T2))
%     i_before_0는 새로 결정해야함.
    iter_number=iter_number+1;
    if((iter_number==150))
        disp('iteration number limit hitted')
        disp('lets try again')
        disp('current i_lower is ')
        disp(i_lower)
        ind_repeat=1;
        break
    elseif((alpha_before_2==alpha_before_0)&&(~(i_lower==12*T2)))
        disp('same iteration but not reached optimal')
        disp('lets try again')
        disp('current i_lower is ')
        disp(i_lower)
        disp('current i_before_2 is ')
        disp(alpha_before_2)
        disp('current i_before_0 is ')
        disp(alpha_before_0)
        ind_repeat=1;
        break
    elseif(i_lower<12*T2)
        alpha_rev=alpha_rev-alpha_stepsize;
    elseif(i_lower>12*T2)
        alpha_rev=alpha_rev+alpha_stepsize;
    end
    alpha_before_2=alpha_before_1;
    alpha_before_1=alpha_before_0;
    alpha_before_0=alpha_rev;
%     elseif(i_lower<50)
%         alpha_rev=alpha_rev-0.5;
%     elseif(i_lower<60)
%         alpha_rev=alpha_rev-0.4;
%     elseif(i_lower<70)
%         alpha_rev=alpha_rev-0.3;
%     elseif(i_lower<85)
%         alpha_rev=alpha_rev-0.2;
%     elseif(i_lower<86)
%         alpha_rev=alpha_rev-0.1;
%     elseif(i_lower<87)
%         alpha_rev=alpha_rev-0.01;
%     elseif(i_lower<88)
%         alpha_rev=alpha_rev-0.005;
%     elseif(i_lower<89)
%         alpha_rev=alpha_rev-0.001;
%     elseif(i_lower>91)
%         alpha_rev=alpha_rev+0.001;
%     elseif(i_lower>92)
%         alpha_rev=alpha_rev+0.002;
%     elseif(i_lower>93)
%         alpha_rev=alpha_rev+0.1;
%     elseif(i_lower>94)
%         alpha_rev=alpha_rev+0.2;
%     elseif(i_lower>95)
%         alpha_rev=alpha_rev+0.5;
    [~,~,fr_vector,~,~]=smith_wilson_kofiabond(ttm,ytm,UFR,alpha_rev,Umat,n_peryear);
    i_lower=12*31;
    while((abs(fr_vector(i_lower)-UFR)>tol_converge)&&(i_lower<=12*Umat-2))
        i_lower=i_lower+1;
    end
    
%     diff_12=i_before_1-i_before_2;
%     diff_10=i_before_0-i_before_1;
    disp(['----iteration #' num2str(iter_number) '----'] )
%     disp(['iter number ' num2str(iter_number)])
    disp(['i_lower is ' num2str(i_lower)])
    disp(['alpha_rev is ' num2str(alpha_rev,Umat)])
end
end
% i_real=1;
% while((abs(fr_vector(i_real)-UFR)>tol_converge_real)&&(i_real<=98))
% i_real=i_real+1;
% end
disp(' ')
disp('----Jobs done!----')
disp('lower maturity is')
disp(i_lower)
disp('corresponding alpha is')
disp(alpha_rev)


% disp('lower forward rate is')
% disp(fr_vector(i_lower))
% disp('lower forward rate around')
% for ind_around=0:10
% disp(fr_vector(i_lower-5+ind_around))
% end
% 
% 
% disp('real maturity is')
% disp(i_real)
% disp('real forward rate is')
% disp(fr_vector(i_real))
% 
% disp('last forward')
% disp(fr_vector(end))
% 
% plot(1:99,fr_vector)
% 
else
%see progress
alpha_rev=alpha_0;

[~,~,fr_vector,~,~]=smith_wilson_kofiabond(ttm,ytm,UFR,alpha_rev,Umat,n_peryear);

i_lower=12*31;
%fr_vector(i_lower)
if(abs(fr_vector(i_lower)-UFR)<=tol_converge)
    alpha_rev=alpha_0;
    return
end
while((abs(fr_vector(i_lower)-UFR)>tol_converge)&&(i_lower<=12*98))
    i_lower=i_lower+1;
end

ind_repeat=1;
num_repeat=0;
alpha_stepsize=0.1;
while(ind_repeat==1)
num_repeat=num_repeat+1;
ind_repeat=0;
iter_number=0;
alpha_stepsize=alpha_stepsize/10;

alpha_before_2=alpha_rev+2;
alpha_before_1=alpha_rev+1;
alpha_before_0=alpha_rev;
% diff_12=i_before_1-i_before_2;
% diff_10=i_before_0-i_before_1;
while((i_lower<12*T2)||(i_lower>12*T2))
%     i_before_0는 새로 결정해야함.
    iter_number=iter_number+1;
    if((iter_number==150))
       
        ind_repeat=1;
        break
    elseif((alpha_before_2==alpha_before_0)&&(~(i_lower==12*T2)))

        ind_repeat=1;
        break
    elseif(i_lower<12*T2)
        alpha_rev=alpha_rev-alpha_stepsize;
    elseif(i_lower>12*T2)
        alpha_rev=alpha_rev+alpha_stepsize;
    end
    alpha_before_2=alpha_before_1;
    alpha_before_1=alpha_before_0;
    alpha_before_0=alpha_rev;
%     elseif(i_lower<50)
%         alpha_rev=alpha_rev-0.5;
%     elseif(i_lower<60)
%         alpha_rev=alpha_rev-0.4;
%     elseif(i_lower<70)
%         alpha_rev=alpha_rev-0.3;
%     elseif(i_lower<85)
%         alpha_rev=alpha_rev-0.2;
%     elseif(i_lower<86)
%         alpha_rev=alpha_rev-0.1;
%     elseif(i_lower<87)
%         alpha_rev=alpha_rev-0.01;
%     elseif(i_lower<88)
%         alpha_rev=alpha_rev-0.005;
%     elseif(i_lower<89)
%         alpha_rev=alpha_rev-0.001;
%     elseif(i_lower>91)
%         alpha_rev=alpha_rev+0.001;
%     elseif(i_lower>92)
%         alpha_rev=alpha_rev+0.002;
%     elseif(i_lower>93)
%         alpha_rev=alpha_rev+0.1;
%     elseif(i_lower>94)
%         alpha_rev=alpha_rev+0.2;
%     elseif(i_lower>95)
%         alpha_rev=alpha_rev+0.5;
    [~,~,fr_vector,~,~]=smith_wilson_kofiabond(ttm,ytm,UFR,alpha_rev,Umat,n_peryear);
    i_lower=12*31;
    while((abs(fr_vector(i_lower)-UFR)>tol_converge)&&(i_lower<=12*Umat-2))
        i_lower=i_lower+1;
    end
    
%     diff_12=i_before_1-i_before_2;
%     diff_10=i_before_0-i_before_1;
end
end
% i_real=1;
% while((abs(fr_vector(i_real)-UFR)>tol_converge_real)&&(i_real<=98))
% i_real=i_real+1;
% end


end
% disp('lower forward rate is')
% disp(fr_vector(i_lower))
% disp('lower forward rate around')
% for ind_around=0:10
% disp(fr_vector(i_lower-5+ind_around))
% end
% 
% 
% disp('real maturity is')
% disp(i_real)
% disp('real forward rate is')
% disp(fr_vector(i_real))
% 
% disp('last forward')
% disp(fr_vector(end))
% 
% plot(1:99,fr_vector)
% end