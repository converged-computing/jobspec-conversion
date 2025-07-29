#!/bin/bash
#FLUX: --job-name=swarm
#FLUX: --queue=tcb
#FLUX: -t=84600
#FLUX: --urgency=16

module unload gromacs
module load gromacs/2020.1
time=23
cmd="gmx mdrun -nt 32 -v -maxh $time -s topol.tpr  -pin on -cpi state.cpt"
echo $cmd
$cmd
err=$?
if [   $err == 0 ]; then
if [ ! -f "confout.gro" ]; then
	sbatch gromacs_tcb.sh
fi
fi
