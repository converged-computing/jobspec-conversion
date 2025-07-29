#!/bin/bash
#SBATCH --job-name=RNASeq_nf
#SBATCH --output=R-_%j.log
#SBATCH --error=R-_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=100
#SBATCH --time=5-02:00:00

module load singularity-3.8.3-gcc-11.2.0-rlxj6fi
cd $SLURM_SUBMIT_DIR
singularity exec /mnt/beegfs/idevillasante/apps/rocker/images/meth-dev.sif ./run.R -s multicore -n $SLURM_JOB_CPUS_PER_NODE  >& slurm-batch-job.out
