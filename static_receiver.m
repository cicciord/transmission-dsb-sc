% static_receiver.m Simulation in case of static receiver (no need for PLL)
modulator;

%% TRANSMISSION CHANNEL
tau = D / c;             % propagation delay
phi = 2 * pi * Fc * tau; % phase delay
phi = mod(phi, 2*pi);    % removing 2*pi multiples

Phi = PhTX - phi;     % total phase shift
Phi = mod(Phi, 2*pi); % removing 2pi multiples

xRX = xTX * exp(-1j * phi); % received signal complex envelope

%% DEMODULATION
% demodulation with phase correction
xiRX = real(xRX * exp(-1j * Phi)) - Ac;
xqRX = real(xRX * exp(-1j * (Phi - pi/2)));

%% PLOT
% received signal
figure;
subplot(2, 1, 1);
plot(t, real(xRX));
title("Received Complex Envelope");
xlabel("time [s]");
ylabel("amplitude");
grid on;

subplot(2, 1, 2);
plot(f, abs(fftshift(fft(xRX))));
title("Received Complex Envelope Spectrum");
xlabel("frequency [Hz]");
ylabel("magnitude");
grid on;
xline(-Fs/2, "red");
xline(Fs/2, "red");
legend("", "Bandwidth");

% demodulated signals
figure;
subplot(3, 1, 1);
plot(t, xiRX);
title("Demodulated Left Signal");
xlabel("time [s]");
ylabel("amplitude");
ylim([-1 1]);
grid on;

subplot(3, 1, 2);
plot(t, xqRX);
title("Demodulated Right Signal");
xlabel("time [s]");
ylabel("amplitude");
ylim([-1 1]);
grid on;

subplot(3, 1, 3)
plot(t, xi - xiRX);
title("Error");
xlabel("time [s]");
ylabel("amplitude");
grid on;
hold on;
plot(t, xq - xqRX, "red");
legend("In-phase signal", "Quadrature signal");
ylim([-0.5 1]);
