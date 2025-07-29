#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=28000
#SBATCH --time=04:00:00
#SBATCH --partition=amd

let START=$SLURM_ARRAY_TASK_ID*$N_PER_JOB
let END=$START+${N_PER_JOB}-1
for SUB_JOB_NUM in `seq $START $END`
do
	cd $SUB_JOB_NUM
	${ANTIGEN_ROOT}/run.py > "out.bashscreen"
	excessDiversityFile="out.tmrcaLimit"
	extinctFile="out.extinct"
	../../process_job.py $SUB_JOB_NUM
	../../Rscript convert.R $SUB_JOB_NUM
	cd ../
done
