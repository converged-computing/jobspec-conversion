#!/bin/bash
#SBATCH --job-name=PANDA
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --mail-user=jwhitlock@uab.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=255000
#SBATCH --time=12:00:00
#SBATCH --array=0-49

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'

module load Singularity/3.5.2-GCC-5.4.0-2.26
wd="/data/user/jbarham3/230227_JW_Setbp1Manuscript"
src="/data/user/jbarham3/230227_JW_Setbp1Manuscript/src/network_scripts/PANDA" #be sure that your subdirectories are structured the same
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'
cd ${wd}
SAMPLE_LIST="${wd}/results/array_inputs/Setbp1_PANDA_files_array.txt" #note: make sure path and file name are correct
SAMPLE_ARRAY=(`cat ${SAMPLE_LIST}`) # parantheses instruct bash to create a shell array of strings from SAMPLE_LIST
INPUT=`echo ${SAMPLE_ARRAY[$SLURM_ARRAY_TASK_ID]}` #extracts a single input from the array and prints (using echo) it into INPUT variable, each single input is then assigned an array number by $SLURM_TASK_ID
singularity exec --cleanenv --containall -B ${wd} ${wd}/bin/PANDA_docker/setbp1_manuscript_panda_1.0.1_latest.sif Rscript --vanilla ${src}/02_PANDA.R ${INPUT} # here vanilla ensures only the script is run and environment is kept clean
