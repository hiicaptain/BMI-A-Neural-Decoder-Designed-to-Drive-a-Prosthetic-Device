function [dx,dy] = VelPrediction( firingRate, Parameter ,ang)
%VELPREDICTION Summary of this function goes here
%   Detailed explanation goes here
    input=[1,firingRate]';
    dx = Parameter(ang,:,1)*input*20;
    dy = Parameter(ang,:,2)*input*20;

end

