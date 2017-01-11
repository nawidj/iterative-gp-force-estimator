function plotData(this, nSet, figNum)
if(this.nSets < 1)
    fprintf('Cannot plot there is no data\n');
end

figH = figure(figNum);
subplot(2,1,1)
plot(this.ft{nSet}(:,3), 'linewidth', 2);
set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);
legend('FT z-axis');
xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
ylabel('Force [N]', 'fontsize', 30, 'interpreter', 'tex');
title('Force ', 'fontsize', 30, 'interpreter', 'tex');
set(gca, 'fontsize', 25)


subplot(2,1,2)
plot(this.tactile{nSet},  'linewidth', 2);
set(gca, 'fontname', 'Bitstream Charter','fontsize', 10);
xlabel('Samples','fontsize', 30, 'interpreter', 'tex')
ylabel('Tactile respone [arbitrary]', 'fontsize', 30, 'interpreter', 'tex');
title('Tactile responses', 'fontsize', 30, 'interpreter', 'tex');
set(gca, 'fontsize', 25)

end