function [data2, labels2] = remove_channels(data, labels, labels2remove)
    % remove_channels - Removes specified EEG channels from the data.
    %
    % This function takes an EEG dataset and removes specified channels based on the labels.
    % The function searches for the channels to be removed by matching channel names in the
    % `labels2remove` array with the `labels` array. It then removes the corresponding rows
    % from the `data` matrix and updates the `labels` array accordingly.
    %
    % Author: Elodie Lopes (elodie.m.lopes@inesctec.pt) @BrainGroup - INESC TEC, Porto, Portugal
    %
    % Inputs:
    %   - data: A matrix of EEG data (n_labels x n_samples), where each row represents a channel,
    %     and each column represents a time sample.
    %   - labels: A cell array containing the names of the EEG channels corresponding to the rows in 'data'.
    %   - labels2remove: A cell array of channel labels to be removed from the `data`. For example,
    %     labels2remove = {'ECG', 'Fp1'} would remove the 'ECG' and 'Fp1' channels from the data.
    %
    % Outputs:
    %   - data2: The EEG data matrix after removing the specified channels.
    %   - labels2: The updated labels cell array after removing the specified channels.
    %
    % Example:
    %   [cleaned_data, updated_labels] = remove_channels(data, labels, {'ECG', 'Fp1'});
    %   This will remove 'ECG' and 'Fp1' channels from the EEG data.

    %% Initialize an empty array to store indices of channels to remove
    index2 = [];  % List of indices of channels to be removed

    %% Step 1: Identify channels to remove
    % Loop through each channel name in labels2remove and find its index in the 'labels' array.
    for i = 1:length(labels2remove)
        % Use strcmp to compare channel names and find matches
        index = strcmp(labels, labels2remove{i});

        % Collect indices where the channel labels match
        index2 = [index2 find(index == 1)];
    end

    %% Step 2: Remove the identified channels
    % Remove the channels from the 'labels' array using the identified indices.
    labels(:, index2) = [];  % Delete the labels of the channels to be removed

    % Remove the corresponding rows from the 'data' matrix
    data(index2, :) = [];  % Remove the rows of EEG data corresponding to the channels to be removed

    %% Step 3: Output the cleaned data and labels
    % Return the updated data and labels
    data2 = data;   % Updated EEG data after removal of specified channels
    labels2 = labels;  % Updated list of labels after removal

end
