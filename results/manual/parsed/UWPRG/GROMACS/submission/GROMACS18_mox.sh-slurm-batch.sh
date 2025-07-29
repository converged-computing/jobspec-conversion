#!/bin/bash
#SBATCH --job-name=*CHANGE*
#SBATCH --account=pfaendtner
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=28

cd $SLURM_SUBMIT_DIR
module load icc_17-impi_2017
source /gscratch/pfaendtner/sarah/codes/gromacs18.3/gromacs-2018.3/bin/bin/GMXRC
source /gscratch/pfaendtner/sarah/scripts/activate_plumed2.4.2.sh
mpiexec.hydra -np 28 gmx_mpi mdrun -s topol.tpr -o traj.trr -x traj.xtc -cpi restart -cpo restart -c confout.gro -e ener.edr -g md.log -ntomp 1
exit 0
