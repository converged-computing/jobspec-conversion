#!/bin/bash
#SBATCH --job-name=sample_job
#SBATCH --account=pXXXX
#SBATCH --output=outlog_mpi_smp_2_node
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=14,[quest8|quest9|quest10|quest11]

module purge all
module load namd/2.14-openmpi-4.0.5-intel-19.0.5.281 
srun -n ${SLURM_NNODES} namd2 ++ppn $((${SLURM_NTASKS_PER_NODE}-1)) alanin.conf
