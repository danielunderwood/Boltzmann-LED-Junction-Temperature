% Read in data
% NOTE: Matlab file should be in same directory as CSV files
aqua = csvread('data/aqua.csv');
blue = csvread('data/blue.csv');
green = csvread('data/green.csv');
orange = csvread('data/orange.csv');
red = csvread('data/red.csv');
yellow = csvread('data/yellow.csv');

% Get intensities and wavelength array
wavelength = aqua(:, 1) - 15;
aquaInt = aqua(:, 2);
blueInt = blue(:, 2);
greenInt = green(:, 2);
orangeInt = orange(:, 2);
redInt = red(:, 2);
yellowInt = yellow(:, 2);

% Get energy by E = hc/lambda (hc = 1241.5)
energy = 1241.5 ./ wavelength;

% Normalize Data
aquaNorm = aquaInt - min(aquaInt);
aquaNorm = aquaNorm ./ max(aquaNorm);
blueNorm = blueInt - min(blueInt);
blueNorm = blueNorm ./ max(blueNorm);
greenNorm = greenInt - min(greenInt);
greenNorm = greenNorm ./ max(greenNorm);
orangeNorm = orangeInt - min(orangeInt);
orangeNorm  = orangeNorm ./ max(orangeNorm);
redNorm = redInt - min(redInt);
redNorm = redNorm ./ max(redNorm);
yellowNorm = yellowInt - min(yellowInt);
yellowNorm = yellowNorm ./ max(yellowNorm);

% Plot Data
figure(1);
plot(energy, redNorm, 'color', [1 0 0])
hold on
plot(energy, orangeNorm, 'color', [1 0.5 0])
plot(energy, yellowNorm, 'color', [0 0 0])
plot(energy, greenNorm, 'color', [0 1 0])
plot(energy, aquaNorm, 'color', [ 0 1 1])
plot(energy, blueNorm, 'color', [0 0 1])
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
title('LED Lab Spectra')
legend('Red', 'Orange', 'Yellow', 'Green', 'Aqua', 'Blue')
ylim([0 1])
xlim([min(energy) max(energy)])
hold off;

% Remove background (noise)
% New arrays with reducted noiced named colorReduced
background = mean(aquaNorm(3400:3500));
aquaReduced = aquaNorm - background;
background = mean(blueNorm(3400:3500));
blueReduced = blueNorm - background;
background = mean(greenNorm(3400:3500));
greenReduced = greenNorm - background;
background = mean(orangeNorm(3400:3500));
orangeReduced = orangeNorm - background;
background = mean(redNorm(3400:3500));
redReduced = redNorm - background;
background = mean(yellowNorm(3400:3500));
yellowReduced = yellowNorm - background;


% Plot Noise-Reduced Data
figure(2);
plot(energy, redReduced, 'color', [1 0 0])
hold on
plot(energy, orangeReduced, 'color', [1 0.5 0])
plot(energy, yellowReduced, 'color', [0 0 0])
plot(energy, greenReduced, 'color', [0 1 0])
plot(energy, aquaReduced, 'color', [ 0 1 1])
plot(energy, blueReduced, 'color', [0 0 1])
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
title('LED Lab Spectra (Reduced Noise)')
legend('Red', 'Orange', 'Yellow', 'Green', 'Aqua', 'Blue')
ylim([0 1])
xlim([min(energy) max(energy)])
hold off;

% --- AQUA ---

% Set cutoff value
cutoff = 0.7 * max(aquaReduced);

% Get index of max value
[~, I] = max(aquaReduced);

% Iterate through aqua to set i0
for i = 1:I
    if aquaReduced(i) > cutoff
        aquai1 = i;
        break
    end
end

% Iterate to set i1
for i = I:-1:1
    if aquaReduced(i) < 0
        aquai0 = i+100;
        break
    end
end

% --- BLUE ---

% Set cutoff value
cutoff = 0.7 * max(blueReduced);

% Get index of max value
[~, I] = max(blueReduced);

% Iterate through aqua to set i0
for i = 1:I
    if blueReduced(i) > cutoff
        bluei1 = i;
        break
    end
end

% Iterate to set i1
for i = I:-1:1
    if blueReduced(i) < 0
        bluei0 = i + 120;
        break
    end
end

% --- GREEN ---

% Set cutoff value
cutoff = 0.7 * max(greenReduced);

% Get index of max value
[~, I] = max(greenReduced);

% Iterate through aqua to set i0
for i = 1:I
    if greenReduced(i) > cutoff
        greeni1 = i;
        break
    end
