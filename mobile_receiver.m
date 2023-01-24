% mobile_receiver.m
% Simulation in case of mobile receiver
%% PROPAGATION CHANNEL
modulator;
propagation_channel;

%% RECEIVED SIGNAL
phi = mod(phi, 2*pi);
xRX = xTX .* exp(-1j * phi);

%% PURE CARRIER EXTRACTION
% filter design
bw = 20; % filter bandwidth
H = (abs(f) < bw) * 1;

XRX = fftshift(fft(xRX)); % fft of received signal

% filtering received signal
Pc = XRX .* H;
pc = ifft(fftshift(Pc));

%% OPTIMIZE GAMMA
gamma_min = 0.1;
gamma_max = 4;
gamma_num = 100;
Dgamma = (gamma_max - gamma_min)/gamma_num;
gamma_sweep = gamma_min : Dgamma : gamma_max - Dgamma;
SNR_i = zeros(length(gamma_sweep)-20000, 1);
SNR_q = zeros(length(gamma_sweep)-20000, 1);
n = 1;
for gamma = gamma_sweep
    [~, pll, ~, ~] = compute_pll(gamma, pc);
    xRX_pll = xRX .* pll;

    xiRX = real(xRX_pll) - Ac;
    xqRX = real(xRX_pll * exp(1j * pi/2));

    SNR_i(n) = xi_p / (mean((xi(20000:end) - xiRX(20000:end)).^2));
    SNR_q(n) = xq_p / (mean((xq(20000:end) - xqRX(20000:end)).^2));
    n = n + 1;
end
clear n;

[~, i] = max(SNR_i);
[~, j] = max(SNR_q);
gamma_opt = round((i + j) / 2);
gamma_opt = gamma_sweep(gamma_opt);

%% PLL
[phi_pll, pll, pc_pll, e_pll] = compute_pll(gamma_opt, pc);

xRX_pll = xRX .* pll;

%% DEMODULATION
xiRX = real(xRX_pll) - Ac;
xqRX = real(xRX_pll * exp(1j * pi/2));

dataRX = [xiRX, xqRX];
% sound(dataRX, Fs);

%% PLOTS
% received signal
figure;
subplot(3, 1, 1)
plot(t_sym, real(xTX));
title("Transmitted Signal Complex Envelope");
xlabel("time [s]");
ylabel("amplitude");
grid on;

subplot(3, 1, 2)
plot(t_sym, real(xRX));
title("Received Signal Complex Envelope");
xlabel("time [s]");
ylabel("amplitude");
grid on;

subplot(3, 1, 3)
plot(t_sym, abs(xTX - xRX) ./ abs(xTX));
title("Error Ratio");
xlabel("time [s]");
ylabel("error ratio");
grid on;

% filtering
figure;
subplot(3, 1, 1);
plot(f, abs(XRX));
title("Received Signal Spectrum");
xlabel("frequency [f]");
ylabel("magnitude");
xlim([-40 40]);
grid on;

subplot(3, 1, 2);
plot(f, abs(H));
title("Filter Transfer Function");
xlabel("frequency [f]");
ylabel("magnitude");
xlim([-40 40]);
ylim([-0.5 1.5]);
grid on;

subplot(3, 1, 3);
plot(f, abs(Pc));
title("Pure Carrier");
xlabel("frequency [f]");
ylabel("magnitude");
xlim([-40 40]);
grid on;

% SNR
figure;
plot(gamma_sweep, SNR_i);
title("Signal to Noise Ratio");
xlabel("gamma");
ylabel("SNR");
grid on;
hold on;
plot(gamma_sweep, SNR_q, "red");
hold on;
xline(gamma_sweep(i), "blue", "LineWidth", 2);
xline(gamma_sweep(j), "red", "LineWidth", 2);
xline(gamma_sweep(round((i + j) / 2)), "black", "LineWidth", 2);
legend("SNR in-phase signal", "SNR quadrature signal", "optimal gamma inphase", ...
    "optimal gamma quadrature", "optimal gamma", "Location", "northwest");

% pll
figure;
subplot(3, 1, 1);
plot(t_sym, phi_pll);
title("PLL Phase");
xlabel("time [s]");
ylabel("phase [rad]");
grid on;

subplot(3, 1, 2);
plot(t_sym, real(pc_pll));
title("Pure Carrier Complex Envelope after PLL");
xlabel("time [s]");
ylabel("amplitude");
grid on;

subplot(3, 1, 3);
plot(t_sym, e_pll);
title("Error");
xlabel("time [s]");
ylabel("amplitude");
grid on;

% demodulation
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

subplot(3, 1, 3);
plot(t, abs(xi - xiRX) ./ xi);
title("Relative Error");
xlabel("time [s]");
ylabel("amplitude");
grid on;
hold on;
plot(t, abs(xq - xqRX) ./ xq, "red");
legend("left signal", "right signal")

