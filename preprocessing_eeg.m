function [eeg, labels] = preprocessing(data, labels0, freq, labels2remove, AM, fs, f_min, f_max)
    % Preprocessing function for EEG data
    % Elodie M Lopes, Brain group, INESC-TEC Porto, Oct/2020
    % (elodie.m.lopes@inesctec.pt)
    % This function processes raw EEG data by performing several operations:
    % 1. Channel removal (based on provided labels)
    % 2. Re-referencing (optional, based on average montage)
    % 3. Resampling of the data
    % 4. Bandpass filtering (using a 4th-order Butterworth filter)
    %
    % Inputs:
    %   - data: A matrix of EEG data (n_labels x n_samples), where rows represent channels
    %     and columns represent time samples.
    %   - labels0: A cell array of original channel labels corresponding to the rows in 'data'.
    %   - freq: The initial sampling frequency of the EEG data.
    %   - labels2remove: A cell array of labels (e.g., {'ECG','Fp1'}) that specifies which channels
    %     to remove from the data.
    %   - AM: A flag for average montage re-referencing. 
    %     - AM = 1: Re-reference the data to the average montage.
    %     - AM = 0: No re-referencing.
    %   - fs: The target frequency for resampling the data.
    %   - f_min: The lower bound of the frequency range for bandpass filtering.
    %   - f_max: The upper bound of the frequency range for bandpass filtering.
    %
    % Outputs:
    %   - eeg: The preprocessed EEG data after all steps.
    %   - labels: The updated channel labels after removing unwanted channels.

    %% Step 1: Remove channels specified in 'labels2remove'
    % Call a helper function to remove unwanted channels based on the provided labels.
    [data1, labels] = remove_channels(data, labels0, labels2remove);

    %% Step 2: Re-reference the data if requested (Average Montage)
    % If AM = 1, re-reference the data to the average montage by subtracting
    % the mean of the data across all channels for each sample.
    if AM == 1
        data2 = data1 - repmat(mean(data1, 1), [size(data1, 1), 1]);
    else
        data2 = data1;
    end

    %% Step 3: Resample the data to the target frequency 'fs'
    % If the data has more columns (samples) than rows (channels), transpose it
    % so that rows correspond to channels and columns to samples.
    if size(data2, 2) > size(data2, 1)
        data2 = data2';
    end

    % Resample the data to the target frequency 'fs' using MATLAB's resample function.
    data3 = resample(data2, fs, freq);
    
    % Transpose the data back to its original format (channels as rows and samples as columns)
    data3 = data3';

    %% Step 4: Apply Bandpass Filtering
    % Convert the data to double precision to ensure compatibility with filter function.
    data3 = double(data3);

    % Define filter parameters:
    Nth_order = 4;  % Filter order
    flag = 'bandpass';  % Filter type (bandpass filter)
    Wn = [f_min, f_max] / (fs / 2);  % Normalize the frequency range to Nyquist frequency

    % Design the Butterworth bandpass filter
    [B, A] = butter(Nth_order, Wn, flag);

    % Apply the bandpass filter to the data along the 2nd dimension (samples)
    data4 = filter(B, A, data3, [], 2);

    %% Step 5: Output the processed EEG data
    % Return the filtered data and the updated channel labels as output
    eeg = data4;

end
