function vel = VelPrediction( firingRate, Parameter ,ang)
%VELPREDICTION Summary of this function goes here
%   Detailed explanation goes here
    input=[1,firingRate]';
    vel= Parameter(ang,:)*input;

end

