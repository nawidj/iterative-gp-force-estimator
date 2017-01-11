function [mean, var] = estimateForce(this, setNum)

jobID = 2;

outputTesting = zeros(size(this.tactile{setNum}, 1),1); % dummy to help me evalate

gurls(this.tactile{setNum}, outputTesting , this.gpModel, jobID);
mean = this.gpModel.pred.means / this.targetScale;
var = this.gpModel.pred.vars;

end