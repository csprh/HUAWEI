close all;
clear all;
load borders;
theseISOs;
allIndices = 1:length(theseISOs);
holdOutProp = 0.2;
totalIndicesHO = [];
totalIndicesNHO = [];
for ii = 1: length(borders)-1
   lowBorder = borders(ii);
   highBorder = borders(ii+1);
   theseIndices = allIndices((theseISOs>=lowBorder)&(theseISOs<highBorder));
   lenOfI = length(theseIndices);
   indIndices = 1:lenOfI;
   lenOfIHO = round(lenOfI*holdOutProp);
   [theseIndicesHO,HOInd] = datasample(theseIndices, lenOfIHO,'Replace',false);
   tmpIndx=1:length(theseIndices);
   tmpIndx(HOInd)=[];
   theseIndicesNHO=theseIndices(tmpIndx);
   totalIndicesHO = [totalIndicesHO theseIndicesHO];
   totalIndicesNHO = [totalIndicesNHO theseIndicesNHO];
   indsAll{ii}.HO = theseIndicesHO;
   indsAll{ii}.NHO = theseIndicesNHO;
   indsALLCls{ii}{1}.HO =  theseIndicesHO(theseIndicesHO<326);
   indsALLCls{ii}{1}.NHO = theseIndicesNHO(theseIndicesNHO<326);
   indsALLCls{ii}{2}.HO =  theseIndicesHO((theseIndicesHO>325)&(theseIndicesHO<651));
   indsALLCls{ii}{2}.NHO = theseIndicesNHO((theseIndicesNHO>325)&(theseIndicesNHO<651));
   indsALLCls{ii}{3}.HO =  theseIndicesHO(theseIndicesHO>650);
   indsALLCls{ii}{3}.NHO = theseIndicesNHO(theseIndicesNHO>650);
end

inds.HO = totalIndicesHO;
inds.NHO = totalIndicesNHO;
indsCls{1}.HO = totalIndicesHO(totalIndicesHO<326);
indsCls{1}.NHO = totalIndicesNHO(totalIndicesNHO<326);
indsCls{2}.HO = totalIndicesHO((totalIndicesHO>325)&(totalIndicesHO<651));
indsCls{2}.NHO = totalIndicesNHO((totalIndicesNHO>325)&(totalIndicesNHO<651));
indsCls{3}.HO =  totalIndicesHO(totalIndicesHO>650);
indsCls{3}.NHO =  totalIndicesNHO(totalIndicesNHO>650);

save theseIndices inds indsCls indsAll indsALLCls