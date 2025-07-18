#!/bin/bash
#FLUX: --job-name=anxious-muffin-1278
#FLUX: --exclusive
#FLUX: --queue=genoa
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module load 2022
module load GROMACS/2021.6-foss-2022a
for rep in 1 2 3 4 5
do
mkdir -p rep${rep}
done
rep=${SLURM_ARRAY_TASK_ID}
setenv GMX_MAXCONSTRWARN -1
export OMP_NUM_THREADS=1
if [ -f "rep${rep}/step7_production_rep${rep}.tpr" ]; then
    echo "####################### TPR is defined. Skipping gmx grompp."
else
    # Create TPR:
    echo "####################### TPR not defined. Creating via grompp"
    srun gmx grompp -f step7_production.mdp -o rep${rep}/step7_production_rep${rep}.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx -po rep${rep}/mdout.mdp
fi
if [ -f "rep${rep}/step7_production_rep${rep}.cpt" ]; then
    echo "####################### Using checkpoint"
    mpirun gmx_mpi mdrun -cpi rep${rep}/step7_production_rep${rep}.cpt -deffnm rep${rep}/step7_production_rep${rep} -append -g rep${rep}/rep${rep}_md.log
else
    # If no checkpoint:
    echo "####################### No checkpoint. Starting fresh run"
    mpirun gmx_mpi mdrun -deffnm rep${rep}/step7_production_rep${rep} -cpt 1 -pin on -g rep${rep}/rep${rep}_md.log
fi
