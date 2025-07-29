#!/bin/bash
#SBATCH --job-name=EEE2c100_12cores
#SBATCH --account=r00312
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --mail-user=vjadhao@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=general
#SBATCH --constraint=ntasks-per-node=12

module load lammps/29Oct20
cd      $SLURM_SUBMIT_DIR
time srun -n 12 lmp_mpi < in.lammps.template
