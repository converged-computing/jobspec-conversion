#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=00:20:00

module load matlab/R2018a
cd $HOME/data/ravi/spect-pitch-gan
matlab  -nodisplay -nosplash -r "generate_momenta $SLURM_ARRAY_TASK_ID cmu-arctic train;"
echo "matlab exit code: $?"
