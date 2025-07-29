#!/bin/bash
#SBATCH --job-name=annotate
#SBATCH --account=eqb@a100
#SBATCH --output=out/annotate_0_context_child_turns.out
#SBATCH --error=out/annotate_0_context_child_turns.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

export PYTHONPATH='.'

module purge
module load cpuarch/amd
module load python/3.8.2
conda activate /linkhome/rech/genzuo01/uez75lm/.conda/envs/childes-grammaticality
cd $WORK/childes-contingency
export PYTHONPATH=.
set -x
TRANSFORMERS_OFFLINE=1
model=lightning_logs/version_399240
model_type=child
python -u nn/annotate_contingency_nn.py --model $model --model-type $model_type
