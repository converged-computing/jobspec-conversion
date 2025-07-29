#!/bin/bash
#SBATCH --job-name=trp-cage_AMBER_CHARMM
#SBATCH --mail-user=tje3676@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=3GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gromacs/openmpi/intel/2020.4
init=step3_input
mini_prefix=step4.0_minimization
equi_prefix=step4.1_equilibration
prod_prefix=step5_production
prod_step=step5
mpirun -np 1 gmx_mpi grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${init}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn 2
mpirun gmx_mpi mdrun -v -deffnm ${mini_prefix} 
mpirun -np 1 gmx_mpi grompp -f ${equi_prefix}.mdp -o ${equi_prefix}.tpr -c ${mini_prefix}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn 2
mpirun gmx_mpi mdrun -v -deffnm ${equi_prefix}
cnt=1
cntmax=10
while [ ${cnt} -lt ${cntmax} ]
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
