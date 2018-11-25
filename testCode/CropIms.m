function CropIms;

inDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Buildings/Clean/';
outDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/Buildings/Clean/';
cropImsDir(inDir, outDir);
inDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Buildings/Noisy/';
outDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/Buildings/Noisy/';
cropImsDir(inDir, outDir);
inDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Text/Clean/';
outDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/Text/Clean/';
cropImsDir(inDir, outDir);
inDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Text/Noisy/';
outDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/Text/Noisy/';
cropImsDir(inDir, outDir);
inDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Foliage/Clean/';
outDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/Foliage/Clean/';
cropImsDir(inDir, outDir);
inDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Foliage/Noisy/';
outDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/Foliage/Noisy/';
cropImsDir(inDir, outDir);


function cropImsDir(inDir, outDir)
	mkdir(outDir);

	imList = dir([inDir '*.png']);
	noOfIms = length(imList);
    
	for ii = 1:noOfIms
       thisImName = imList(ii).name;
       thisIm = imread([inDir thisImName]);
       thisIm = imcrop(thisIm, [1 1 1023 1023]);
       imwrite(thisIm,[outDir thisImName]);
    end
    %imagesc(thisIm);
