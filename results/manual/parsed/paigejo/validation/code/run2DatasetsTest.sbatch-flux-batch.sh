#!/bin/bash
#FLUX: --job-name=run2DatasetsTest
#FLUX: --queue=CPUQ
#FLUX: -t=60
#FLUX: --urgency=16

module load R/4.2.1-foss-2022a
module load GDAL/3.5.0-foss-2022a
Rscript --verbose run2DatasetsTest.R ${SLURM_ARRAY_TASK_ID} > run2DatasetsTest_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.Rout
