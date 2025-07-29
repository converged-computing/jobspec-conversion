#!/bin/bash
#SBATCH --job-name=Nonlocal_Grad_Enhance
#SBATCH --account=p32089
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=04:00:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=25
#SBATCH --exclude=qnode0565,qnode0626,qnode0637,qnode0019

script_name="Notched_Tensile_Test.i"
module purge
module use /software/spack_v20d1/spack/share/spack/modules/linux-rhel7-x86_64/
module load singularity
module load mpi/mpich-4.0.2-gcc-10.4.0
mpiexec -np ${SLURM_NTASKS} singularity exec -B /projects:/projects -B /scratch:/scratch -B /projects/p32089/singularity/moose/moose:/opt/moose /projects/p32089/singularity/moose_latest.sif /projects/p32089/MOOSE_Applications/purple/purple-opt -i ${script_name}
