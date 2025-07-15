#!/bin/bash
#FLUX: --job-name=IoTwinsTest
#FLUX: -n=8
#FLUX: -t=172800
#FLUX: --priority=16

if [ $# -lt 1 ]; then
  echo "Usage: MNBatchScript_IoTwins-mpi-{X}K.cmd numberOfAgents"
  echo "* numberOfAgents: the number of agents to simulate."
  exit 0
fi
numberOfAgents="$1"
numberOfSteps="$2"
modelName="IoTwins"
experimentID="$SLURM_JOBID"
numberOfTasks="$SLURM_NTASKS"
configFileName="config-${numberOfAgents}A-${numberOfSteps}S-${numberOfTasks}K.xml"
python updateXMLConfigFileOutputPaths.py $modelName $configFileName $experimentID
module purge
module load singularity/3.5.2
module load impi/2017.4           # Intel MPI implementation
singularity exec -B $DEPLOYMENT_PATH/PANDORA/install/lib:/.singularity.d/libs --pwd $DEPLOYMENT_PATH/PANDORA/scripts/compileAndExecScripts/ $DEPLOYMENT_PATH/genajim_pandora.sif ./3-execModel-mpi-mn4.cmd $modelName $configFileName $numberOfTasks
echo "Simulation finished # ${experimentID}."