end

% Iterate to set i1
for i = I:-1:1
    if greenReduced(i) < 0
        greeni0 = i + 100;
        break
    end
end

% --- ORANGE ---

% Set cutoff value
cutoff = 0.7 * max(orangeReduced);

% Get index of max value
[~, I] = max(orangeReduced);

% Iterate through aqua to set i0
for i = 1:I
    if orangeReduced(i) > cutoff
        orangei1 = i;
        break
    end
end

% Iterate to set i1
for i = I:-1:1
    if orangeReduced(i) < 0
        orangei0 = i + 100;
        break
    end
end

% --- RED ---

% Set cutoff value
cutoff = 0.7 * max(redReduced);

% Get index of max value
[~, I] = max(redReduced);

% Iterate through aqua to set i0
for i = 1:I
    if redReduced(i) > cutoff
        redi1 = i;
        break
    end
end

% Iterate to set i1
for i = I:-1:1
    if redReduced(i) < 0
        redi0 = i + 100;
        break
    end
end

% --- YELLOW ---

% Set cutoff value
cutoff = 0.7 * max(yellowReduced);

% Get index of max value
[~, I] = max(yellowReduced);

% Iterate through aqua to set i0
for i = 1:I
    if yellowReduced(i) > cutoff
        yellowi1 = i;
        break
    end
end

% Iterate to set i1
for i = I:-1:1
    if yellowReduced(i) < 0
        yellowi0 = i + 100;
        break
    end
end

% Get energy arrays for energy between i0 and i1 values
aquaE = energy(aquai0:aquai1);
blueE = energy(bluei0:bluei1);
greenE = energy(greeni0:greeni1);
orangeE = energy(orangei0:orangei1);
redE = energy(redi0:redi1);
yellowE = energy(yellowi0:yellowi1);

% Logarithmic arrays of intensity
aquaLogInt = log(aquaReduced(aquai0:aquai1));
blueLogInt = log(blueReduced(bluei0:bluei1));
greenLogInt = log(greenReduced(greeni0:greeni1));
orangeLogInt = log(orangeReduced(orangei0:orangei1));
redLogInt = log(redReduced(redi0:redi1));
yellowLogInt = log(yellowReduced(yellowi0:yellowi1));

% Get fitted functions
aquaFit = polyfit(aquaE, aquaLogInt, 1);
aquaReg = aquaFit(1) * aquaE + aquaFit(2);
blueFit = polyfit(blueE, blueLogInt, 1);
blueReg = blueFit(1) * blueE + blueFit(2);
greenFit = polyfit(greenE, greenLogInt, 1);
greenReg = greenFit(1) * greenE + greenFit(2);
orangeFit = polyfit(orangeE, orangeLogInt, 1);
orangeReg = orangeFit(1) * orangeE + orangeFit(2);
redFit = polyfit(redE, redLogInt, 1);
redReg = redFit(1) * redE + redFit(2);
yellowFit = polyfit(yellowE, yellowLogInt, 1);
yellowReg = yellowFit(1) * yellowE + yellowFit(2);

% Plot logarithmic intensities

% --- AQUA ---
figure(3)
plot(aquaE, aquaLogInt, '+', aquaE, aquaReg, '-')
title('Aqua Energy verus Logarithmic Intensity and Fit')
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
legend('Data', sprintf('Fitted Data: y = %.2fx + %.2f', ...
    aquaFit(1), aquaFit(2)))

% --- BLUE ---
figure(4)
plot(blueE, blueLogInt, '+', blueE, blueReg, '-')
title('Blue Energy verus Logarithmic Intensity and Fit')
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
legend('Data', sprintf('Fitted Data: y = %.2fx + %.2f', ...
    blueFit(1), blueFit(2)))

% --- GREEN ---
figure(5)
plot(greenE, greenLogInt, '+', greenE, greenReg, '-')
title('Green Energy verus Logarithmic Intensity and Fit')
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
legend('Data', sprintf('Fitted Data: y = %.2fx + %.2f', ...
    greenFit(1), greenFit(2)))

% --- ORANGE ---
figure(6)
plot(orangeE, orangeLogInt, '+', orangeE, orangeReg, '-')
title('Orange Energy verus Logarithmic Intensity and Fit')
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
legend('Data', sprintf('Fitted Data: y = %.2fx + %.2f', ...
    orangeFit(1), orangeFit(2)))

