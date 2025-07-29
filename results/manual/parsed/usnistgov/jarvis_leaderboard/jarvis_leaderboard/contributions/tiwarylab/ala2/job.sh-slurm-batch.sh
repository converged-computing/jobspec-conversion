#!/bin/bash
#SBATCH --job-name=md
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=RM-shared
#SBATCH --constraint=ntasks-per-node=1

module load gromacs/2020.2-cpu
cpu=$SLURM_NPROCS
sys="AD"
gmx_mpi grompp -f pro.mdp -p ${sys}.top -c NVT_eq.pdb -r NVT_eq.pdb -o pro.tpr -maxwarn 5
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -deffnm md -s pro.tpr -ntomp 8
exit
