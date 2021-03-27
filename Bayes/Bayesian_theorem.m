function  [posterior,firing_rate] = Bayesian_theorem(rate_probability, neuron_spikes ,prior)
%%%%%%
% Input
% firing rate and probability curve: rate_probability{98units, 8 angles} (probaility list)
% new 20 ms data+new data: past_current_trial.spikes(:,1:t) 
%prior probability: prior(8 angles)
%%%%%%
%output
%posterior probability: posterior(8 angles)

likelihood = ones(1, 8);
firing_rate = zeros(1, 98);
posterior = zeros(1, 8);

for neuron_index = 1:1:98
    firing_rate(neuron_index) = sum(neuron_spikes(neuron_index,end-20:end))/20;
end

for angle_index = 1:1:8
    for neuron_index = 1:1:98
        % determine the x coordinate of the firing rate of new 20 ms in the probability plot
        probability_list_len = length(rate_probability{neuron_index, angle_index});
        firing_rate_index =  floor(firing_rate(neuron_index)/0.05)+1;
        if firing_rate_index>probability_list_len %firing rate of new data never appeared in the past trials.
            likelihood(angle_index) = likelihood(angle_index) * 0.01;
        else
            likelihood(angle_index) = likelihood(angle_index) * rate_probability{neuron_index, angle_index}(firing_rate_index);
        end
    posterior(angle_index) =  likelihood(angle_index) * prior(angle_index);
    end
end

posterior = posterior / sum(posterior);
    

end



