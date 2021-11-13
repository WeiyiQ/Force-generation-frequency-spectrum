function EMD_for_example_time_series_at_specific_sector(time_frame, time_interval, pixel_size, TS)
% This function performs empirical mode decomposition (EMD) on an 
% example time series at a specfic sector, and plot the original time series, 
% the docomposed IMFs, and distribution of instantaneous frequency and amplitude
%
% Xiao Ma, 2017

%% plot a specific edge velocity curve
wp = 30; % select any specific window in the range 
figure, plot(time_interval/60 * (0 : time_frame-1), pixel_size/(time_interval/60) * TS(wp,:), 'LineWidth', 5);
xlabel('Time (min)', 'FontSize', 20);
ylabel('Edge velocity (\mum/min)', 'FontSize', 20);
axis([0 time_interval/60 * (time_frame-1) -10 10]);
set(gca, 'fontsize', 20);

%% EMD on the specific egde velocity time series
fs = 0.1; % fs is sampling frequency, a real number in Hz
specRes = 20; % specRes specifies the resolution of frequency
TS_rmNaN = TS;
TS_rmNaN(find(isnan(TS_rmNaN)==1)) = 0; % remove NaN values in the time series so that HHT can be performed
[instAmp_wp, instFreq_wp, hht_wp, imf_wp] = hilbertHuangTransform(TS_rmNaN(wp,:), fs, specRes);

%% plot each imf
figure;
for i=1:6
    subplot(6,1,i);
    plot(time_interval/60 * (0 : time_frame-1), pixel_size/(time_interval/60) * imf_wp(i,:), 'LineWidth', 3);
    set(gca, 'XTick', [0 : 1/6 * time_interval/60 * (time_frame-1) : time_interval/60 * (time_frame-1)], 'XTickLabel', []);
    ylabel(strcat('IMF', num2str(i)), 'FontSize', 15);
    axis([0 time_interval/60 * (time_frame-1) -10 10]);
    set(gca, 'fontsize', 15);
end
set(gca, 'XTick', [0 : 1/6 * time_interval/60 * (time_frame-1) : time_interval/60 * (time_frame-1)], 'XTickLabel', [0 : 1/6 * time_interval/60 * (time_frame-1) : time_interval/60 * (time_frame-1)]);
xlabel('Time (min)', 'FontSize', 15);
gtext('Edge velocity (\mum/min)', 'FontSize', 15, 'Rotation', 90, 'HorizontalAlignment', 'center');

%% plot histogram of instantaneous frequency and amplitude for the specific time series
n=25;
figure; 
for i=1:6
    subplot(6,1,i);
    hist(instFreq_wp(i,:),25);
    counts_instFreq_wp(i,:) = hist(instFreq_wp(i,:),n);
    ylabel(strcat('IMF', num2str(i)), 'FontSize', 12);
    set(gca, 'XTick', [0 : 0.01: fs/2], 'XTickLabel', []);
    axis([0 fs/2 0 20]);
    set(gca, 'FontSize', 12);
end
set(gca, 'XTick', [0 : 0.01: fs/2], 'XTickLabel', [0 : 0.01: fs/2]);
xlabel('Frequency (Hz)','FontSize',12);
gtext('Histogram of instantaneous frequency', 'FontSize', 12, 'Rotation', 90, 'HorizontalAlignment', 'center');

figure;
for i=1:6
    subplot(6,1,i);
    hist(pixel_size/(time_interval/60) * instAmp_wp(i,:),n);
    counts_instAmp_wp(i,:) = hist(pixel_size/(time_interval/60) * instAmp_wp(i,:),25);
    ylabel(strcat('IMF', num2str(i)), 'FontSize', 12);
    set(gca, 'XTick', [0 : 8], 'XTickLabel', []);
    axis([0 8 0 20]);
    set(gca, 'FontSize', 12);
end
set(gca, 'XTick', [0 : 8], 'XTickLabel', [0 : 8]);
xlabel('Amplitude(\mum/min)','FontSize',12);
gtext('Histogram of instantaneous amplitude', 'FontSize', 12, 'Rotation', 90, 'HorizontalAlignment', 'center');