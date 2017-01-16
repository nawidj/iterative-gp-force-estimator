function plotForceEstimate(this, forceEstimate, variance, nSet, figNum)
if(this.nSets < 1)
    fprintf('Cannot plot there is no data\n');
end


inTraining = zeros(length(this.ft{nSet}), 1);
maxVal = max(this.ft{nSet}(:,3)) + 1;
inTraining(abs(this.ft{nSet}(:,3) - this.forceEstimate{nSet}) > this.tolerance * 2) = maxVal;

figH = figure(figNum);
subplot(10,1,1:4)
dsRate = 25;
forceEstimate = downsample(forceEstimate, dsRate);
variance = downsample(variance, dsRate);

x = 1:length(forceEstimate);



plot([downsample(this.ft{nSet}(:,3), dsRate), forceEstimate], 'linewidth', 2);
set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);

%xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
%ylabel('Force [N]', 'fontsize', 30, 'interpreter', 'tex');
title('Force [N] vs Samples ', 'fontsize', 30, 'interpreter', 'tex');
set(gca, 'fontsize', 25)
hold on;
patch([x fliplr(x)],[transpose(forceEstimate + variance), fliplr( transpose(forceEstimate - variance))], 'red', 'FaceAlpha', 0.15, 'LineStyle', 'none');
hold off;
legend('Ground truth', 'Force estimate');
axis tight;

hold on
area(downsample(inTraining, this.downSampleRate), 0, 'FaceColor', [1, 0.6, 0.78], 'LineStyle', 'none');
alpha(0.4);
hold off

subplot(10,1,6:7)
plot(downsample(this.tactile{nSet}, dsRate),  'linewidth', 2);
set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);
%xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
%ylabel('Tactile respone [arbitrary]', 'fontsize', 30, 'interpreter', 'tex');
title('Tactile responses [arbitrary] vs Samples', 'fontsize', 30, 'interpreter', 'tex');
set(gca, 'fontsize', 25)
axis tight;

subplot(10,1,9:10)
binVector = [-2:this.tolerance:-this.tolerance, 0:this.tolerance:2  ];
[counts, binValues] = hist(forceEstimate - downsample(this.ft{nSet}(:,3), dsRate), binVector);
normalisedCounts = 100 * counts / sum(counts);
bar(binValues, normalisedCounts, 'barwidth', 1, 'histc');
withinTol = 0;
for i = -this.tolerance:this.tolerance:this.tolerance;
withinTol = withinTol + sum(normalisedCounts(binValues == i));
end
title(sprintf('Error histogram [\\%%], bin size = %0.2f Newton, within tolerance %0.2f \\%%', this.tolerance, withinTol), 'fontsize', 35, 'interpreter', 'latex');
%ylabel('[\%]','fontsize', 35, 'interpreter', 'latex');
xlabel('Error [N] = predicted - target','fontsize', 35, 'interpreter', 'latex');
set(gca, 'fontname', 'Bitstream Charter','fontsize', 25);
axis tight;


end