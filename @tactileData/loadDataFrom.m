function loadDataFrom(this, expDir, setList)


%this.nSets = 0;
clear this.tactile this.ft this.forceEstimate;

for whichSet = setList
    this.nSets = this.nSets +1;
    ft = dlmread(sprintf('%s/%s_%s/ft_%05d/data.log', expDir,...
        this.whichHand, this.whichFinger, whichSet));
    tactile = dlmread(sprintf('%s/%s_%s/taxel_%05d/data.log', expDir,...
        this.whichHand, this.whichFinger, whichSet));
    forceEstimate = dlmread(sprintf('%s/%s_%s/forceEstimate_%05d/data.log', expDir,...
        this.whichHand, this.whichFinger, whichSet));
    
    % Align the data
    startIndex = 1;
    endIndex = length(tactile);
    [ft, startNan, endNan] =  myResample(ft(:,2:end),tactile(:,2:end));
    
    if(startIndex < startNan); startIndex = startNan; end;
    if(endIndex > endNan); endIndex = endNan; end;
    
    [forceEstimate, startNan, endNan] =  myResample(forceEstimate(:,2:end),tactile(:,2:end));
    
    if(startIndex < startNan); startIndex = startNan; end;
    if(endIndex > endNan); endIndex = endNan; end;
    
    
    ft = ft(startIndex:endIndex, :);
    forceEstimate = forceEstimate(startIndex:endIndex, :);
    tactile = tactile(startIndex:endIndex, 3:end);
    
    % invert ft
    ft(:, 3) = -ft(:,3); %max(ft(:,3)) - ft(:, 3);
    
    % bias ft
    ft = ft - repmat(mean(ft(1:10,:)),length(ft), 1);
    
    
    
    
    this.ft{this.nSets} = ft(:, 1:3);
    this.tactile{this.nSets} = tactile;
    this.forceEstimate{this.nSets} = forceEstimate;
    
    
    
end