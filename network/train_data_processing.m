function [xTrain,yTrain] = train_data_processing(training_data)
%TRAIN_DATA_PROCESSING Summary of this function goes here
%   Detailed explanation goes here
%% COULD CHANGE AS NOT PROVIDE LAST PREDICTION, PROVIDE SEQUENCE OF DXY
xTrain=[];
yTrain=[];
for ang=1:8
    for trail=1:size(training_data,1)
        firingRate =[];
        spike=training_data(trail,ang).spikes;
        for n = 1:1:98
            firingRate(n,1)=sum(spike(n,71:320))/20;
        end
        xTrain=cat(1,xTrain,{firingRate});
        angc=categorical(ang);
        yTrain=cat(2,yTrain,angc);
    end
end
end


