#!/bin/bash
#SBATCH --output=slurm/many-models/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --array=1

for current_dataset in {1..50}
do
    singularity run -B /scratch,/m,/l,/share /scratch/cs/bayes_ave/stan-triton.sif Rscript ./R/many-irrelevant/fit_many_models.R $1 $current_dataset $2
    # srun Rscript ./R/many-irrelevant/fit_many_models.R $1 $current_dataset $2
done
