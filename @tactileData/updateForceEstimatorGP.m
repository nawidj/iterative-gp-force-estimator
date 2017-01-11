function updateForceEstimatorGP(this, maxSet)

name = sprintf('iteration_%02d', maxSet);
this.gpModel = getGPModel(this, name);
jobID = 1;


% Get the training data
[input, target] = this.getTrainingSet(maxSet, this.tolerance, this.targetScale, this.downSampleRate);
gurls(input, target, this.gpModel, jobID);


end

function gpModel = getGPModel(this, name)

gpModel = gurls_defopt(name);
gpModel.seq = {'split:ho', 'paramsel:siglamhogpregr', 'kernel:rbf',...
    'rls:gpregr', 'predkernel:traintest', 'pred:gpregr'};
gpModel.process{1} = [2,2,2,2,1,1];
gpModel.process{2} = [3,3,3,3,2,2];
gpModel.epochs = this.epochs;
gpModel.hoperf = @perf_abserr;
gpModel.save = -1;
gpModel.nholdouts = this.nholdouts;
gpModel.hoproportion = 0.1;
gpModel.verbose = 1;
end

function normalised = normalise(data)
normalised = (data(:, end) - min(data(:,end)))/...
    (max(data(:,end)) - min(data(:, end)));
end
