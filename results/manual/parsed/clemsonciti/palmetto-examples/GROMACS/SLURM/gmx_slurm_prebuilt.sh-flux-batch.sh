#!/bin/bash
#FLUX: --job-name=red-motorcycle-5341
#FLUX: -c=6
#FLUX: -t=900
#FLUX: --priority=16

export OMP_NUM_THREADS='6'

cd $SLURM_SUBMIT_DIR
module purge
module use /software/ModuleFiles/modules/linux-rocky8-x86_64/
module load gromacs/2021.5-gcc/9.5.0-openmpi/4.1.3-mpi-openmp-cu11_1
export OMP_NUM_THREADS=6
srun gmx_mpi grompp -f rf_verlet.mdp -p topol.top -c conf.gro -o em.tpr
echo number of MPI processes is $SLURM_NTASKS
mpirun -np $SLURM_NTASKS -npernode 2 gmx_mpi mdrun -s em.tpr -deffnm job-output
