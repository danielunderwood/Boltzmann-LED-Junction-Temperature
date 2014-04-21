# Boltzmann LED Junction Temperature


__Author:__   Daniel Underwood

__Date:__     April 15, 2014


The MATLAB script in this repository was used to calculate the junction temperature of several different LEDs by fitting the energy obtained from the spectra to a Boltzmann distribution. From this fit, the temperature was extracted.

The spectral data that was obtained in lab is included in the CSV files. It was discovered that there is a 15nm calibration needed for the equipment that was used, which is taken care of in the script.

The script generates plots of all spectral fits as well as the spectral data (both with and without noise reduction). The initial data in the CSV file is wavelength/intensity, while the plotted data is energy/normalized intensity. The script also saves the plots in EPS format in `figures/`. A table is also outputted with the calculated junction temperatures and standard deviation for both the temperature and the plot fit. It should also be noted that the method for calculating the standard deviation for the temperature takes into account the standard deviation of the data fit.
