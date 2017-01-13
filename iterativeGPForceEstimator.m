% Iterative learning

expDir = '/home/nawidj/leftHandTrainingData/data';
whichHand = 'left';
whichFinger ='index';
minSet = 1;
maxSet = 11;


indexFigner = tactileData(whichHand, whichFinger);
%%
indexFigner.loadDataFrom(expDir, minSet:maxSet);

%% Tain
indexFigner.updateForceEstimatorGP(1);

for i = minSet+1:maxSet
    indexFigner.updateForceEstimate(i);
    indexFigner.updateForceEstimatorGP(i);
    
end

%% Tain recursive


for i = minSet:maxSet
    indexFigner.updateForceEstimatorGP(i);
end

%%

indexFigner.loadIteration(7);
for i = minSet:maxSet
    [meanForce, forceVar] = indexFigner.estimateForce(i);
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
