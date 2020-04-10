function [] = demodulate_ltc_audio(audio_file, out_file)

    [data, fs] = audioread(audio_file);
    NSAMPSPERBIT = 80;
    BUFFER = 3;

    % Write the binarized channels to disk
    file_handle = fopen(out_file, 'w');

    for channel_idx = 1:size(data, 2)
        channel = data(:,channel_idx);

        % Starting idx
        [m, idmin] = min(channel(1:NSAMPSPERBIT));
        [m, idmax] = max(channel(1:NSAMPSPERBIT));
        idx = min(idmin, idmax);

        demodulated = [];

        while idx < size(data, 1)-NSAMPSPERBIT
            % Check for sign at samples 20 and 60 in the period
            bit = ~isequal(sign(channel(idx+20)), sign(channel(idx+60)));
            demodulated = [demodulated, bit];
            % Find the peak within a tolerance of 6 samples
            [m, idt] = max(abs(channel(idx+77:idx+83)));
            idx = idx + 77 + idt - 1;
        end

        % Convert to string and write to disk
        demodulated_str = num2str(demodulated, '%d');
        fprintf(file_handle, '%s\n', demodulated_str);

        % Sanity check that the frame numbers are the same - python code
        % Find the location of the sync words
        % pattern = '0011111111111101';
        % strfind(demodulated_str, pattern)
    end

    % Close the file handle
    fclose(file_handle);

