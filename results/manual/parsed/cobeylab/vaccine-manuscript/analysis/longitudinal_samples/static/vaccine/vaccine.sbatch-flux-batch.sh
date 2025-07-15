#!/bin/bash
#FLUX: --job-name=butterscotch-lettuce-8242
#FLUX: --queue=amd
#FLUX: -t=14400
#FLUX: --priority=16

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
