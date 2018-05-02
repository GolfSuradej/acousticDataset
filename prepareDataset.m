%git@github.com:GolfSuradej/prepare-the-speech-with-IR-and-Noise-dataset.git

%% load signals
% speech signal
[x,Fs_ir] =audioread('t20101.wav');
%load speech signal
[xs,Fs_sp] =audioread('p306_010.wav');
%% upSampling IR from 44.1 to 48kS/s
Fs_ir = 44.1e3;
Fs_sp = 48e3;
[P,Q] = rat(Fs_sp/Fs_ir);
IRnew = resample(x,P,Q);
%% convolution 
ir_Signal = conv(xs,IRnew);
wav16 = ir_signal./(max(abs(ir_signal)));
filename = 'test_conv.wav';
audiowrite(filename,wav16,Fs_sp,'BitsPerSample',16,'Title','0dB-noise added by Mr.Suradej');
%% Adding Gaussian noise
noisySignal = awgn(signal,0,'measured'); %0dB SNR
wav16 = noisySignal./(max(abs(noisySignal)));
filename = 'test_0dB_norm.wav';%strcat(wavfilenames{i}(1:end-4),'_','0dB','.wav');
audiowrite(filename,wav16 ,Fs_sp,'BitsPerSample',16,'Title','0dB-noise added by Mr.Suradej');
%% Load wav-files
[xCov_re,Fs] =audioread('test_conv.wav');
[xNoisy_re,Fs] =audioread('test_0dB_norm.wav');