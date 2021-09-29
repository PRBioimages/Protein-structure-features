function E=curve_feature(y)

%Wavelet transform
level=5;
[C,S]=wavedec2(y,level,'bior3.7');

E=zeros(1,level);
for i=1:level
    [H_i,unused.unused]=detcoef2('all',C,S,i);
    E(1,i)=norm(H_i,'fro');
end


%Frequency domain characteristics
Fs=5;
ys = fft(y);
ys(1)=mean(ys);
%Convert the abscissa and display it as frequency f= n*(fs/N)
f = (0:length(ys)-1)*Fs/length(ys);
% ys(1)=0;
% figure;
% subplot(2,1,1);
% plot(f,abs(ys));
% title('Magnitude');


% fft_phase = angle(ys);   %Phase frequency characteristics
% subplot(2,1,2);
% plot(f,fft_phase);
% title('Phase frequency characteristic diagram')


fft_amp=abs(ys);
N = length(fft_amp);
amp_max = max(fft_amp);     %Maximum amplitude
E=[E amp_max];
amp_min = min(fft_amp);     %Minimum amplitude
E=[E amp_min];
amp_median = median(fft_amp);   %Median amplitude
E=[E amp_median];
amp_mean = mean(fft_amp);       %Amplitude average
E=[E amp_mean];
amp_pk = amp_max - amp_min;     %Amplitude peak difference
E=[E amp_pk];
amp_mph = amp_pk * 0.75;           %Amplitude peak threshold, the threshold is 75% of the amplitude peak difference
%[amp_pkfs,amp_pks] = findpeaks(fft_amp,'minpeakheight',amp_mph);
%amp_pkfs = amp_pkfs / N * fs/2;
amp_pks = [];   %Peak amplitude
amp_pkfs = [];  %Frequency corresponding to peak amplitude
for i = 1:N
    if amp_mph < fft_amp(i)
        amp_pks = [amp_pks,fft_amp(i)];
        amp_pkfs = [amp_pkfs,i / N * Fs / 2];
    end
end
 
avg_fs = Fs*[1:N] / N;
avg_fft = 2 * fft_amp / N;
 
amp_fc = sum(avg_fs .* avg_fft) / sum(avg_fft);     %Center of gravity frequency
E=[E amp_fc];
amp_msf = sum(avg_fs.^2 .* avg_fft) / sum(avg_fft);    %Mean square frequency
E=[E amp_msf];
amp_rmsf = sqrt(amp_msf);   %Root mean square frequency
E=[E amp_rmsf];
amp_vf = sum((avg_fs - amp_fc).^2 .* avg_fft) / sum(avg_fft);  %Frequency variance
E=[E amp_vf];
amp_rvf = sqrt(amp_vf);     %Frequency standard deviation
E=[E amp_rvf];