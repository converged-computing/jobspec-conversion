#!/bin/bash
#SBATCH --output=smac-run.out
#SBATCH --error=smac-run.err
#SBATCH --mail-user=sy6u19@soton.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=1-00:05:00
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --array=1-2

module load python/3.7.3
source env/bin/activate
cd $HOME/cmlsga-jmetalpy
python src/tuning.py nsgaii ZDT${SLURM_ARRAY_TASK_ID} ga
