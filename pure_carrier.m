% pure_carrier.m
% Simulation in case of a mobile receiver transmitting only a pure carrier.
close all;
clear;
clc;
propagation_channel;

%% PURE CARRIER DEFINITION
Apc  = 1; % pure carrier amplitude
Phpc = 0; % pure carrier initail phase

pc = Apc * exp(1j * Phpc); % pure carrier complex envelope
pc = (t_sym * 0) + pc;     % transform pc in a vector

phi = mod(phi, 2*pi); % remove multiple of 2pi
Phi = mod(Phpc - phi, 2*pi);

pcRX = pc .* exp(-1j * phi); % received pure carrier

%% PLL
[phi_pll, pll, pcRX_pll, e_pll] = compute_pll(1, pcRX); % gamma set as 1

%% PLOTS
% pure carrier
figure;
subplot(2, 1, 1);
plot(t_sym, real(pc));
title("Complex Envelope");
xlabel("time [s]");
ylabel("amplitude");
grid on;

subplot(2, 1, 2);
plot(t_sym, real(pcRX));
title("Received Complex Envelope");
xlabel("time [s]");
ylabel("amplitude");
grid on;

% pll
figure;
subplot(3, 1, 1);
plot(t_sym, phi_pll);
title("PLL Phase");
xlabel("time [s]");
ylabel("phase [rad]");
grid on;

subplot(3, 1, 2);
plot(t_sym, real(pcRX_pll));
title("Pure Carrier Complex Envelope after PLL");
xlabel("time [s]");
ylabel("amplitude");
ylim([-0.5 1.5]);
grid on;

subplot(3, 1, 3);
plot(t_sym, e_pll);
title("Error");
xlabel("time [s]");
ylabel("amplitude");
ylim([-0.5 1]);
grid on;
