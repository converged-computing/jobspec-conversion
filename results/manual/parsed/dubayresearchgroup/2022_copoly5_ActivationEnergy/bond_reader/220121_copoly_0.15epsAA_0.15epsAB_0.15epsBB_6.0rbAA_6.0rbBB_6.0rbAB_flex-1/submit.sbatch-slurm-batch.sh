#!/bin/bash
#SBATCH --account=dubayhamblin
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=20

module load gcc/7.1.0 python/3.6.8 ffmpeg intel/18.0 intelmpi/18.0 cuda pgi openmpi
cd $SLURM_SUBMIT_DIR
echo `pwd`
mpiexec -np 20 /home/rh3bf/mylammps/build/lmp -i run.lmp
