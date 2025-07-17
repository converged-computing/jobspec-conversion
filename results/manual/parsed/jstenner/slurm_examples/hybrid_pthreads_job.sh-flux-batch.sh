#!/bin/bash
#FLUX: --job-name=hybrid_job_test
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=4
#FLUX: -t=300
#FLUX: --urgency=16

echo "Date start        = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo ""
module load intel/2019 openmpi/4.0.0 raxml-ng
srun --mpi=pmix_v2 raxml-ng-mpi --all --msa /data/training/SLURM/dna.phy \
     --model GTR+G --threads $SLURM_CPUS_PER_TASK --prefix=./test
echo ""
echo "Date end         = $(date)"
