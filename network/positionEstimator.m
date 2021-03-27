function [x, y, newModelParameters] = positionEstimator(test_data, modelParameters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    net=modelParameters.net;
    spike=test_data.spikes;
    firing_Rate=[];
    for n=1:98
    	firing_Rate(n,1)=sum(spike(n,end-60+1:end-20));
    end
    if isempty(test_data.decodedHandPos)
        x=test_data.startHandPos(1);
        y=test_data.startHandPos(2);
        for n = 1:1:98
            fr(n,1)=sum(spike(n,71:320))/20;
        end
        netinput={fr};%reshape(spike(:,end-240+1:end),[98,240,1,1]);
        [ma,ang] = max(predict(net,netinput));
        firing_Rate(99,1)=x;
        firing_Rate(100,1)=y;
        firing_Rate(101,1)=x;
        firing_Rate(102,1)=y;
    else
        x=test_data.decodedHandPos(1,end);
        y=test_data.decodedHandPos(2,end);
        ang=modelParameters.ang;
        if size(test_data.decodedHandPos,2)==1
            firing_Rate(99,1)=test_data.startHandPos(1);
            firing_Rate(100,1)=test_data.startHandPos(2);
            firing_Rate(101,1)=test_data.startHandPos(1);
            firing_Rate(102,1)=test_data.startHandPos(2);
        else
            if size(test_data.decodedHandPos,2)==2
                firing_Rate(99,1)=test_data.startHandPos(1);
                firing_Rate(100,1)=test_data.startHandPos(2);
                firing_Rate(101,1)=test_data.decodedHandPos(1,end-1);
                firing_Rate(102,1)=test_data.decodedHandPos(2,end-1);
            else
                firing_Rate(99,1)=test_data.decodedHandPos(1,end-2);
                firing_Rate(100,1)=test_data.decodedHandPos(2,end-2);
                firing_Rate(101,1)=test_data.decodedHandPos(1,end-1);
                firing_Rate(102,1)=test_data.decodedHandPos(2,end-1);
            end
        end
    end
%     net_ang=reshape(modelParameters.net_reg(ang,:,:),[2,100]);
    firing_Rate(103,1)=x;
    firing_Rate(104,1)=y;
    firing_Rate(105,1)=1;
%     dxy=net_ang*firing_Rate;
    dx=modelParameters.net_reg(ang,:,1)*firing_Rate;
    dy=modelParameters.net_reg(ang,:,2)*firing_Rate;
    x=dx;
    y=dy;
    newModelParameters.ang=ang;
    newModelParameters.net=net;
    newModelParameters.net_reg=modelParameters.net_reg;
end

