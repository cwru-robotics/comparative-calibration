fx_gt = 534.0;
fy_gt = 534.0;
cx_gt = 309.0;
cy_gt = 238.0;
k1_gt = -0.1623;
k2_gt = 0.4;
k3_gt = -0.04;
p1_gt = -0.00154;
p2_gt = 0.0067;


cwru_set = csvread("DATA\cwru_move_noise_proc.csv");
ind_set = csvread("DATA\ind_move_noise_proc.csv");

s_cwru = cwru_set(:, 2);
s_ind = ind_set(:, 1);

n_cwru = cwru_set(:, 1);
n_ind = ind_set(:, 2) * 48;

rms_cwru = cwru_set(:, 3);
rms_ind = ind_set(:, 5);

fx_cwru = cwru_set(:, 4);
fx_ind = ind_set(:, 7);
% fx_err_cwru = abs(fx_cwru - fx_gt) / fx_gt;
% fx_err_ind = abs(fx_ind - fx_gt) / fx_gt;
fy_cwru = cwru_set(:, 5);
fy_ind = ind_set(:, 11);

cx_cwru = cwru_set(:, 6);
cx_ind = ind_set(:, 9);
% cx_err_cwru = abs(cx_cwru - cx_gt) / cx_gt;
% cx_err_ind = abs(cx_ind - cx_gt) / cx_gt;
cy_cwru = cwru_set(:, 7);
cy_ind = ind_set(:, 12);

k1_cwru = cwru_set(:, 8);
k1_ind = ind_set(:, 17);
% k1_err_cwru = abs(k1_cwru - k1_gt) / k1_gt;
% k1_err_ind = abs(k1_ind - k1_gt) / k1_gt;
k2_cwru = cwru_set(:, 9);
k3_cwru = cwru_set(:, 10);
p1_cwru = cwru_set(:, 11);
p2_cwru = cwru_set(:, 12);
k2_ind = ind_set(:, 18);
k3_ind = ind_set(:, 19);
p1_ind = ind_set(:, 20);
p2_ind = ind_set(:, 21);


figure('Name', 'Stated Reprojection Error');
hold on;
scatter3(s_cwru, n_cwru, rms_cwru);
scatter3(s_ind,  n_ind,  rms_ind);
hold off;
figure('Name', 'Stated Reprojection Error Wins');
rms_wins = reshape(rms_ind < rms_cwru, 19, 21);
imagesc([s_cwru(1) s_cwru(end)], [9024-n_cwru(end) 9024-n_cwru(1)], rms_wins * 100);
ylabel('Number of Points');

% figure('Name', 'FX Error');
% hold on;
% scatter3(s_cwru, n_cwru, fx_err_cwru);
% scatter3(s_ind,  n_ind,  fx_err_ind);
% hold off;
% figure('Name', 'FX Error Wins');
% fx_err_wins = reshape(fx_err_ind > fx_err_cwru, 18, 21);
% image(fx_err_wins * 255);
% colormap cool;
% 
% figure('Name', 'CX Error');
% hold on;
% scatter3(s_cwru, n_cwru, cx_err_cwru);
% scatter3(s_ind,  n_ind,  cx_err_ind);
% hold off;
% figure('Name', 'CX Error Wins');
% cx_err_wins = reshape(cx_err_ind > cx_err_cwru, 18, 21);
% image(cx_err_wins * 255);
% colormap cool;
% 
% figure('Name', 'K1 Error');
% hold on;
% scatter3(s_cwru, n_cwru, k1_err_cwru);
% scatter3(s_ind,  n_ind,  k1_err_ind);
% hold off;
% figure('Name', 'K1 Error Wins');
% k1_err_wins = reshape(k1_err_ind > k1_err_cwru, 18, 21);
% image(k1_err_wins * 255);
% colormap cool;

points = rand(1000, 3);
points(:, 1) = points(:, 1) - 0.5;
points(:, 2) = points(:, 2) - 0.5;
points(:, 3) = points(:, 3) + 0.5;
%scatter3(points(:, 1), points(:, 2), points(:, 3));

avg_errs_ind = nan(size(s_ind, 1), 1);
avg_errs_cwru = nan(size(s_cwru, 1), 1);

for i = 1 : size(s_ind, 1)
%     if(i == 1)
%         figure();
%         hold on;
%     end
    total_dist_ind = 0;
    total_dist_cwru = 0;
    for p = 1 : 1000
        reality_point = project(points(p, :), [fx_gt, fy_gt], [cx_gt, cy_gt], [k1_gt, k2_gt, k3_gt, p1_gt, p2_gt]);
        cwru_point = project(points(p, :), [fx_cwru(i), fy_cwru(i)], [cx_cwru(i), cy_cwru(i)], [k1_cwru(i), k2_cwru(i), k3_cwru(i), p1_cwru(i), p2_cwru(i)]);
        ind_point = project(points(p, :), [fx_ind(i), fy_ind(i)], [cx_ind(i), cy_ind(i)], [k1_ind(i), k2_ind(i), k3_ind(i), p1_ind(i), p2_ind(i)]);
%         if (i == 1)
%             scatter(reality_point(1), reality_point(2), [], "black");
%             scatter(cwru_point(1), cwru_point(2), [], "blue");
%             scatter(ind_point(1), ind_point(2), [], "red");
%         end
        total_dist_cwru = total_dist_cwru + norm(cwru_point - reality_point);
        total_dist_ind = total_dist_ind + norm(ind_point - reality_point);
    end
    avg_errs_ind(i) = total_dist_ind / 1000;
    avg_errs_cwru(i) = total_dist_cwru / 1000;
end

figure('Name', 'Average Errors');
hold on;
scatter3(s_cwru, n_cwru, avg_errs_cwru);
scatter3(s_ind,  n_ind,  avg_errs_ind);
hold off;
figure('Name', 'Average Error Wins');
avg_err_wins = reshape(avg_errs_ind < avg_errs_cwru, 19, 21);
imagesc([s_cwru(1) s_cwru(end)], [9024-n_cwru(end) 9024-n_cwru(1)], avg_err_wins * 100);
ylabel('Number of Points');