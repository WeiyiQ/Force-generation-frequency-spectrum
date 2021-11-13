
Beta = K_beta_act/C_alpha;

t1 = 300; 
t =1:6:t1;
F1 = (K_sf_act*C_alpha*K_m*D_eltaCm)* t.^(Beta) + (K_sf_act*C_alpha*K_m*D_eltaCm)*(Beta).^2* (t).^(Beta-1);

t = t1:6:1800;
F2 = (K_sf_act*C_alpha*K_m*D_eltaCm * t1.^(Beta) + (K_sf_act*C_alpha*K_m*D_eltaCm)*(Beta).^2 * (t1).^(Beta-1))*(exp((t1-t)/(Beta*1200)));
F3 = (K_sf_act*C_alpha*K_m*D_eltaCm * t.^(Beta) + (K_sf_act*C_alpha*K_m*D_eltaCm)*(Beta).^2 * (t).^(Beta-1))-(K_sf_act*C_alpha*K_m*D_eltaCm*(t-t1).^(Beta)+(K_sf_act*C_alpha*K_m*D_eltaCm)*(Beta).^2* (t-t1).^(Beta-1));

F=[F1,F2]';
figure
plot(F); 
