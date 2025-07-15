#!/bin/bash
#FLUX: --job-name=WildTypeSimulation
#FLUX: -t=108000
#FLUX: --urgency=16

echo 'Task ID is:'
echo ${SLURM_ARRAY_TASK_ID}
echo 'Job ID is:'
echo ${SLURM_ARRAY_JOB_ID}
Master=/home/USER/WholeCell-master/WholeCell-master
OutDir=/projects/flex1/USER/output/PROJECTFOLDER/WildTypeSimulation
Experiment='WildTypeSimulation'
Sim=${SLURM_ARRAY_TASK_ID}
SeedInc=${SLURM_ARRAY_TASK_ID}
mkdir -p ${OutDir}/${Experiment}/${Sim}
cd ${Master}
module load apps/matlab-r2013a
options="-nodesktop -noFigureWindows -singleCompThread"
matlab $options -r "diary('${OutDir}/${Experiment}/${Sim}/diary.out');addpath('${Master}');setWarnings();setPath();runSimulation('runner','MGGRunner','logToDisk',true,'outDir','${OutDir}/${Experiment}/${Sim}','seedIncrement','${SeedInc}');diary off;exit;"
cd ${OutDir}/${Experiment}/${Sim}
if [ -f "state-0.mat" ]; then
	# Load the matlab module 
	module load apps/matlab-r2013a
	# Set matlab options to a variable 
	options="-nodesktop -noFigureWindows -singleCompThread"
	# Run the analysis with matlab options
	# Add Master Directory to Path, runGraphs produces a set of 4x2 graphs which are initial analysis of the data, compareGraphs overlays runGraphs output on a WildType of 200 wildtype simulations
	matlab $options -r "addpath('${Master}');runGraphsWildType('${Experiment}','${Sim}');exit;"
fi
