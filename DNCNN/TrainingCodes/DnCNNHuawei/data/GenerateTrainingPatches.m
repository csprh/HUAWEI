function GenerateTrainingPatches

%%% Generate the training data.

clear;close all;

%Data size should approximate 
%212096         128        1657 (from bw orig)
%40          40           1      212096  49024
addpath('utilities');

batchSize      = 128;        %%% batch size
dataName      = 'TrainingPatches';

if ismac
    baseDir = '/Users/csprh/tmp/Huawei/Train/';
else
    baseDir = '/mnt/storage/home/csprh/scratch/HAB/Huwei/Train/';
end


patchsize     = 40;
stride        = 40;
step          = 0;

count   = 0;


load theseIndices

theseNHO = inds.NHO;
classes{1} = 'Buildings/';
classes{2} = 'Foliage/';
classes{3} = 'Text/';
for ii = 1:length(theseNHO)
%for ii = 1:5
    thisInd = theseNHO(ii);
    thisInd = 663;
    imName = ['Image_' num2str(thisInd) '.png']; 
    filepaths{ii}.Clean = getThisPath(baseDir,classes,imName,'Clean/');
    filepaths{ii}.Noisy = getThisPath(baseDir,classes,imName,'Noisy/');
end


%% count the number of extracted patches
for i = 1 : length(filepaths)
    
    image = imread(filepaths{i}.Clean); % uint8

    %[~, name, exte] = fileparts(filepaths(i).name);
    if mod(i,100)==0
        disp([i,length(filepaths)]);
    end
    for s = 1:1
        %image = imresize(image,scales(s),'bicubic');
        [hei,wid,~] = size(image);
        for x = 1+step : stride : (hei-patchsize+1)
            for y = 1+step :stride : (wid-patchsize+1)
                count = count+1;
            end
        end
    end
end

numPatches = ceil(count/batchSize)*batchSize;

disp([numPatches,batchSize,numPatches/batchSize]);

%pause;

inputs  = zeros(patchsize, patchsize, 3, numPatches,'single'); % this is fast
cleaninputs  = zeros(patchsize, patchsize, 3, numPatches,'single'); % this is fast
count   = 0;
tic;
for i = 1 : length(filepaths)
    
    image = imread(filepaths{i}.Noisy); % uint8
    cleanImage = imread(filepaths{i}.Clean); % uint8

    if mod(i,100)==0
        disp([i,length(filepaths)]);
    end
    %     end
    %image_clip = image(1:180,1:180,:);
    %im_label  = im2single(image_clip); % single
    
    im_label  = im2single(image); % single
    cleanim_label  = im2single(cleanImage); % single
    [hei,wid,~] = size(im_label);
    
    for x = 1+step : stride : (hei-patchsize+1)
        for y = 1+step :stride : (wid-patchsize+1)
            count       = count+1;
            inputs(:, :, :, count)   = im_label(x : x+patchsize-1, y : y+patchsize-1,:);
            cleaninputs(:, :, :, count)   = cleanim_label(x : x+patchsize-1, y : y+patchsize-1,:);
        end
    end
end
toc;
set    = uint8(ones(1,size(inputs,4)));

disp('-------Datasize-------')
disp([size(inputs,4),batchSize,size(inputs,4)/batchSize]);

if ~exist(dataName,'file')
    mkdir(dataName);
end

%%% save data
save(fullfile(dataName,['imdb_',num2str(patchsize),'_',num2str(batchSize)]), 'inputs','cleaninputs','set','-v7.3')

function output = getThisPath(baseDir, imName,cleanNoisy, classes)

for ii = 1: length(classes)
    thisClass = classes{ii};
    thisPath = dir ([baseDir thisClass cleanNoisy imName]);
    if length(thisPath) == 1 
        output = [baseDir thisClass cleanNoisy imName];
    end
end



