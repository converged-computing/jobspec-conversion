#!/bin/bash
#SBATCH --output=/work_ifs/sukmb447/projects/skin.mgwas/results/2.statistical.tests/1.beta.diversity/log/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16gb

cd $SLURM_SUBMIT_DIR
module load miniconda2/4.6.14
source activate /work_ifs/sukmb447/apps/conda.envs/r.betamgwas
outputfolder=${SLURM_SUBMIT_DIR}"/results"
Rscript test.R $SLURM_ARRAY_TASK_ID $outputfolder
