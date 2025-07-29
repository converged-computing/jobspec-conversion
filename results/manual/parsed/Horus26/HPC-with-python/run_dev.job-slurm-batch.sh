#!/bin/bash
#SBATCH --job-name=HPC_WITH_PYTHON
#SBATCH --output=HPC_OUTPUT.out
#SBATCH --error=HPC_ERROR.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6gb
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=40

module load devel/python/3.10.0_gnu_11.1
module load compiler/gnu/12.1
module load mpi/openmpi/4.1
module list
echo "Running on ${SLURM_JOB_NUM_NODES} nodes with ${SLURM_JOB_CPUS_PER_NODE} cores each."
echo "Each node has ${SLURM_MEM_PER_NODE} of memory allocated to this job."
time mpirun python3 Milestone7_Parallelization_Dev.py
