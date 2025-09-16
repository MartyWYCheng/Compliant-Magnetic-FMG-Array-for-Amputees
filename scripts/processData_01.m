clear all
load preset_train.mat

plot_remove_rest = false;
plot_PCA = false;

%% Create Time Vector
if preset == 0
    on_duration = 5;    
    off_duration = 3;   
    repetitions = 3;    
elseif preset == 0.5
    on_duration = 5;    
    off_duration = 3;   
    repetitions = 2;    
elseif preset == 1
    on_duration = 3;    
    off_duration = 2.5;   
    repetitions = 2;    
elseif preset == 2
    on_duration = 3;    
    off_duration = 2.5;   
    repetitions = 3;    
end

r = repetitions*2+1;

t_prompt = 0;
for i = 1:r+2
    if i == 1
        t_prompt(i) = off_duration;
    elseif preset == 4 && i == 2
        t_prompt(i) = t_prompt(i-1)+1;
    elseif rem(i,2) == 0
        t_prompt(i) = t_prompt(i-1) + on_duration;
    else
        t_prompt(i) = t_prompt(i-1) + off_duration;
    end
end


t_class = t_prompt;
t_class(1:2) = [];

values_prompt = 0; 
for i = 1:length(t_prompt)
    if i == 1
        values_prompt(i) = 10;
    elseif rem(i,2) == 0
        values_prompt(i) = 0;
    elseif i == length(t_prompt)
        values_prompt(i) = 0;
    else
        values_prompt(i) = 1;
    end
end

values_class = [1 0 1 0 1 0 1 0 1 0 0];
values_class = values_prompt;
values_class(1:2) = [];


offset = 0;
for i = 2:classes_amount
    offset(i) = offset(i-1) + t_class(end);
end

t_guide = [t_class(1:2) t_class(end)];

t_bias_start = t_prompt(1)+offset;
t_bias_end = t_prompt(2)+offset;


fprintf('Total TRIAL time: %1.2f\n', t_prompt(end)*classes_amount/60)

load train_full.mat
addpath('../../../scripts/functions')

%% Data Processing
%% Remove rest periods
if preset == 0
    [signals_reduced, classes_reduced, class_combined] = removeRest(FMG_train, 2500, 0);
elseif preset == 1 || preset ==1.5
    [signals_reduced, classes_reduced, class_combined] = removeRest(FMG_train, 1500, 0);
else
    [signals_reduced, classes_reduced, class_combined] = removeRest(FMG_train, 2500, 0);
end

addpath('replacements')
files = dir('replacements\*_train.mat');
replace_classes = [];

%% Replace gesture data
if isempty(files) ~= true
    replacement = {};
    for k = 1:length(files)
        baseFileName = files(k).name;
        replacement{end+1} = load(baseFileName);
        numberPart = regexp(extractBefore(baseFileName, '_train'), '[A-Za-z]*(\d+)', 'tokens');
        replace_classes = [replace_classes str2double(numberPart{1,1})]; 
    end

    for i = 1:length(replace_classes)
        fprintf("Choosing class %.f\n", replace_classes(i));
        signals_reduced = insertSignal(signals_reduced, classes_reduced, replacement{i}.FMG_replace, replace_classes(i), length(replace_classes), classes_amount, 2, 3, on_duration*1000/2, 0);
        fprintf("Replacing class %.f\n", replace_classes(i))
    end
end

%% Plot processed signal
if plot_remove_rest == true
    signals_combined = class_combined.*signals_reduced;
    figure;
    hold on;
    plot(signals_combined);
    plot(classes_reduced)
    ylim([min(signals_reduced,[],"all")+.10*min(signals_reduced,[],"all") max(signals_reduced,[],"all")+.10*max(signals_reduced,[],"all")])
    title("Total Signal")
end


%% PCA
clear i
coeff = pca(signals_reduced);
PC1 = abs(coeff(:,1));
[PC_sorted, i] = sort(PC1,'descend');

%plot
if plot_PCA == true
    figure
    subplot(2,1,1)
    bar(PC1);
    title("1st PCA Coeffs of Channels")
    subplot(2,1,2)
    bar(PC1(i));
    title("1st PCA Coeffs of Channels Descending")
    ylim([0 1]);
end

clear k
PCA_reduction_channels = {};
for j = 1:Channel_amount
    for k = 1:j
        signals_pca(:,k) = signals_reduced(:,i(k));
        channel_select = i(1:k);
    end
    PCA_reduction_channels{j} = signals_pca;
end

rmpath('replacements')
%rmpath('replacements\', '../../../scripts')
