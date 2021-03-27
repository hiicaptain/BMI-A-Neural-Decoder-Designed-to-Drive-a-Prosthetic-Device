function [ modelParameters ] = positionEstimatorTraining( training_data )
%POSITIONESTIMATORTRAINING Summary of this function goes here
%   Detailed explanation goes here
%     parpool('local',4);
    [xTrain,yTrain] = train_data_processing(training_data);
    layers_classifier = [
        sequenceInputLayer(98,"Name","sequence")
        lstmLayer(64,"Name","lstm","OutputMode","last")
        fullyConnectedLayer(64,"Name","fc_1")
        reluLayer("Name","relu_2")
%         fullyConnectedLayer(64,"Name","fc_2")
%         reluLayer("Name","relu_3")
        fullyConnectedLayer(8,"Name","fc_3")
        softmaxLayer("Name","softmax")
        classificationLayer("Name","classoutput")];
    
    miniBatchSize  = 50;
    options_classifier = trainingOptions('adam', ...
        'MiniBatchSize',miniBatchSize, ...
        'MaxEpochs',50, ...
        'InitialLearnRate',0.1, ...
        'LearnRateSchedule','piecewise',...
        'LearnRateDropFactor',0.1, ...
        'LearnRateDropPeriod',10, ...
        'Shuffle','every-epoch', ...
        'Verbose',false);
% validationFrequency = floor(numel(yTrain)/miniBatchSize);
    
    modelParameters.net = trainNetwork(xTrain,yTrain',layers_classifier,options_classifier);
    for ang=1:8
        [xTrain_r,yTrain_r] = velocity_data(training_data,ang);
        modelParameters.net_reg(ang,:,:) = lsqminnorm(xTrain_r',yTrain_r');
    end
end

