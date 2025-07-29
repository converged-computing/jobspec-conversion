#!/bin/bash
#SBATCH --job-name=OpAL-Star
#SBATCH --account=carney-brainstorm-condo
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=02:00:00
#SBATCH --array=0-999

echo Master process running on `hostname`
echo Directory is `pwd`
echo Starting execution at `date`
echo Current PATH is $PATH
module load graphviz/2.40.1
module load python/3.9.0
module load git/2.29.2
source ~/OpAL/venv/bin/activate
cd /users/jhewson/OpAL/
python main_slurm.py --slurm_id $SLURM_ARRAY_TASK_ID
