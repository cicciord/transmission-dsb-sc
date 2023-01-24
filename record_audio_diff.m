% RECORD AUDIO
% This script is used just to record and save a .wav file it should only be used to
% generate a sample audio track to be used in final_project.m

close all
clear
clc

%% VARIABLES DEFINITION
Fs = 44100; % sampling frequency [Hz]
t = 5; % record duration [s] 
nBits   = 16; % number of bits
nCh = 1; % number of channel (1 or 2)

filename = "assets/recording.wav";


%% RECORD AUDIO SIGNAL
% create an audiorecorder object
Rec1 = audiorecorder(Fs, nBits, nCh);
Rec2 = audiorecorder(Fs, nBits, nCh);
get(Rec1);
get(Rec2);

% record audio from a microphone
disp("Recording first track...");
recordblocking(Rec1, t);
disp("Record ended!");
disp("Recording second track...");
recordblocking(Rec2, t);
disp("Record ended!");

%% PLAYBACK THE RECORDING
% play(Rec1);
% play(Rec2);

%% STORE THE DATA AQUIRED
rec1 = getaudiodata(Rec1);
rec2 = getaudiodata(Rec2);

record=[rec1, rec2];

%% SAVE THE RECORD TO A FILE
audiowrite(filename, record, Fs);
