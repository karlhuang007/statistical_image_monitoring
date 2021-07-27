Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
S = sin(2*pi*5*t) + sin(2*pi*10*t)+sin(2*pi*20*t)+sin(2*pi*30*t);
plot(1000*t(1:50),S(1:50))
title('Sinusoidal signal signal with 5Hz,10Hz,20Hz,30Hz')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f,P1);
title('Amplitude Spectrum of signal with 5Hz,10Hz,20Hz,30Hz')
xlabel('f (Hz)')
ylabel('Amplitude')

% cwt(S,Fs);