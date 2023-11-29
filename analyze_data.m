% Cbar3 from https://stackoverflow.com/questions/45423394/how-to-set-arbitrary-colors-for-bars-in-a-3d-bar-plot
% project() function by me.

fx_gt = 534.0;
fy_gt = 534.0;
cx_gt = 309.0;
cy_gt = 238.0;
k1_gt = -0.1623;
k2_gt = 0.4;
k3_gt = -0.04;
p1_gt = -0.00154;
p2_gt = 0.0067;

% % ROS Industrial data processing.
% 
% % cwru_set = csvread("DATA\cwru_move_noise_proc.csv");
% % ind_set = csvread("DATA\ind_move_noise_proc.csv");
% % xlabs = {'10','9','8','7','6','5','4','3','2','1','0'};
% % x_string = "Target position error \sigma (mm)";
% % handle_offset = 37;
% % handle_offset_2 = 120;
% % xoffset = 1;
% % cmap = [0.75 0 0; 0.25 1.0 0.25];
% 
% % cwru_set = csvread("DATA\cwru_target_noise_proc.csv");
% % ind_set = csvread("DATA\ind_target_noise_proc.csv");
% % xlabs = {'10','9','8','7','6','5','4','3','2','1','0'};
% % x_string = "Detection error \sigma (px)";
% % handle_offset = 15;
% % handle_offset_2 = 45;
% % xoffset = 1;
% % cmap = [0.75 0 0; 0.25 1.0 0.25];
% 
% % cwru_set = csvread("DATA\cwru_move_scale_proc.csv");
% % ind_set = csvread("DATA\ind_move_scale_proc.csv");
% % x_string = "Target position mis-scaling (%)";
% % xlabs = {'110','108','106','104','102','100','98','96','94','92','90'};
% % handle_offset = 30;
% % handle_offset_2 = 180;
% % xoffset = 2;
% % cmap = [0.75 0 0; 0.25 1.0 0.25];
% 
% % cwru_set = csvread("DATA\cwru_target_scale_proc.csv");
% % ind_set = csvread("DATA\ind_target_scale_proc.csv");
% % x_string = "Target size mis-scaling (%)";
% % xlabs = {'110','108','106','104','102','100','98','96','94','92','90'};
% % handle_offset = 40;
% % handle_offset_2 = 80;
% % xoffset = 2;
% % cmap = [0.75 0 0; 0.25 1.0 0.25];
% 
% s_cwru = cwru_set(:, 2);
% s_ind = ind_set(:, 1);
% 
% n_cwru = cwru_set(:, 1);
% n_ind = ind_set(:, 2) * 48;
% 
% rms_cwru = cwru_set(:, 3);
% rms_ind = ind_set(:, 5);
% 
% fx_cwru = cwru_set(:, 4);
% fx_ind = ind_set(:, 7);
% fy_cwru = cwru_set(:, 5);
% fy_ind = ind_set(:, 11);
% 
% cx_cwru = cwru_set(:, 6);
% cx_ind = ind_set(:, 9);
% cy_cwru = cwru_set(:, 7);
% cy_ind = ind_set(:, 12);
% 
% k1_cwru = cwru_set(:, 8);
% k1_ind = ind_set(:, 17);
% k2_cwru = cwru_set(:, 9);
% k3_cwru = cwru_set(:, 10);
% p1_cwru = cwru_set(:, 11);
% p2_cwru = cwru_set(:, 12);
% k2_ind = ind_set(:, 18);
% k3_ind = ind_set(:, 19);
% p1_ind = ind_set(:, 20);
% p2_ind = ind_set(:, 21);

%Zhang's Algorithm data processing

% cwru_set = csvread("DATA\cwru_target_noise_proc.csv");
% ind_set = csvread("DATA\zhang_noise_proc.csv");
% xlabs = {'10','9','8','7','6','5','4','3','2','1','0'};
% x_string = "Detection error \sigma (px)";
% handle_offset = 1500;%Not sure why so much larger here.
% handle_offset_2 = 1;
% xoffset = 1;
% cmap = [0.75 0 0; 0.25 1.0 0.25];

cwru_set = csvread("DATA\cwru_target_scale_proc.csv");
ind_set = csvread("DATA\zhang_scale_proc.csv");
x_string = "Target size mis-scaling (%)";
xlabs = {'110','108','106','104','102','100','98','96','94','92','90'};
handle_offset = 22;
handle_offset_2 = 1; %There seems to be no rhyme or reason to the dimensions of these..
xoffset = 2;
cmap = [0.75 0 0; 0.75 0 0];%Not sure why this one graph won't colormap properly...

s_cwru = cwru_set(:, 2);
s_ind = ind_set(:, 1);

n_cwru = cwru_set(:, 1);
n_ind = ind_set(:, 2);

