#!/bin/bash
#FLUX: --job-name=purple-poo-0887
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MDRUN='gmx_mpi mdrun'

ml purge > /dev/null 2>&1
ml GCC/10.2.0  OpenMPI/4.0.5
ml GROMACS/2021
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MDRUN='gmx_mpi mdrun'
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
mpirun -np $SLURM_NTASKS $MDRUN $mdargs -dlb yes  -v -deffnm step4.1_equilibration
