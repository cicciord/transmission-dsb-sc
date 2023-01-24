% RECORD AUDIO
% This script is used just to record and save a .wav file it should only be used to
% generate a sample audio track to be used in final_project.m

close all
clear
clc

%% VARIABLES DEFINITION
Fs = 44100; % sampling frequency [Hz]
t = 20; % record duration [s] 
nBits = 16; % number of bits
nCh = 1; % number of channel (1 or 2)

filename = "assets/recording.wav";


%% RECORD AUDIO SIGNAL
% create an audiorecorder object
Rec = audiorecorder(Fs, nBits, nCh);
get(Rec);

% record audio from a microphone
disp("Recording...");
recordblocking(Rec, t);
disp("Record ended!");

%% PLAYBACK THE RECORDING
% play(Record);

%% STORE THE DATA AQUIRED
rec = getaudiodata(Rec);

% duplicate channel if only one channel is present
if nCh == 1
    rec = kron(rec, ones(1, 2));
end

%% SAVE THE RECORD TO A FILE
audiowrite(filename, rec, Fs);
