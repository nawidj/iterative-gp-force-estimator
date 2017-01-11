% Iterative learning

expDir = '/home/nawidj/leftHandTrainingData/data';
whichHand = 'left';
whichFinger ='index';
minSet = 1;
maxSet = 11;
targetFactor = 10;

indexFigner = tactileData(whichHand, whichFinger);
indexFigner.loadDataFrom(expDir, minSet:maxSet);
indexFigner.updateForceEstimatorGP(1);


indexFigner.updateForceEstimate(2);


indexFigner.updateForceEstimatorGP(2);

indexFigner.updateForceEstimate(3);
indexFigner.updateForceEstimatorGP(3);

indexFigner.updateForceEstimate(4);
indexFigner.updateForceEstimatorGP(4);

%%
for i = 2:4
[meanForce, forceVar] = indexFigner.estimateForce(i);
indexFigner.plotForceEstimate(meanForce, i, 1);
pause;
end


