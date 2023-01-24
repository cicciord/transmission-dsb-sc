% propagation_channel.m
% Propagation channel equations
config;

s = V * t_sym; % receiver spatial equation on a straight line
d = sqrt(s.^2 + D^2); % distance equation
tau = d / c; % time delay
phi = 2 * pi * Fc .* tau; % phase delay

%% DOPPLER EFFECT
% theoretical formula of doppler effect
doppler_th = -(Fc / c) * ((V^2 * t_sym) ./ (sqrt(V^2 * t_sym.^2 + D^2)));

% doppler effect by numerical differentiation
doppler_num = -(1 / (2 * pi)) * (diff(phi) / Ts );

%% PLOTS
figure;
subplot(2, 2, 1);
plot(t_sym, d);
title("Receiver Distance");
xlabel("time [s]");
ylabel("distance [m]");
grid on;

subplot(2, 2, 2);
plot(t_sym, tau);
title("Receiver Time Delay");
xlabel("time [s]");
ylabel("delay [s]");
grid on;

subplot(2, 2, [3 4]);
plot(t_sym, mod(phi, 2*pi));
title("Receiver Phase Delay");
xlabel("time [s]");
ylabel("phase [rad]");
grid on;

% doppler
figure;
subplot(3, 1, 1);
plot(t_sym, doppler_th);
title("Doppler Effect Theoretical");
xlabel("time [s]");
ylabel("phase variation [rad/s]");
grid on;

subplot(3, 1, 2);
plot(t_sym(1:length(t_sym)-1), doppler_num);
title("Doppler Effect Numerical");
xlabel("time [s]");
ylabel("phase variation [rad/s]");
grid on;

subplot(3, 1, 3);
plot(t_sym(1:length(t_sym)-1), doppler_th(1:length(doppler_th)-1) - doppler_num);
title("Error of Numerical Result");
xlabel("time [s]");
ylabel("error [rad/s]");
grid on;
