function CropIms;

addpath('../BM3D');
addpath('../LASIP');
addpath('../DNCNN/model');
addpath('../DNCNN/utilities');

if ismac
    baseDir = '/Users/csprh/tmp/Huawei/Train/';
else
    baseDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/';
end


noisyDir = [baseDir 'Buildings/Noisy/'];
cleanDir = [baseDir 'Buildings/Clean/'];
cropImsDir(cleanDir, noisyDir);


function cropImsDir(cleanDir, noisyDir)


load(fullfile('GD_Color_Blind.mat'));

%%%
net = vl_simplenn_tidy(net);

imList = dir([ noisyDir '*.png']);
noOfIms = length(imList);
for ii = 1:noOfIms
    thisImName = imList(ii).name;
    zRGB = im2double(imread([noisyDir thisImName]));
    yRGB = im2double(imread([cleanDir thisImName]));
    greyzRGB = rgb2gray(zRGB);
    greyyRGB = rgb2gray(yRGB);
    thisSigma = estimate_noise(greyzRGB*255);
    thisSigma2 = function_stdEst(greyzRGB*255);
    clean = single(yRGB);
    input = single(zRGB);
    %res    = vl_simplenn(net,input,[],[],'conserveMemory',true,'mode','test');
    res = simplenn_matlab(net, input); %%% use this if you did not install matconvnet.
    output = input - res(end).x;
    
    [PSNRNN(ii), SSIMNN(ii)] = Cal_PSNRSSIM(255*clean,255*output,0,0);
    
    %thisSigma = 7;
    [PSNR, yRGB_est] = CBM3D(clean, zRGB, thisSigma,'high',0);
    [PSNRB(ii), SSIMB(ii)] = Cal_PSNRSSIM(255*clean,255*yRGB_est,0,0);
    PSNRNN
    SSIMNN
    PSNRB
    SSIMB
    pause(0.1);
end
