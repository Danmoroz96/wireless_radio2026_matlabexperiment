# wireless_radio2026_matlabexperiment
MATLAB experiments with Thermal Noise


Understanding the Results

1. Time Domain ObservationIn the first plot, you will see a "fuzzy" signal centered around 0.

Because you used the randn function, the noise follows a Gaussian (Normal) Distribution.

Amplitude: Most of the noise voltage peaks will stay within +-3 om (three times the calculated RMS voltage).

Mean: The average value is zero because thermal noise is random AC, not a DC offset.

2. Frequency Domain (PSD) Observation

Thermal noise is considered "White Noise" within the bandwidth you've defined.Flatness: On the semilogx plot, the line should be relatively flat across the spectrum. This indicates that the noise power is distributed equally across all frequencies.Relationship: If you increase the Bandwidth (B), the total power increases, but the PSD level (the height of the line) remains constant because the power is spread over a wider range.


Defining the Physics (V_{rms} = sqrt{4kTRB})

Thermal noise is determined by four physical constants. The code starts by defining these so it can calculate the "strength" of the noise.

B = 1e6: We are looking at a 1 MHz slice of the spectrum.

T = 300: Standard room temperature in Kelvin.

k = 1.38e-23: Boltzmann’s constant, which relates thermal energy to temperature.

R = 100: The resistance of the component. Higher resistance means more thermal agitation.

2. Generating the "White" Noise

This is the core of the simulation. 

thermal_noise = sqrt(4 * k * T * R * B) * randn(1, n_samples);

randn: This generates numbers with a Gaussian (Normal) distribution, a mean of 0, and a standard deviation of 1. This is perfect because thermal noise in nature follows this exact statistical pattern.The Multiplier: By multiplying the random numbers by sqrt{4kTRB}, we scale the noise from a standard deviation of 1 to the actual physical RMS Voltage required by the Nyquist formula.

3. Time Domain Visualization

The code creates a time vector to map each sample to a specific moment.

time = 0 : 1/B : (n_samples-1) / B;
plot(time, thermal_noise);

The Sample Rate: Note that the time step is 1/B. In digital systems, we usually sample at at least twice the bandwidth (Nyquist rate), but here we are simulating the noise specifically within that bandwidth.The Result: You see a "grass-like" plot. There are no patterns or cycles because thermal noise is completely uncorrelated (random).

4. Frequency Analysis (The PSD)

This is where we prove the noise is "White."

[psd, freq] = pwelch(thermal_noise, [], [], [], B);
semilogx(freq, 10*log10(psd));


pwelch: Instead of a simple FFT (which is very "noisy"), Welch's method averages segments of the signal to give you a smooth estimate of the power at every frequency.

10*log10(psd): We convert the power to Decibels (dB). 
This is the standard way to look at power because noise levels can span many orders of magnitude.

semilogx: This uses a logarithmic scale for the X-axis (frequency). On this plot, true white noise appears as a flat horizontal line, meaning every frequency contains the same amount of power.

Summary of logic

Calculate the theoretical noise power based on physics.

Generate random numbers that match that power.

Plot those numbers to see the "static."

Transform to the frequency domain to confirm the power is spread evenly (White Noise).

The code and plot itself can be seen in the files

Plus, I made an experiments with increasing bandwidth, resistance and temperature.
