# Boltzmann LED Junction Temperature

__NOTE:__ This repository contains code for data analysis and thus is poorly structured as it is not meant to be continually supported or updated.

__Author:__   Daniel Underwood

__Date:__     April 15, 2014


The MATLAB script in this repository was used to calculate the junction temperature of several different LEDs by fitting the energy obtained from the spectra to a Boltzmann distribution. From this fit, the temperature was extracted.

The spectral data that was obtained in lab is included in the CSV files. It was discovered that there is a 15nm calibration needed for the equipment that was used, which is taken care of in the script.

The script generates plots of all spectral fits as well as the spectral data (both with and without noise reduction). The initial data in the CSV file is wavelength/intensity, while the plotted data is energy/normalized intensity. The script also saves the plots in EPS format in `figures/`. If a different format is desired, the `print` commands at the end of the script should be modified. The figures produced by the script are included in the repository. 

A table is also outputted with the calculated junction temperatures and standard deviation for both the temperature and the plot fit, although the table data is not included. It should also be noted that the method for calculating the standard deviation for the temperature takes into account the standard deviation of the data fit. A markdown representation of this table is in `figures/OutputData.md`. It should be noted that the values in the table are specific to the LEDs and data set that is used.

**_Note:_** The script currently outputs all plots even though it saves them to the figures directory. If this is not the desired behavior or if the computer to be used is slow, it is advised to make the plots not visible and just use the figures. Also, it is necessary for the figures directory to exist to run the script. However, since the figures are included in the repository, this should not be a problem.
