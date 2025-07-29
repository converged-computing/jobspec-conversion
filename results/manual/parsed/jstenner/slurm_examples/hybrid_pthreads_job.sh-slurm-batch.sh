#!/bin/bash
#SBATCH --job-name=hybrid_job_test
#SBATCH --output=hybrid_test_%j.out
#SBATCH --mail-user=<email_address>
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=100mb
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=4,ntasks-per-socket=2,intel

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
