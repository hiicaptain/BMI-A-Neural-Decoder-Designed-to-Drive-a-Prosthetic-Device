function [x, y, newModelParameters] = positionEstimator(test_data, modelParameters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if isempty(test_data.decodedHandPos)
        x=test_data.startHandPos(1);
        y=test_data.startHandPos(2);
%         angc=zeros(1,8);
        
    else
        x=test_data.decodedHandPos(1,end);
        y=test_data.decodedHandPos(2,end);
%         angc=modelParameters.angc;
    end
    real_ang=[30:40:230,310,350]/180*pi;
    spikes=test_data.spikes;
    regPre=modelParameters.regressionParameter;
    rate_probability=modelParameters.rate_probability;
    if (length(spikes)==320)
        prior=ones(1, 8)*1/8;
    else
        prior=modelParameters.prior;
    end
    [posterior,firingRate] = Bayesian_theorem(rate_probability, spikes ,prior);
%     if max(angc)>5
%         ang=modelParameters.lastang;
%     else
        [maxp,ang]=max(posterior);
%     end
    vel = VelPrediction( firingRate, regPre ,ang);
    vel_x=vel*cos(real_ang(ang));
    vel_y=vel*sin(real_ang(ang));
    dx=vel_x*20;
    dy=vel_y*20;
    x=x+dx;
    y=y+dy;
%     if not(isempty(test_data.decodedHandPos))
%         if modelParameters.lastang==ang
%             newModelParameters.angc(ang)=angc(ang)+1;
%         end
%     else
%         newModelParameters.angc=angc;
%         newModelParameters.angc(ang)=angc(ang)+1;
%     end
    newModelParameters.regressionParameter=regPre;
    newModelParameters.rate_probability=rate_probability;
    newModelParameters.prior=posterior;
%     newModelParameters.lastang=ang;

end

