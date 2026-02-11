%% Thermal Noise Simulation and Analysis
clear; clc; close all;

% 1. Define Parameters
B = 1e6;            % Bandwidth (1 MHz)
R = 100;            % Resistance (100 Ohms)
T = 300;            % Temperature (300 Kelvin)
k = 1.38e-23;       % Boltzmann Constant
n_samples = 10000;  % Number of samples

% 2. Thermal Noise Generation (Time Domain)
% V_rms = sqrt(4 * k * T * R * B)
time = 0 : 1/B : (n_samples-1) / B;
thermal_noise = sqrt(4 * k * T * R * B) * randn(1, n_samples);

% 3. Visualization: Time Domain
figure('Name', 'Thermal Noise Analysis');
subplot(2,1,1);
plot(time*1e3, thermal_noise * 1e6); % Plot in ms and microVolts
title(['Thermal Noise (Time Domain) | B=', num2str(B/1e6), 'MHz, T=', num2str(T), 'K']);
xlabel('Time (ms)');
ylabel('Amplitude (\muV)');
grid on;

% 4. Power Spectral Density (PSD) Analysis
% Using pwelch to estimate the power distribution
[psd, freq] = pwelch(thermal_noise, [], [], [], B);

subplot(2,1,2);
semilogx(freq, 10*log10(psd));
title('Power Spectral Density (PSD)');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;