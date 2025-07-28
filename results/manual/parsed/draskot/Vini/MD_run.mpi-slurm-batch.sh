#!/bin/bash
#FLUX: --job-name=MD_run
#FLUX: -N=4
#FLUX: --queue=computes_thin
#FLUX: --urgency=16

NULL=0   #checking if MD_prep job finished or an error occured
error=0 ; echo $error > error 
while [ ! -e nvt.tpr ]
do
    sleep 1
    grep error MD_prep.out > tmp
    nolines=`wc -l < $WORKDIR/tmp`
    if [ $nolines -gt $NULL]
    then 
        error=1 ; echo $error > error
        break
    fi
done
if  [ $error -eq $NULL ] #run MD_run job only if MD_prep job finished sucesfully
then
    mpirun -np $SLURM_NTASKS gmx_mpi mdrun -backup -deffnm nvt
    mpirun -np $SLURM_NTASKS gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
    mpirun -np $SLURM_NTASKS gmx_mpi mdrun -backup -deffnm npt
    mpirun -np $SLURM_NTASKS gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
    mpirun -np $SLURM_NTASKS gmx_mpi mdrun -backup -deffnm md_0_1 #run MD
fi
