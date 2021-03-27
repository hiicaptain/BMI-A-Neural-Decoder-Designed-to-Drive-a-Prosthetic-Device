function [ parameter] = VelRegression( training_data)
%VELREGRESSION Summary of this function goes here
%   Detailed explanation goes here
%% velcoity calculation
dt=20;
for ang = 1:8
    velAr=[];
    for neuron_no = 1:98
        firingRates = [];
        for n = 1:length(training_data)
            spike_rate = [];
            for t = 300:dt:560-dt
                
                % find the firing rates of one neural unit for one trial
                number_of_spikes = length(find(training_data(n,ang).spikes(neuron_no,t:t+dt)==1));
                spike_rate = cat(2, spike_rate, number_of_spikes/dt);
                
                % find the velocity of the hand movement
                % (needs calculating just once for each trial)
                if neuron_no==1
                    x_low = training_data(n,ang).handPos(1,t);
                    x_high = training_data(n,ang).handPos(1,t+dt);
                    
                    y_low = training_data(n,ang).handPos(2,t);
                    y_high = training_data(n,ang).handPos(2,t+dt);
                    
                    x_vel = (x_high - x_low) / dt;
                    y_vel = (y_high - y_low) / dt;
                    velocity = x_vel^2+ y_vel^2;
                    velAr=[velAr,velocity];
                end
                
            end
            
            % store firing rate of one neural unit for every trial in one array
            firingRates = cat(2, firingRates, spike_rate);
            
        end
        
        trainingData(neuron_no,ang).firingRates = firingRates;
        vel(ang,:) = velAr;
        
    end
end
%% velocity regression
for ang=1:8
    velocity = vel(ang,:);
    firingRate = [];
    for i=1:98
    firingRate = cat(1, firingRate, trainingData(i,ang).firingRates);
    end
    input = cat(2,ones(size(firingRate,2),1),firingRate'); 
    para=lsqminnorm(input,velocity');
%     para=input\velocity';
    
    parameter(ang,:)=para;
end

end

