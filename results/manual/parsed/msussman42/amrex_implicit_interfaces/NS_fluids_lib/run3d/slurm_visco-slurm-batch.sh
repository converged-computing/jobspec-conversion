#!/bin/bash
#SBATCH --job-name=visco_fabric_drop
#SBATCH --output=run.out
#SBATCH --error=run.err
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=YEAR2022,amd

pwd;hostname;date
echo "running amrMPI (FABRIC) on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS tasks, each with $SLURM_CPUS_PER_TASK cores."
module purge
module load gnu/11.2.1 
module load openmpi
srun /gpfs/research/engineering/Kshoele/FabricDrop_New_20240120/amrex_implicit_interfaces/NS_fluids_lib/amr3d.gnu.FLOAT.MPI.ex inputs.FABRIC_DROP_viscoelastic
