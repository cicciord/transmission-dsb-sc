% modulator.m DSB-SC modulation
close all;
clear;
clc;
config;

%% SUPPRESSED CARRIER AMPLITUDE
xi_p = mean(xi.^2); % power left signal
xq_p = mean(xq.^2); % power right signal

% computing the suppressed carrier power to be alpha dB less then the sum
% of the power of xi and xq
sc_p = 10^((10*log10(xi_p + xq_p) - alpha) / 10); % suppressed carrier power

Ac = sqrt(2 * sc_p); % suppressed carrier amplitude

%% DSB-SC MODULATION
% complex envelope of signal
xTX = ((Ac + xi) - 1j * xq) * exp(1j * PhTX);

% complex envelope spectrum
XTX = fftshift(fft(xTX));

% complex envelope power spectral density
XTX_p = 2 * abs(XTX(length(XTX)/2+1:end)).^2 / (Fs * length(XTX));

%% PLOTS
% audio signals
figure;
subplot(2, 1, 1);
plot(t, xi);
title("Left Audio Channel");
xlabel("time [s]");
ylabel("amplitude");
ylim([-1 1]);
grid on;

subplot(2, 1, 2);
plot(t, xq);
title("Right Audio Channel");
xlabel("time [s]");
ylabel("amplitude");
ylim([-1 1]);
grid on;

% complex envelope time domain
figure;
subplot(1, 4, [1 2 3]);
plot(t, real(xTX));
yline(real(Ac * exp(1j * PhTX)), "red", "LineWidth", 2);
title("Modulated Signal Complex Envelope");
xlabel("time [s]");
ylabel("amplitude");
legend("Modulated Signal", "Suppressed Carrier Component");
grid on;

subplot(1, 4, 4);
plot(t, real(xTX));
yline(real(Ac * exp(1j * PhTX)), "red", "LineWidth", 2);
xlabel("time [s]");
ylabel("amplitude");
axis([3 3.1 -2*Ac 2*Ac]);
grid on;

% complex envelope frequency spectrum
figure;
subplot(2, 4, [1 2 3]);
plot(f, abs(XTX));
title("Complex Envelope Frequency Spectrum");
xlabel("frequency [Hz]");
ylabel("magnitude");
grid on;
xline(Fs/2, "red");
xline(-Fs/2, "red");
legend("", "Bandwidth");

subplot(2, 4, 4);
plot(f, abs(XTX));
xlabel("frequency [Hz]");
ylabel("magnitude");
xlim([-100 100]);
grid on;

subplot(2, 4, [5 6 7 8])
semilogx(f(length(f)/2+1:end), 10*log10(XTX_p));
xline(Fs/2, "red", "LineWidth", 2);
title("Complex Envelope PSD");
xlabel("frequency [Hz]");
ylabel("power density [dB/Hz]");
legend("", "Bandwidth");
grid on;
