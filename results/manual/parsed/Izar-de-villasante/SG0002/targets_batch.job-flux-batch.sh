#!/bin/bash
#FLUX: --job-name=RNASeq_nf
#FLUX: -c=90
#FLUX: -t=439200
#FLUX: --urgency=16

module load singularity-3.8.3-gcc-11.2.0-rlxj6fi
cd $SLURM_SUBMIT_DIR
singularity exec /mnt/beegfs/idevillasante/apps/rocker/images/meth-dev.sif ./run.R -s multicore -n $SLURM_JOB_CPUS_PER_NODE  >& slurm-batch-job.out
