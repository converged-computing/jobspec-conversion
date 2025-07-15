#!/bin/bash
#FLUX: --job-name=ggr
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

module load R/3.4.0 
module load java/1.8.0_131
module load python/3.6.1
source ~/.bashrc
source activate ggr_env
TMP_DIR=$L_SCRATCH
WORK_DIR=$PI_SCRATCH/users/dskim89/ggr/v1.1.0
echo $SLURM_JOB_CPUS_PER_NODE
ggr --cluster sherlock --threads $SLURM_JOB_CPUS_PER_NODE --out_dir $TMP_DIR
rsync -avz --progress $TMP_DIR/ $WORK_DIR/
