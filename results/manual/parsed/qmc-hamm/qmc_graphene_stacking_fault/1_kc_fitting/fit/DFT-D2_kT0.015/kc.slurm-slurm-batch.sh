#!/bin/bash
#SBATCH --job-name=fit/DFT-D2_kT0.015
#SBATCH --output=fit/DFT-D2_kT0.015/kc.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=14:00:00

export ASE_LAMMPSRUN_COMMAND='/home/krongch2/projects/lammps/lammps/src/lmp_mpi'

echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
export ASE_LAMMPSRUN_COMMAND=/home/krongch2/projects/lammps/lammps/src/lmp_mpi
python -u kc.py --method DFT-D2 -kT 0.015
