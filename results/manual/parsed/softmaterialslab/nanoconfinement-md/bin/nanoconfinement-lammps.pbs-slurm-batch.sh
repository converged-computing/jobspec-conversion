#!/bin/bash
#SBATCH --job-name=10_1_-1_0.2_0.2_0.1_-0.01
#SBATCH --account=r00458
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --mail-user=fanbsun@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=24

export OMP_NUM_THREADS='1'

module load lammps/2Aug2023
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1
time srun -n 96 -d 1 lmp_mpi < in.lammps
