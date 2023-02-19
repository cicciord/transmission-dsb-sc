# Final Progect

Repository of the development of the "final project" @ Politecnico di Torino.

Analysis of a communication system operating the transmission of an analogue audio signal through a wireless channel using a DSB-SC modulation and assuming a mobile receiver.

# Usage

## Audio file

The audio file used is in the `assets` folder. If you change the name of the file please do the same `config.m`.

It is also possible to record the audio file executing the `record_audio.m` or `record_audio_diff.m`. The first records a stereo audio from your microphone, if the signal is not stereo it duplicates the same signal; the latter lets you record two different audio and saves them into the two channels of a stereo audio.

## Execution

All the main parameters are configured in the `config.m` file.

The simulation is divided in 3 main tasks. To run them it is enough to execute che relative matlab script.

- Task 1: static receiver -> `static_receiver.m`
- Task 2: pure carrier PLL -> `pure_carrier.m`
- Task 3: mobile receiver -> `mobile_receiver.m`

Beware, `mobile_receiver.m` runs the PLL computation 100 times with current sectings, it might take some time to complete the execution depending on your machine.

## Other scripts

The modulated signal is computed in the `modulator.m` script and it is used for both static and mobile receiver.

Except for the static case, the propagation channel equations are computed in `propagation_channel.m`.

This scripts are run automatically when needed, there's no need to run them individually. Though it is still possible to do it if you are interested only on that particular aspect.
