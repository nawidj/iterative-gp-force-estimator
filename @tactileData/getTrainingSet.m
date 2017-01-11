function [attributes, target] = getTrainingSet(this, maxSet, tolerence, targetScale, downSampleRate)



% The first set is always included. This is the initial set
if(maxSet == 1)
    attributes = downsample(this.tactile{maxSet}, downSampleRate);
    target = downsample(this.ft{1}(:,3) * targetScale, downSampleRate);
else
   % Estimate the number of data
   dataLength = downsample(length(this.forceEstimate{1}), downSampleRate);
   for dataset = 2:maxSet
       
       dataLength = dataLength + length(downsample(this.forceEstimate{dataset}(abs(this.forceEstimate{dataset}(:,1) - this.ft{dataset}(:,3)) > tolerence), downSampleRate));
   end
   
   
   attributes = zeros(dataLength, size(this.tactile{1}, 2));
   target = zeros(dataLength,1);
   
   attributes(1:length(this.tactile{1}), :) = this.tactile{1}(:, :);
   target(1:length(this.ft{1}), 1) = this.ft{1}(:, 3) * targetScale ;
   
   startIndex = length(this.tactile{1}) + 1;
   for dataset = 2:maxSet
       
      newAtt = downsample(this.tactile{dataset}(abs(this.forceEstimate{dataset} - this.ft{dataset}(:,3)) > tolerence, :), downSampleRate);
      newFt  = downsample(this.ft{dataset}(abs(this.forceEstimate{dataset} - this.ft{dataset}(:,3)) > tolerence, 3), downSampleRate);
      
      attributes(startIndex : (length(newAtt) + startIndex -1), :) = newAtt;
      target(startIndex:(length(newAtt) + startIndex - 1), :) = newFt * targetScale ;
      startIndex = startIndex + length(newAtt);
      
   end
    
end

end
