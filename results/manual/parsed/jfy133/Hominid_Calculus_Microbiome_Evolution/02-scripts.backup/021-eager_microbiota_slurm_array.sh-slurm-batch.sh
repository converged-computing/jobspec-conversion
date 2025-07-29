#!/bin/bash
#SBATCH --job-name=EAGER_SlurmArray
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32000
#SBATCH --time=00:47:00
#SBATCH --array=0-199%8

FILES=($(find -L 04-analysis/screening/EMN_Neanderthal_phylogeny_check/eager/output -name '*OFN*' -type d))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
unset DISPLAY && eagercli ${FILENAME}
