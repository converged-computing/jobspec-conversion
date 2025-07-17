#!/bin/bash
#FLUX: --job-name=pusheena-hope-5932
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export SLURM_LOADER_LOAD_NO_MPI_LIB='python'

module load 2020
module load cuDNN/8.0.4.30-CUDA-11.0.2
source $HOME/PathToYourVirtualEnv/bin/activate 
export SLURM_LOADER_LOAD_NO_MPI_LIB=python
srun --ear=on python $HOME/PathToYourPythonScript.py --argument $1 --argument $2 --argument $3 --device "gpu"  >> PathToWhereYouWantToSaveWhateverYourScriptPrintToConsole.txt &
wait
