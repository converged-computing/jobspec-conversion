#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=300G
#SBATCH --time=6-22:40:00
#SBATCH --partition=sched_mit_rafagb_amd,sched_mit_rafagb
#SBATCH --constraint=ntasks-per-node=1
#SBATCH: --no-requeue

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
