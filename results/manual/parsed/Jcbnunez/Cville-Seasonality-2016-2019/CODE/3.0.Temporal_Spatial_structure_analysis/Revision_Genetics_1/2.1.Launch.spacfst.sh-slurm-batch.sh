#!/bin/bash
#SBATCH --job-name=spacfst
#SBATCH --output=./slurmOut/spacfst.%A_%a.out
#SBATCH --error=./slurmOut/spacfst.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --partition=bluemoon
#SBATCH --array=1-999

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
spack load openjdk@11.0.15_10
Rscript \
2.spatial.fst.stability.R \
${SLURM_ARRAY_TASK_ID} \
0
if [ ${SLURM_ARRAY_TASK_ID} -le 436 ]
then
echo "shift activated!"
Rscript \
2.spatial.fst.stability.R \
${SLURM_ARRAY_TASK_ID} \
999
fi
echo "done"
date
