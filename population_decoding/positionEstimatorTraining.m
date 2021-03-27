function [ modelParameters ] = positionEstimatorTraining( training_data )
%POSITIONESTIMATORTRAINING Summary of this function goes here
%   Detailed explanation goes here
    modelParameters.regressionParameter=VelRegression(training_data);
    modelParameters.rate_probability = Compute_PRS(training_data);
%     save('modelParameters.mat');

end

