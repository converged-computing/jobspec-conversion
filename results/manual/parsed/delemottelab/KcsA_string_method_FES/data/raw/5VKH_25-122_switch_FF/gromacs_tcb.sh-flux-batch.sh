#!/bin/bash
#FLUX: --job-name=hairy-lemur-9559
#FLUX: --urgency=16

module unload gromacs
module load gromacs/2020.1
time=23
cmd="gmx mdrun -nt 24 -v -maxh $time -s topol.tpr  -pin on -cpi state.cpt"
echo $cmd
$cmd
err=$?
if [   $err == 0 ]; then
if [ ! -f "confout.gro" ]; then
	sbatch gromacs_tcb.sh
fi
fi
