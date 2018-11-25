function thisSigma = getSigma(inputRect)

inputRect = rgb2gray(inputRect);
blurredIm = imgaussfilt(inputRect,8);
thisNoise = inputRect-blurredIm;

thisSigma = std2(thisNoise);