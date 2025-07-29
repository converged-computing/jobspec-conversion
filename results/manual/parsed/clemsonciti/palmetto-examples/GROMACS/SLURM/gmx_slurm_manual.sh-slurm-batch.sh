#!/bin/bash
#SBATCH --job-name=GROMACS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=22G
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=2

cd $SLURM_SUBMIT_DIR
source /home/$USER/software/gromacs-2023.3/build_slurm/gmx/bin/GMXRC
module load openmpi/4.1.5 intel-oneapi-mkl/2022.2.1 anaconda3/2022.10 
echo number of MPI processes is $SLURM_NTASKS
srun gmx_mpi grompp -f rf_verlet.mdp -p topol.top -c conf.gro -o em.tpr
srun gmx_mpi mdrun -s em.tpr -deffnm job-output
