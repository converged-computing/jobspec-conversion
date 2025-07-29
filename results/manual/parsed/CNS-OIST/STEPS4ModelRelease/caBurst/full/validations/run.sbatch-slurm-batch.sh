#!/bin/bash
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --array=[1-100%10]

export PYTHONPATH='`spack find --paths /$SPACK_INSTALLED_HASH | tail -n 1 | grep -o "/.*"`:$PYTHONPATH'

set -x
module load unstable python-dev python
export PYTHONPATH=`spack find --paths /$SPACK_INSTALLED_HASH | tail -n 1 | grep -o "/.*"`:$PYTHONPATH
if [[ -z "${steps_version}" ]]
then
  steps_version=4
fi
nodes=$SLURM_JOB_NUM_NODES
ntasks=$(($nodes * 32))
seed=$(($SLURM_ARRAY_TASK_ID * 1))
mesh_fls=../../mesh/split_1024/steps3/CNG_segmented_2_split_1024.msh
time srun --nodes=$nodes --ntasks=$ntasks \
python caBurstFullModel.py $seed $mesh_fls $steps_version
