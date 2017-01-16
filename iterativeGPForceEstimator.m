% Iterative learning

whichHand = 'left';
whichFinger ='index';



indexFigner = tactileData(whichHand, whichFinger);
%%
minSet = 1;
maxSet = 3;
expDir = '/home/nawidj/leftHandTrainingData/dataTipOnly';
indexFigner.loadDataFrom(expDir, minSet:maxSet);

%%
minSet = 2;
maxSet = 9;
expDir = '/home/nawidj/leftHandTrainingData/data';
indexFigner.loadDataFrom(expDir, minSet:maxSet);

%% Tain
minSet = 1;
maxSet = 11;

indexFigner.updateForceEstimatorGP(1);
for i = minSet+1:maxSet
    indexFigner.updateForceEstimate(i);
    indexFigner.updateForceEstimatorGP(i);
    
end

%% Tain recursive


for i = 9:maxSet
    indexFigner.updateForceEstimatorGP(i);
end

%%

indexFigner.loadIteration(9);
for i = 1:4
    [meanForce, forceVar] = indexFigner.estimateForce(i);
    indexFigner.updateForceEstimate(i);
    indexFigner.plotForceEstimate(meanForce, forceVar, i, 1);
    pause;
end

%%

for i = minSet+1:6
    indexFigner.loadIteration(i - 1); % load the model from previous iteration
    indexFigner.updateForceEstimate(i);
    indexFigner.plotTrainingData(i, 1);
    pause;
end


%%
% Iterative learning

%expDir = '/home/nawidj/leftHandTrainingData/dataTipOnly';
%expDir = '/home/nawidj/leftHandTrainingData/dataOld';

expDir = '/home/nawidj/leftHandTrainingData/dataRandom';

whichHand = 'left';
whichFinger ='index';
minSet = 1;
maxSet = 3;


indexFigner = tactileData(whichHand, whichFinger);
indexFigner.loadDataFrom(expDir, minSet:maxSet);
