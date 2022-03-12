clc
clear all
close all

P_x = [0.5 0.5];
a = 1;
SNR = 0:5;
x_pow = 1;
n_pow = x_pow./(10.^(SNR/10));
err = zeros(size(SNR));
z2o = zeros(size(SNR));
o2z = zeros(size(SNR));

N = 100;
N_s = 1000;
for i = 1:N
    for j = 1:length(SNR)
        x = randsrc(1,N_s, [-1 1; P_x]);
        % la variable de salida contaminada está en función de la varianza de la potencia de ruido
        % con un promedio de x=[-5 5]
        y = sqrt(n_pow(j))*randn(1,N_s) + x;
        xe = (y>=0)*2 - 1;
        err(j) = err(j) + sum(x~=xe);
        indx_err = find((x~=xe)==1);
        for k = indx_err
            if x(k)==1 & xe(k)==-1
                o2z(j) = o2z(j) +1;
            elseif x(k)==-1 & xe(k)==1
                z2o(j) = z2o(j) +1;
            end  
        end
    end
    P_e =  err/(i*N_s);
    semilogy(SNR,P_e)
    title(i*N_s)
    drawnow
end

% 
% x_alph = randerr(1,N,[0 (N/2);0 1]);
% y = zeros(1,N);
% y_alph = zeros(1,N);
% 
% for i=1:N
%     y(i) = x_alph(i) + randn(1,1) * sqrt(n_pow);
%     if y(i) < 0
%         y_alph(i) = 0;
%     else
%         y_alph(i) = 1;
%     end
%     if x_alph(i) == y_alph(i)
%         if x_alph(i) == 0
%             z2z = z2z + 1;
%         else 
%             one2one = one2one +1;
%         end
%     else
%        if isequal(x_alph(i),0) && isequal(y_alph(i),1)
%            z2one = z2one + 1;
%        elseif isequal(x_alph(i),1) && isequal(y_alph(i),0)
%            one2z = one2z + 1;
%        end
%     end       
% end
% 

% 
% z2z_prob = z2z/(N/2);
% one2one_prob = one2one/(N/2);
% z2one_prob = z2one/(N/2);
% one2z_prob = one2z/(N/2);
% 
% P_a = [z2z_prob+one2z_prob ; z2one_prob+one2one_prob].*0.5;
% 
% %entropia de salida
% h_y=sum(-P_a.*log2(P_a));
% 
% % entropia hacia delante = 
% h_yx0 = -z2z_prob*log2(z2z_prob)-z2one_prob*log2(z2one_prob);
% h_yx1 = -one2z_prob*log2(one2z_prob)-one2one_prob*log2(one2one_prob);
% h_yx = (h_yx0 + h_yx1)*0.5; 
% 
% I_m = h_y-h_yx;
% 
% C = max(I_m);
% 
% P_e = (z2one_prob+one2z_prob)*0.5;
%% 4ASK
