function [signals_reduced, classes_reduced, class_combined] = remove_rest(data, beginning, ending)
    
    signals = get(data,"nnOut_vec").Values.Data;
    classes = get(data,"classes").Values.Data;
    
    class_combined = sum(classes,2); %classes is matrix of classes(column) with respect to trial time, combines all columns into one
    combined_class_deriv = diff(class_combined);
    [PKS,LOC_r] = findpeaks(combined_class_deriv,'minpeakheight', 0.5);  %finds rising edges
    LOC_f = find(combined_class_deriv == -1);
    
    signals_reduced = signals;
    classes_reduced = classes;
    
    signals_reduced((LOC_f(length(LOC_f)):length(signals_reduced)),:) = 0;    %remove end
    classes_reduced((LOC_f(length(LOC_f)):length(classes_reduced)),:) = 0;
    class_combined((LOC_f(length(LOC_f)):length(class_combined)),:) = 0;
        
    for i = length(LOC_f):-1:2
        signals_reduced(LOC_f(i)-ending:LOC_f(i),:) = [];
        signals_reduced(LOC_f(i-1):LOC_r(i)+beginning,:) = [];    %edit this, break time then how much of beginning of class to remove
        classes_reduced(LOC_f(i)-ending:LOC_f(i),:) = [];
        classes_reduced(LOC_f(i-1):LOC_r(i)+beginning,:) = [];
        class_combined(LOC_f(i)-ending:LOC_f(i),:) = [];
        class_combined(LOC_f(i-1):LOC_r(i)+beginning,:) = [];
    end
        
    signals_reduced(1:LOC_r(1)+beginning,:) = [];    %remove beginning
    classes_reduced(1:LOC_r(1)+beginning,:) = [];
    class_combined(1:LOC_r(1)+beginning,:) = [];
    
    
    combined_class_deriv_new = diff(class_combined);
    LOC_f_new = find(combined_class_deriv_new == -1);
    signals_reduced(LOC_f_new(end):end,:) = [];    %remove end
    classes_reduced(LOC_f_new(end):end,:) = [];
    class_combined(LOC_f_new(end):end,:) = [];
    
end 


