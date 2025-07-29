#!/bin/bash
#SBATCH --job-name=VQA
#SBATCH --account=k1216
#SBATCH --output=./log/%j.out
#SBATCH --error=./log/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --time=09:00:00
#SBATCH --partition=workq
#SBATCH --chdir=/scratch/alfadlmm/
#SBATCH --array=0-798

export PATH='/scratch/alfadlmm/miniconda2/bin:$PATH'

module purge		# clean up loaded modules 
module load slurm
export PATH="/scratch/alfadlmm/miniconda2/bin:$PATH"
source activate vqa
for i in {0..14}
do
	srun python solve.py $i &
done
wait
