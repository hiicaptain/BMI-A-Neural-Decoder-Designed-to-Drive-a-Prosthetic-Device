function [xTrain_r,yTrain_r] = velocity_data(training_data, ang)
%VELOCITY_DATA Summary of this function goes here
%   Detailed explanation goes here
    xTrain_r=[];
    yTrain_r=[];
    for trail=1:size(training_data,1)
        firingRate =[];
        fr=[];
        dxy_t=[];
        spike=training_data(trail,ang).spikes;
        x=training_data(trail,ang).handPos(1,:);
        y=training_data(trail,ang).handPos(2,:);
        for time = 320:20:size(spike,2)
            for n = 1:1:98
                fr(n,time/20-15)=sum(spike(n,time-60+1:time-20));
            end
            if time ==320
                dx=x(time);
                dy=y(time);
                fr(99,time/20-15)=x(1);
                fr(100,time/20-15)=y(1);
                fr(101,time/20-15)=x(1);
                fr(102,time/20-15)=y(1);
                fr(103,time/20-15)=x(1);
                fr(104,time/20-15)=y(1);
            else
                dx=x(time);
                dy=y(time);
                fr(99,time/20-15)=x(time-60);
                fr(100,time/20-15)=y(time-60);
                fr(101,time/20-15)=x(time-40);
                fr(102,time/20-15)=y(time-40);
                fr(103,time/20-15)=x(time-20);
                fr(104,time/20-15)=y(time-20);
            end
            fr(105,time/20-15)=1;
            dxy=[dx;dy];
            dxy_t=cat(2,dxy_t,dxy);
        end
        xTrain_r=cat(2,xTrain_r,fr);
        yTrain_r=cat(2,yTrain_r,dxy_t);
    end
end

