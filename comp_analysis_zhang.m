fx_gt = 534.0;
fy_gt = 534.0;
cx_gt = 309.0;
cy_gt = 238.0;
k1_gt = -0.1623;
k2_gt = 0.4;
k3_gt = -0.04;
p1_gt = -0.00154;
p2_gt = 0.0067;

cwru_set = csvread("DATA/cwru_target_noise_proc.csv");
ind_set = csvread("DATA/zhang_noise_proc.csv");
%cwru_set = csvread("DATA/cwru_target_scale_proc.csv");
%ind_set = csvread("DATA/zhang_scale_proc.csv");

s_cwru = cwru_set(:, 2);
s_ind = ind_set(:, 1);

n_cwru = cwru_set(:, 1);
n_ind = ind_set(:, 2);

rms_cwru = cwru_set(:, 3);
rms_ind = ind_set(:, 5);

fx_cwru = cwru_set(:, 4);
fx_ind = ind_set(:, 9);
% fx_err_cwru = abs(fx_cwru - fx_gt) / fx_gt;
% fx_err_ind = abs(fx_ind - fx_gt) / fx_gt;
fy_cwru = cwru_set(:, 5);
fy_ind = ind_set(:, 9);

cx_cwru = cwru_set(:, 6);
cx_ind = ind_set(:, 11);
% cx_err_cwru = abs(cx_cwru - cx_gt) / cx_gt;
% cx_err_ind = abs(cx_ind - cx_gt) / cx_gt;
cy_cwru = cwru_set(:, 7);
cy_ind = ind_set(:, 15);

k1_cwru = cwru_set(:, 8);
k1_ind = ind_set(:, 4);
% k1_err_cwru = abs(k1_cwru - k1_gt) / k1_gt;
% k1_err_ind = abs(k1_ind - k1_gt) / k1_gt;
k2_cwru = cwru_set(:, 9);
k3_cwru = cwru_set(:, 10);
p1_cwru = cwru_set(:, 11);
p2_cwru = cwru_set(:, 12);
k2_ind = ind_set(:, 5);
k3_ind = ind_set(:, 8);
p1_ind = ind_set(:, 6);
p2_ind = ind_set(:, 7);


fx_err_cwru = abs(fx_cwru - fx_gt);
fx_err_ind = abs(fx_ind - fx_gt);
fy_err_cwru = abs(fy_cwru - fy_gt);
fy_err_ind = abs(fy_ind - fy_gt);
cx_err_cwru = abs(cx_cwru - cx_gt);
cx_err_ind = abs(cx_ind - cx_gt);
cy_err_cwru = abs(cy_cwru - cy_gt);
cy_err_ind = abs(cy_ind - cy_gt);
k1_err_cwru = abs(k1_cwru - k1_gt);
k1_err_ind = abs(k1_ind - k1_gt);
k2_err_cwru = abs(k2_cwru - k2_gt);
k2_err_ind = abs(k2_ind - k2_gt);
k3_err_cwru = abs(k3_cwru - k3_gt);
k3_err_ind = abs(k3_ind - k3_gt);
p1_err_cwru = abs(p1_cwru - p1_gt);
p1_err_ind = abs(p1_ind - p1_gt);
p2_err_cwru = abs(p2_cwru - p2_gt);
p2_err_ind = abs(p2_ind - p2_gt);

fprintf("FX cwru %f \n", median(fx_err_ind - fx_err_cwru));
fprintf("FY cwru %f \n", median(fy_err_ind - fy_err_cwru));
fprintf("CX cwru %f \n", median(cx_err_ind - cx_err_cwru));
fprintf("CY cwru %f \n", median(cy_err_ind - cy_err_cwru));
fprintf("K1 cwru %f \n", median(k1_err_ind - k1_err_cwru));
fprintf("K2 cwru %f \n", median(k2_err_ind - k2_err_cwru));
fprintf("K3 cwru %f \n", median(k3_err_ind - k3_err_cwru));
fprintf("P1 cwru %f \n", median(p1_err_ind - p1_err_cwru));
fprintf("P2 cwru %f \n", median(p2_err_ind - p2_err_cwru));