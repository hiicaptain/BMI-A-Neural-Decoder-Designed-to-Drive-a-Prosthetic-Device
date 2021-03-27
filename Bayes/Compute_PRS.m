function  rate_probability = Compute_PRS(trials)
%%%%%%
% Input
% NAN or the trial data!!!
%%%%%%
%output
%the probability of different firing rate in different angle for all neurons: posterior(8 angles): rate_probability{98units, 8 angles} (probaility list)

trainingData = trials;

firingrate = [];
rate_frequency = zeros(1,1,1);
rate_probability = cell(size(trainingData(1,1).spikes,1),size(trainingData,2));

for neu_index=1:98
    for angle_index =1:8
        
         % calculate firing rate for each bins
         for trial_index = 1:size(trainingData,1)
            cycle_num = 1;
            bin_length = 20; % 20 ms bins
            for bin_index = 7:16
            spikes_onebin = trainingData(trial_index,angle_index).spikes(neu_index, (bin_length*(bin_index-1)+1):bin_length*bin_index);
            firingrate(trial_index, cycle_num) = sum(spikes_onebin)/bin_length;
            cycle_num = cycle_num + 1;
            end
            cycle_num = 0; 
         end

         % plot histogram, has been commented, just reshape
         All_firingrate = reshape(firingrate, [1, size(firingrate,1)*size(firingrate,2)]);
         %edges = [0:0.05:0.2];
         %histogram(All_firingrate, edges);
         
         % compute the frequency of each firing rate, disperse at 0.05 intervals
         bin_num = floor(max(All_firingrate)/0.05);
         for i = 1:bin_num+1
            rate_frequency(i, angle_index, neu_index) = size(find(All_firingrate==0.05*(i-1)),2);
         end
         % transfer number into probability
         rate_probability{neu_index, angle_index} = (rate_frequency(:,angle_index,neu_index)/sum(rate_frequency(:,angle_index,neu_index)))';

%      line Plot, has been commented
%      figure(neu_index)
%      x = [0:0.05:0.05*(size(rate_frequency(:,angle_index,neu_index),1)-1)];
%      plot(x, (rate_frequency(:,angle_index,neu_index))'); 
%      hold on;
    end
end


end
    
