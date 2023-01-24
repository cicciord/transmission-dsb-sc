% config.m
% Configure simulation parameters
filename = "assets/audio.mp3";

Fc      = 102.5e6; % carrier frequency [Hz]
alpha   = 20;      % suppressed carrier factor [dB]
PhTXDeg = 65;      % carrier initial phase [deg]

PhTX = PhTXDeg * pi / 180;

c     = 3e8; % speed of light [m/s]
D     = 300; % receiver distance [m], minimum receiver distance [m]
Vkmph = 130; % receiver velocity [km/h]

V = 130 / 3.6;

%% IMPORT AUDIO FILES
[data, Fs] = audioread(filename); % sampled signals, sampling frequency

xi = data(:, 1); % left audio signal
xq = data(:, 2); % right audio signal

% remove DC component to have zero average
xi = xi - mean(xi);
xq = xq - mean(xq);

%% AXIS DEFINITIONS
% time axis
Ts = 1 / Fs; % sampling period
t = (0 : Ts : (length(data)-1)*Ts)';

% time axis symmetrical to the origin
% closest point between transmitter and receiver is @t=0.
t_sym = (-length(data)*Ts/2 : Ts : (length(data)-1)*Ts/2)';

% frequency axis
Df = Fs/length(data);
f = (-Fs/2 : Df : Fs/2-Df)';
