#!/bin/bash
#SBATCH --job-name=VB_nmRec
#SBATCH --account=IscrC_Meta-Rec
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='8'

module load profile/lifesc
module unload fftw
module load gromacs/2021.7--openmpi--4.1.4--gcc--11.3.0-cuda-11.8
export OMP_NUM_THREADS=8
echo -n "Starting Script at: "
date
wait
gmx_mpi mdrun -s md_Meta.tpr -plumed VB_MetaD.dat -ntomp 8 -v -nb gpu -pme auto -pin off
wait
echo ""
echo "Finished first benchmark for VB meta!!"
echo ""
echo "done at"
date
