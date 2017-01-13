function [attributes, target] = getTrainingSetRecursive(this, maxSet)



% The first set is always included. This is the initial set
if(maxSet == 1)
    attributes = downsample(this.tactile{maxSet}, this.downSampleRate);
    target = downsample(this.ft{1}(:,3) * this.targetScale, this.downSampleRate);
else
   % Estimate the number of data
   % The 
   dataLength = 0;%length(downsample(this.forceEstimate{1}), this.downSampleRate);
   
   % load the latest model
   this.loadIteration(maxSet-1);
   
   for dataset = 1:maxSet
       this.updateForceEstimate(dataset)
       dataLength = dataLength + length(downsample(this.forceEstimate{dataset}(abs(this.forceEstimate{dataset}(:,1) - this.ft{dataset}(:,3)) > this.tolerance), this.downSampleRate));
   end
   
   
   attributes = zeros(dataLength, size(this.tactile{1}, 2));
   target = zeros(dataLength,1);
   
   attributes(1:length(this.tactile{1}), :) = this.tactile{1}(:, :);
   target(1:length(this.ft{1}), 1) = this.ft{1}(:, 3) * this.targetScale ;
   
   startIndex = length(this.tactile{1}) + 1;
   for dataset = 2:maxSet
       
      newAtt = downsample(this.tactile{dataset}(abs(this.forceEstimate{dataset} - this.ft{dataset}(:,3)) > this.tolerance, :), this.downSampleRate);
      newFt  = downsample(this.ft{dataset}(abs(this.forceEstimate{dataset} - this.ft{dataset}(:,3)) > this.tolerance, 3), this.downSampleRate);
      
      attributes(startIndex : (length(newAtt) + startIndex -1), :) = newAtt;
      target(startIndex:(length(newAtt) + startIndex - 1), :) = newFt * this.targetScale ;
      startIndex = startIndex + length(newAtt);
   end
    
end

end
