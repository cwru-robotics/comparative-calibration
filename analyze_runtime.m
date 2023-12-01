% Cbar3 from https://stackoverflow.com/questions/45423394/how-to-set-arbitrary-colors-for-bars-in-a-3d-bar-plot
% project() function by me.

% ROS Industrial data processing.

cwru_set = csvread("DATA\cwru_runtime.csv");
ind_set = csvread("DATA\ind_runtime.csv");
zhang_set = csvread("DATA\zhang_runtime.csv");

n_cwru = cwru_set(:, 1);
n_ind = ind_set(:, 1) * 48;
n_zhang = zhang_set(:, 1);
runtime_cwru = flip(cwru_set(:, 3));
runtime_ind = flip(ind_set(:, 2));
runtime_zhang = flip(zhang_set(:, 2));

ax = axes;
hold on;
plot(runtime_cwru, 'b-');
plot(runtime_ind, 'r--');
plot(runtime_zhang, 'k:');
hold off;
legend
xlabel("Number of images");
ylabel("Runtime (seconds)");
set(gca, 'YScale', 'log')
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [10 4]);
set(gca, 'Position', get(gca, 'OuterPosition') - ...
    get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
fontname(ax, "Times New Roman");

% %Zhang's Algorithm data processing
% 
% % cwru_set = csvread("DATA\cwru_target_noise_proc.csv");
% % ind_set = csvread("DATA\zhang_noise_proc.csv");
% % xlabs = {'10','9','8','7','6','5','4','3','2','1','0'};
% % x_string = "Detection error \sigma (px)";
% % handle_offset = 1500;%Not sure why so much larger here.
% % handle_offset_2 = 1;
% % xoffset = 1;
% % cmap = [0.75 0 0; 0.25 1.0 0.25];
% 
% s_cwru = cwru_set(:, 2);
% s_ind = ind_set(:, 1);
% 
% n_cwru = cwru_set(:, 1);
% n_ind = ind_set(:, 2);
% 
% rms_cwru = cwru_set(:, 3);
% rms_ind = ind_set(:, 3);

% stated_fig = figure('Name', 'Nominal Reprojection Error');
% ax = axes;
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [5 4]);
% set(gca, 'Position', get(gca, 'OuterPosition') - ...
%     get(gca, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
% rms_wins = reshape(runtime_cwru, 19, 21);
% bar1 = Cbar3(rms_wins,int8(rms_wins>0),0);
% colormap(cmap);
% yticks(0:2:20);
% yticklabels({'0','20','40','60','80','100','120','140','160','180','200'});
% xticks(2:2:22);
% xticklabels(xlabs);
% zlabel("Relative Nominal Err. (px)");
% xlabel(x_string, "rotation", 22);
% ylabel("No. of Data Points", "rotation", -32);
% view(ax,141,30);
% fontname(ax, "Times New Roman");
% xlabelhandle = ax.XLabel;
% ylabelhandle = ax.YLabel;
% xlimits = xlim(ax);
% ylimits = ylim(ax);
% zlimits = zlim(ax);
% xmean = mean(xlimits);
% ymean = mean(ylimits);
% xbottom = xlimits(1);
% ybottom = ylimits(1);
% zbottom = zlimits(1);
% xlabelhandle.Position = [xmean - xoffset ybottom zbottom - handle_offset_2];
% %ylabelhandle.Position = [xbottom ymean zbottom];