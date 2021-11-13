function EMD_for_all_time_series(window, time_frame, time_interval, pixel_size, TS)
% This function performs empirical mode decomposition (EMD) on all
% time series along a cell periphery, and plot the errorbar plot to reveal central frequencies, 
% and distribution of instantaneous frequency and amplitude
%
% Xiao Ma, 2017

%% EMD on all egde velocity time series
fs = 0.1; % fs is sampling frequency, a real number in Hz
specRes = 20; % specRes specifies the resolution of frequency
TS_rmNaN = TS;
TS_rmNaN(find(isnan(TS_rmNaN)==1)) = 0; % remove NaN values in the time series so that HHT can be performed

m=zeros(window,6); s=zeros(window,6);
instAmp_time_all = zeros(window,time_frame-1,6); 
instFreq_time_all = zeros(window,time_frame-1,6); 
for i=1:window
    [instAmp_time, instFreq_time, hht_time, imf_time] = hilbertHuangTransform(TS_rmNaN(i,:), fs, specRes);
    if size(instFreq_time,1) < 6
       for j = size(instFreq_time,1):6
           instAmp_time(j,:)=zeros(1,time_frame-1); instFreq_time(j,:)=zeros(1,time_frame-1);
       end
    end
    for k=1:6
        m(i,k)=mean(instFreq_time(k,:)); s(i,k)=std(instFreq_time(k,:));
        instAmp_time_all(i,:,k)=instAmp_time(k,:);
        instFreq_time_all(i,:,k)=instFreq_time(k,:);
    end
end
save instFreq_time_all.mat instFreq_time_all;
save instAmp_time_all.mat instAmp_time_all;


%% plot errorbar plot for all imfs frequency for each window
figure;
for i=1:window
    errorbar(m(i,:),s(i,:),'LineWidth',3);
    hold on;
end
xlabel('IMF number','FontSize',20);
ylabel('Frequency (Hz)','FontSize',20);
axis([0.5 6.5 0-0.005 fs/2+0.005]);
set(gca, 'XTick', [1:6], 'XTickLabel', [1:6]);
set(gca, 'FontSize', 20); 

%% plot histogram of instantaneous frequency and amplitude for all specific time series
n=25;
figure; 
for i=1:6
    instFreq_time_all_rs(i,:) = reshape(instFreq_time_all(:,:,i)', [1,window*(time_frame-1)]);
    subplot(6,1,i);
    hist(instFreq_time_all_rs(i,:),25);
    counts_instFreq_all(i,:) = hist(instFreq_time_all_rs(i,:),n);
    ylabel(strcat('IMF', num2str(i)), 'FontSize', 12);
    set(gca, 'XTick', [0 : 0.01: fs/2], 'XTickLabel', []);
    axis([0 fs/2 0 4000]);
    set(gca, 'YTick', [0 : 2000: 4000], 'YTickLabel', [0 : 2000: 4000]);
    set(gca, 'FontSize', 12);
end
set(gca, 'XTick', [0 : 0.01: fs/2], 'XTickLabel', [0 : 0.01: fs/2]);
xlabel('Frequency (Hz)','FontSize',12);
gtext('Histogram of instantaneous frequency', 'FontSize', 12, 'Rotation', 90, 'HorizontalAlignment', 'center');

figure;
for i=1:6
    instAmp_time_all_rs(i,:) = reshape(instAmp_time_all(:,:,i)', [1,window*(time_frame-1)]);
    subplot(6,1,i);
    hist(pixel_size/(time_interval/60) * instAmp_time_all_rs(i,:),n);
    counts_instAmp_all(i,:) = hist(pixel_size/(time_interval/60) * instAmp_time_all_rs(i,:),25);
    ylabel(strcat('IMF', num2str(i)), 'FontSize', 12);
    set(gca, 'XTick', [0 : 8], 'XTickLabel', []);
    axis([0 8 0 4000]);
    set(gca, 'YTick', [0 : 2000: 4000], 'YTickLabel', [0 : 2000: 4000]);
    set(gca, 'FontSize', 12);
end
set(gca, 'XTick', [0 : 8], 'XTickLabel', [0 : 8]);
xlabel('Amplitude(\mum/min)','FontSize',12);
gtext('Histogram of instantaneous amplitude', 'FontSize', 12, 'Rotation', 90, 'HorizontalAlignment', 'center');
