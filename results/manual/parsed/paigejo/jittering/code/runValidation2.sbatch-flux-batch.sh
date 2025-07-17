#!/bin/bash
#FLUX: --job-name=runValidation2
#FLUX: --queue=CPUQ
#FLUX: -t=259200
#FLUX: --urgency=16

module load R/4.2.1-foss-2022a
module load GDAL/3.5.0-foss-2022a
Rscript --verbose runValidation2.R ${SLURM_ARRAY_TASK_ID} > runValidation2_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.Rout
