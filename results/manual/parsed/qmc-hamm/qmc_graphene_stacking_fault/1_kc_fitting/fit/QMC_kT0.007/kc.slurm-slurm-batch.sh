#!/bin/bash
#SBATCH --job-name=kT0.007
#SBATCH --output=kT0.007/kc.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=04:00:00

export ASE_LAMMPSRUN_COMMAND='/home/krongch2/projects/lammps/lammps/src/lmp_mpi'

echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
export ASE_LAMMPSRUN_COMMAND=/home/krongch2/projects/lammps/lammps/src/lmp_mpi
python -u kc.py -kT 0.007
