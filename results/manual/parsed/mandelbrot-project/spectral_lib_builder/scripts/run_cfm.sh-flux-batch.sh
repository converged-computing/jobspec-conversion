#!/bin/bash
#FLUX: --job-name=loopy-pedo-4307
#FLUX: --queue=public-cpu
#FLUX: -t=345600
#FLUX: --urgency=16

ml GCC/9.3.0 Singularity/3.7.3-Go-1.14
printf -v FILE_INDEX "%04d" ${SLURM_ARRAY_TASK_ID}
FILE=smiles/smiles-${FILE_INDEX}.txt
srun singularity run cfm-4/cfm.sif -c "cfm-predict $FILE 0.001 /trained_models_cfmid4.0/[M+H]+/param_output.log /trained_models_cfmid4.0/[M+H]+/param_config.txt 1 posout 0 0"
