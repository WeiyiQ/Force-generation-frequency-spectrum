function plot_protrusion_map(window, time_frame, time_interval, pixel_size, TS)
% This function plots the protrusion activity map based on 
% average protrusion velocity data
%
% Xiao Ma, 2017

figure, imagesc(time_interval/60 * (0 : time_frame-1), 1 : window, pixel_size/(time_interval/60) * TS); 
axis xy;
colormap(jet);
colorbar;
xlabel('Time (min)', 'FontSize', 20);
ylabel('Sector number', 'FontSize', 20);
ylabel(colorbar, 'Edge velocity (\mum/min)', 'FontSize', 20); 
caxis([-10 10]);
set(gca, 'fontsize', 20);
