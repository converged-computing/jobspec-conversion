#!/bin/bash

# Generated by CHARMM-GUI (http://www.charmm-gui.org) v3.7
#
# This folder contains GROMACS formatted CHARMM36 force fields, a pre-optimized PDB structure, and GROMACS inputs.
# All input files were optimized for GROMACS 2019.2 or above, so lower version of GROMACS can cause some errors.
# We adopted the Verlet cut-off scheme for all minimization, equilibration, and production steps because it is 
# faster and more accurate than the group scheme. If you have a trouble with a performance of Verlet scheme while 
# running parallelized simulation, you should check if you are using appropriate command line.
# For MPI parallelizing, we recommand following command:
# mpirun -np $NUM_CPU mpirun gmx_mpi mdrun -ntomp 1

#SBATCH --job-name=run-gromacs
#SBATCH --nodes=1
#SBATCH --tasks-per-node=48
#SBATCH --mem=16GB
#SBATCH --time=24:00:00

module purge
module load gromacs/openmpi/intel/2020.4


init=step3_input
mini_prefix=step4.0_minimization
equi_prefix=step4.1_equilibration
prod_prefix=step5_production
prod_step=step5

# Minimization
# In the case that there is a problem during minimization using a single precision of GROMACS, please try to use 
# a double precision of GROMACS only for the minimization step.
mpirun -np 1 gmx_mpi grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${init}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn 2
mpirun gmx_mpi mdrun -v -deffnm ${mini_prefix} 


# Equilibration
mpirun -np 1 gmx_mpi grompp -f ${equi_prefix}.mdp -o ${equi_prefix}.tpr -c ${mini_prefix}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn 2
mpirun gmx_mpi mdrun -v -deffnm ${equi_prefix}


# Production
cnt=1
cntmax=10

while [ ${cnt} -le ${cntmax} ]
do
    pcnt=$((${cnt}-1))
    istep=${prod_step}_${cnt}
    pstep=${prod_step}_${pcnt}

    if [ ${cnt} -eq 1 ];then
        pstep=${equi_prefix}
        mpirun -np 1 gmx_mpi grompp -f ${prod_prefix}.mdp -o ${istep}.tpr -c ${pstep}.gro -p topol.top -n index.ndx
    else
        mpirun -np 1 gmx_mpi grompp -f ${prod_prefix}.mdp -o ${istep}.tpr -c ${pstep}.gro -t ${pstep}.cpt -p topol.top -n index.ndx
    fi
    mpirun gmx_mpi mdrun -v -deffnm ${istep}
    cnt=$(($cnt+1))
done
