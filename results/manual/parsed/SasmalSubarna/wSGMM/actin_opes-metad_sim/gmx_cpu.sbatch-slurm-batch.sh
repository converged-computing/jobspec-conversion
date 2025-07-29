#!/bin/bash
#SBATCH --job-name=ld1-dihedral-bias-opes_actin
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=2-12:00:00
#SBATCH --constraint=ntasks-per-node=32

source /scratch/work/hockygroup/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules.triasha
gmxexe=/scratch/work/hockygroup/software/gromacs-2019.6-plumedSept2020/bin/gmx_mpi
srun $gmxexe mdrun -s actin-gatpu_ionized_npt_20ns_every50ps-g5.1.4_5mus.tpr -deffnm opes_ld1_bf_12.0_barrier_15.0 -plumed plumed.dat -cpi opes_ld1_bf_12.0_barrier_15.0.cpt -append -nsteps 25000000 -ntomp 1
