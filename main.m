%% Initialization 
clear all;

%% Load the protrusion velocity sturcture and assign average velocity matrix
load('protrusion_samples.mat');
TS = protSamples.avgNormal;

%% Acquire size info of the average protrusion velocity matrix
window = size(TS,1);
time_frame = size(TS,2);

%% Set generic paramters
time_interval = 10; % unit: s. You can define your own value
pixel_size = 0.3225; % unit: um. You can define your own value

%% Plot protrusion activity map
plot_protrusion_map(window, time_frame, time_interval, pixel_size, TS);

%% Perform EMD analysis on an example time series at the specific sector
EMD_for_example_time_series_at_specific_sector(time_frame, time_interval, pixel_size, TS);

%% Perform EMD analysis on on all time series along a cell periphery
EMD_for_all_time_series(window, time_frame, time_interval, pixel_size, TS);