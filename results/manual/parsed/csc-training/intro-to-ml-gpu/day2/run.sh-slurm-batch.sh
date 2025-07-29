#!/bin/bash
#SBATCH --account=project_2003528
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=00:15:00
#SBATCH --partition=gpu

PYTHON=python3
if [ -n "$SING_IMAGE" ]; then
    PYTHON="singularity_wrapper exec python3"
    echo "Using Singularity image $SING_IMAGE"
fi
module list
set -xv
$PYTHON $*
