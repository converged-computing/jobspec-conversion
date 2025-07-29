#!/bin/bash
#SBATCH --job-name=milestoning
#SBATCH --account=andricio_lab
#SBATCH --error=slurm-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=3-00:00:00

module load cuda/10.1.243
module load namd/2.14b2/gcc.8.4.0-cuda.10.1.243
source /data/homezvol2/dray1/Miniconda2/etc/profile.d/conda.sh
source env.sh
mv west.log west.log.old 
rm binbounds.txt
$WEST_ROOT/bin/w_run -r west.cfg --work-manager processes --n-workers 1 "$@" &> west.log
