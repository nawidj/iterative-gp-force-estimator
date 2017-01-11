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
        downSampleRate = 10;
        tolerance = 0.05;
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
        
        figNum = plotData(this, nSet, figNum);
        
        loadDataFrom(this, expDir, setList);
        plotForceEstimate(this, forceEstimate, nSet, figNum);
        
        updateForceEstimatorGP(this, maxSet);
        [meanForce, forceVar] = estimateForce(this, setNum);
        
        function updateForceEstimate(this, setNum)
            [this.forceEstimate{setNum}, ~] = estimateForce(this, setNum);
        end
        

    end
    
    methods (Access = protected)
        [attributes, trarget] = getTrainingSet(this, maxSet, tolerence, targetScale, downSampleRate)

        
    end
end