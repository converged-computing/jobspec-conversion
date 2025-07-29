#!/bin/bash
#SBATCH --job-name=E2
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --mail-user=vjadhao@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=general
#SBATCH --constraint=ntasks-per-node=48

module swap PrgEnv-intel PrgEnv-gnu
module load lammps/gnu
cd      $SLURM_SUBMIT_DIR
time srun -n 48 lmp_mpi < in.lammps.template
