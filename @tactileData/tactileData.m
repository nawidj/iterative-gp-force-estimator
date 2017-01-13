classdef tactileData < handle
    properties
        tactile;
        ft;
        forceEstimate;
        nSets = -1;
        whichHand;
        whichFinger;
        gpModel;
        epochs = 100;
        nholdouts = 2;
        targetScale = 10;
        downSampleRate = 25;
        tolerance = 0.5;
    end
    
    methods (Access = public)
        function obj = tactileData(whichHand, whichFinger)
            obj.nSets = 0;
            obj.whichHand = whichHand;
            obj.whichFinger = whichFinger;
        end
        
        function addSet(newTactileData, newFT, newForceEstimate)
            nSets = nSets +1;
            tactile{nSets} = newTactileData;
            ft{nSets} = newFT;
            forceEstimate{nSets} = newForceEstimate;
        end
        
        
        
        function updateForceEstimate(this, setNum)
            [this.forceEstimate{setNum}, ~] = estimateForce(this, setNum);
        end
        
        function loadIteration(this, itNum)
            load(sprintf('iteration_%02d.mat', itNum));
            this.gpModel = opt;
        end
        
        figNum = plotData(this, nSet, figNum);
        plotTrainingData(this, nSet, figNum);
        
        loadDataFrom(this, expDir, setList);
        plotForceEstimate(this, forceEstimate, variance, nSet, figNum);
        
        updateForceEstimatorGP(this, maxSet);
        updateForceEstimatorGPRec(this, maxSet);
        [meanForce, forceVar] = estimateForce(this, setNum);
    end
    
    methods (Access = protected)
        [attributes, target] = getTrainingSet(this, maxSet)
        [attributes, target] = getTrainingSetRecursive(this, maxSet);
    end
end