#!/bin/bash
#FLUX: --job-name=GROMACS
#FLUX: -c=6
#FLUX: -t=900
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
source /home/$USER/software/gromacs-2023.3/build_slurm/gmx/bin/GMXRC
module load openmpi/4.1.5 intel-oneapi-mkl/2022.2.1 anaconda3/2022.10 
echo number of MPI processes is $SLURM_NTASKS
srun gmx_mpi grompp -f rf_verlet.mdp -p topol.top -c conf.gro -o em.tpr
srun gmx_mpi mdrun -s em.tpr -deffnm job-output
