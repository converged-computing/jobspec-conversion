#!/bin/bash
#FLUX: --job-name=LB-AMBER_s2
#FLUX: -N=4
#FLUX: --queue=main
#FLUX: -t=1800
#FLUX: --priority=16

ml PDC
ml GROMACS/2020.5-cpeCray-21.11
time=0.45
cmd="srun  gmx_mpi mdrun -v -maxh $time -s topol.tpr  -pin on  -cpi state.cpt"
echo $cmd
$cmd
err=$?
if [   $err == 0 ]; then
if [ ! -f "confout.gro" ]; then
	sbatch gromacs_dardel.sh
fi
fi
