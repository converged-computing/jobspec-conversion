#!/bin/bash
#FLUX: --job-name=loopy-pedo-2089
#FLUX: -n=64
#FLUX: --queue=genoa
#FLUX: -t=900
#FLUX: --urgency=16

module load 2023
module load GROMACS/2023.3-foss-2023a 
for rep in 1 2 3 4 5
do
mkdir -p rep${rep}
done
rep=${SLURM_ARRAY_TASK_ID}
if [ -f "rep${rep}/step7_production_rep${rep}.tpr" ]; then
    echo "####################### TPR is defined. Skipping gmx grompp."
else
    # Create TPR:
    echo "####################### TPR not defined. Creating via grompp"
    gmx grompp -f step7_production.mdp -o rep${rep}/step7_production_rep${rep}.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx -po rep${rep}/mdout.mdp
fi
if [ -f "rep${rep}/step7_production_rep${rep}.cpt" ]; then
    echo "####################### Using checkpoint"
    mpirun gmx_mpi mdrun -cpi rep${rep}/step7_production_rep${rep}.cpt -deffnm rep${rep}/step7_production_rep${rep} -append -g rep${rep}/rep${rep}_md.log
else
    # If no checkpoint:
    echo "####################### No checkpoint. Starting fresh run"
    mpirun -np 32 gmx_mpi mdrun -deffnm rep${rep}/step7_production_rep${rep} -cpt 1 -pin on -g rep${rep}/rep${rep}_md.log -maxh 0.25 -ntomp 1
fi