% --- RED ---
figure(7)
plot(redE, redLogInt, '+', redE, redReg, '-')
title('Red Energy verus Logarithmic Intensity and Fit')
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
legend('Data', sprintf('Fitted Data: y = %.2fx + %.2f', ...
    redFit(1), redFit(2)))

% --- YELLOW ---
figure(8)
plot(yellowE, yellowLogInt, '+', yellowE, yellowReg, '-')
title('Yellow Energy verus Logarithmic Intensity and Fit')
xlabel('Energy [eV]')
ylabel('Intensity [arb. units]')
legend('Data', sprintf('Fitted Data: y = %.2fx + %.2f', ...
    yellowFit(1), yellowFit(2)))

% Calculate s_beta values
aquaSB = sqrt((aquai1 - aquai0 - 2)^-1 * sum((aquaLogInt - aquaReg).^2/ ...
    sum((aquaE -  mean(aquaE)).^2)));
blueSB = sqrt((bluei1 - bluei0 - 2)^-1 * sum((blueLogInt - blueReg).^2/ ...
    sum((blueE -  mean(blueE)).^2)));
greenSB = sqrt((greeni1 - greeni0 - 2)^-1 * sum((greenLogInt - greenReg).^2/ ...
    sum((greenE -  mean(greenE)).^2)));
orangeSB = sqrt((orangei1 - orangei0 - 2)^-1 * sum((orangeLogInt - orangeReg).^2/ ...
    sum((orangeE -  mean(orangeE)).^2)));
redSB = sqrt((redi1 - redi0 - 2)^-1 * sum((redLogInt - redReg).^2/ ...
    sum((redE -  mean(redE)).^2)));
yellowSB = sqrt((yellowi1 - yellowi0 - 2)^-1 * sum((yellowLogInt - yellowReg).^2/ ...
    sum((yellowE -  mean(yellowE)).^2)));

% Define Boltzmann Constant (Units eV/K)
k = 8.617e-5;

% Calculate Temperatures
aquaTemp = -1/(k * aquaFit(1));
blueTemp = -1/(k * blueFit(1));
greenTemp = -1/(k * greenFit(1));
orangeTemp = -1/(k * orangeFit(1));
redTemp = -1/(k * redFit(1));
yellowTemp = -1/(k * yellowFit(1));

% Get beta derivative of temperature
TB = [aquaFit(1) aquaTemp; blueFit(1) blueTemp; greenFit(1) greenTemp; ...
    orangeFit(1) orangeTemp; redFit(1) redTemp; yellowFit(1) yellowTemp];
tbSlope = polyfit(TB(:,1), TB(:,2), 1);

% Calculate Temperature Uncertainty
aquaST = abs(tbSlope(1)) * aquaSB;
blueST = abs(tbSlope(1)) * blueSB;
greenST = abs(tbSlope(1)) * greenSB;
orangeST = abs(tbSlope(1)) * orangeSB;
redST = abs(tbSlope(1)) * redSB;
yellowST = abs(tbSlope(1)) * yellowSB;

% Make Table of Data for Readability
figure(9)
uitable('Position', [0 0 500 500], 'ColumnName', ...
    {'Color', 'Temperature', 'S_B', 'Uncertainty'}, 'Data', ...
    [transpose({'Aqua', 'Blue', 'Green', 'Orange', 'Red', 'Yellow'}), ...
    transpose({aquaTemp, blueTemp, greenTemp, orangeTemp, redTemp, ...
    yellowTemp}), transpose({aquaSB, blueSB, greenSB, orangeSB, ...
    redSB, yellowSB}), transpose({aquaST, blueST, greenST, orangeST, ...
    redST, yellowST})])

% Assign figure handles
ledSpectra = figure(1);
ledSpectraReduced = figure(2);
aquaFit = figure(3);
blueFit = figure(4);
greenFit = figure(5);
orangeFit = figure(6);
redFit = figure(7);
yellowFit = figure(8);

% Print figures to figures folder
print('-depsc',ledSpectra, 'figures/ledSpectra.eps')
print('-depsc',ledSpectraReduced, 'figures/ledSpectraReduced.eps')
print('-depsc',aquaFit, 'figures/aquaFit.eps')
print('-depsc',blueFit, 'figures/blueFit.eps')
print('-depsc',greenFit, 'figures/greenFit.eps')
print('-depsc',orangeFit, 'figures/orangeFit.eps')
print('-depsc',redFit, 'figures/redFit.eps')
print('-depsc',yellowFit, 'figures/yellowFit.eps')
