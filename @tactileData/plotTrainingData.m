function plotTrainingData(this, nSet, figNum)
if(this.nSets < 1)
    fprintf('Cannot plot there is no data\n');
end

% % % % figH = figure(figNum);
% % % % subplot(3,1,1)
% % % % plot(downsample(this.tactile{nSet}, this.downSampleRate),  'linewidth', 2);
% % % % set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);
% % % % %xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
% % % % %ylabel('Tactile respone [arbitrary]', 'fontsize', 30, 'interpreter', 'tex');
% % % % title('Tactile responses', 'fontsize', 30, 'interpreter', 'tex');
% % % % set(gca, 'fontsize', 25)
% % % % axis tight
% % % % 
% % % % subplot(3,1,2)
% % % % plot(downsample(this.getTrainingSet(nSet), this.downSampleRate),  'linewidth', 2);
% % % % set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);
% % % % %xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
% % % % %ylabel('Tactile respone [arbitrary]', 'fontsize', 30, 'interpreter', 'tex');
% % % % title('Tactile responses training set', 'fontsize', 30, 'interpreter', 'tex');
% % % % set(gca, 'fontsize', 25)
% % % % axis tight
% % % % 
inTraining = zeros(length(this.ft{nSet}), 1);
maxVal = max(this.ft{nSet}(:,3)) + 1;
inTraining(abs(this.ft{nSet}(:,3) - this.forceEstimate{nSet}) > this.tolerance) = maxVal;
% % % % 
% % % % subplot(3,1,3)
plot(downsample([this.ft{nSet}(:,3), this.forceEstimate{nSet}], this.downSampleRate),  'linewidth', 2);
set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);
%xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
%ylabel('Tactile respone [arbitrary]', 'fontsize', 30, 'interpreter', 'tex');
title('estimate vs target', 'fontsize', 30, 'interpreter', 'tex');
legend('Target', 'Estimate');
set(gca, 'fontsize', 25)
axis tight


hold on
area(downsample(inTraining, this.downSampleRate), 0, 'FaceColor', [1, 0.6, 0.78], 'LineStyle', 'none');
alpha(0.4);
hold off

end