rms_cwru = cwru_set(:, 3);
rms_ind = ind_set(:, 3);

fx_cwru = cwru_set(:, 4);
fx_ind = ind_set(:, 9);
fy_cwru = cwru_set(:, 5);
fy_ind = ind_set(:, 9);

cx_cwru = cwru_set(:, 6);
cx_ind = ind_set(:, 11);
cy_cwru = cwru_set(:, 7);
cy_ind = ind_set(:, 15);

k1_cwru = cwru_set(:, 8);
k1_ind = ind_set(:, 4);
k2_cwru = cwru_set(:, 9);
k3_cwru = cwru_set(:, 10);
p1_cwru = cwru_set(:, 11);
p2_cwru = cwru_set(:, 12);
k2_ind = ind_set(:, 5);
k3_ind = ind_set(:, 8);
p1_ind = ind_set(:, 6);
p2_ind = ind_set(:, 7);

stated_fig = figure('Name', 'Nominal Reprojection Error');
ax = axes;
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [5 4]);
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
rms_wins = reshape(rms_ind - rms_cwru, 19, 21);
bar1 = Cbar3(rms_wins,int8(rms_wins>0),0);
colormap(cmap);
yticks(0:2:20);
yticklabels({'0','20','40','60','80','100','120','140','160','180','200'});
xticks(2:2:22);
xticklabels(xlabs);
zlabel("Relative Nominal Err. (px)");
xlabel(x_string, "rotation", 22);
ylabel("No. of Data Points", "rotation", -32);
view(ax,141,30);
fontname(ax, "Times New Roman");
xlabelhandle = ax.XLabel;
ylabelhandle = ax.YLabel;
xlimits = xlim(ax);
ylimits = ylim(ax);
zlimits = zlim(ax);
xmean = mean(xlimits);
ymean = mean(ylimits);
xbottom = xlimits(1);
ybottom = ylimits(1);
zbottom = zlimits(1);
xlabelhandle.Position = [xmean - xoffset ybottom zbottom - handle_offset_2];
%ylabelhandle.Position = [xbottom ymean zbottom];

points = rand(1000, 3);
points(:, 1) = points(:, 1) - 0.5;
points(:, 2) = points(:, 2) - 0.5;
points(:, 3) = points(:, 3) + 0.5;
%scatter3(points(:, 1), points(:, 2), points(:, 3));
avg_errs_ind = nan(size(s_ind, 1), 1);
avg_errs_cwru = nan(size(s_cwru, 1), 1);

for i = 1 : size(s_ind, 1)
    total_dist_ind = 0;
    total_dist_cwru = 0;
    for p = 1 : 1000
        reality_point = project(points(p, :), [fx_gt, fy_gt], [cx_gt, cy_gt], [k1_gt, k2_gt, k3_gt, p1_gt, p2_gt]);
        cwru_point = project(points(p, :), [fx_cwru(i), fy_cwru(i)], [cx_cwru(i), cy_cwru(i)], [k1_cwru(i), k2_cwru(i), k3_cwru(i), p1_cwru(i), p2_cwru(i)]);
        ind_point = project(points(p, :), [fx_ind(i), fy_ind(i)], [cx_ind(i), cy_ind(i)], [k1_ind(i), k2_ind(i), k3_ind(i), p1_ind(i), p2_ind(i)]);
        total_dist_cwru = total_dist_cwru + norm(cwru_point - reality_point);
        total_dist_ind = total_dist_ind + norm(ind_point - reality_point);
    end
    avg_errs_ind(i) = total_dist_ind / 1000;
    avg_errs_cwru(i) = total_dist_cwru / 1000;
end
real_fig = figure('Name', 'Actual Reprojection Error');
ax = axes;
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [5 4]);
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
are_wins = reshape(avg_errs_ind - avg_errs_cwru, 19, 21);
bar2 = Cbar3(are_wins,int8(are_wins>0),0);
colormap([0.75 0 0; 0.25 1.0 0.25]);
yticks(0:2:20);
yticklabels({'0','8','28','48','68','88','108','128','148','168','188'});
xticks(2:2:22);
xticklabels(xlabs);
zlabel("Relative Actual Err. (px)");
xlabel(x_string, "rotation", 22);
ylabel("No. of Data Points", "rotation", -32);
view(ax,141,30);
fontname(ax, "Times New Roman");
xlabelhandle = ax.XLabel;
ylabelhandle = ax.YLabel;
xlimits = xlim(ax);
ylimits = ylim(ax);
zlimits = zlim(ax);
xmean = mean(xlimits);
ymean = mean(ylimits);
xbottom = xlimits(1);
ybottom = ylimits(1);
zbottom = zlimits(1);
xlabelhandle.Position = [xmean - xoffset ybottom zbottom - handle_offset];
%ylabelhandle.Position = [xbottom ymean zbottom];