#!/bin/bash
#FLUX: --job-name=hello-leg-5088
#FLUX: -c=32
#FLUX: --urgency=16

export SLURM_GPUS_PER_NODE='1'
export LD_LIBRARY_PATH='lib/$CONDA_PREFIX/:$LD_LIBRARY_PATH'
export NFFDIR='$HOME/repo/nff/master/NeuralForceField'
export PYTHONPATH='$NFFDIR:$PYTHON_PATH'

source deactivate
source ~/.bashrc
CONFIG="config/cp3d_single_cov2_gen.json"
export SLURM_GPUS_PER_NODE=1
export LD_LIBRARY_PATH=lib/$CONDA_PREFIX/:$LD_LIBRARY_PATH
export NFFDIR="$HOME/repo/nff/master/NeuralForceField"
export PYTHONPATH=$NFFDIR:$PYTHON_PATH
source activate nff
cmd="python run_hyperopt.py --config_file $CONFIG"
echo $cmd
eval $cmd
