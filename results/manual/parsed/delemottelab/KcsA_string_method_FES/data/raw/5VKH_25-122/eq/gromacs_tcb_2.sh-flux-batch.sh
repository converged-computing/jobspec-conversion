#!/bin/bash
#FLUX: --job-name=cowy-hobbit-5633
#FLUX: --urgency=16

module unload gromcas
 module unload gromacs/2020.2
module load gromacs/2020.2
time=23
var=2
var0=$((($var-1)))
if [ ! -f "step${var}.cpt" ]; then
	gmx grompp -maxwarn 2 -f NPTres${var}.mdp  -c step${var0}.gro  -p topol.top  -o topol.tpr -n index.ndx -pp topol_pp.top -r step${var0}.gro
    cmd="gmx mdrun -v -maxh $time -s topol.tpr  -pin on -deffnm step$var "
	echo $cmd
	$cmd
	if [ ! -f "step${var}.gro" ]; then
		sbatch gromacs_tcb_${var}.sh
	else
		var=$((($var+1)))
		sbatch gromacs_tcb_${var}.sh
        fi 
else
    cmd="gmx mdrun -v -maxh $time -s topol.tpr  -pin on -deffnm step$var -cpi step${var}.cpt"
    echo $cmd
    $cmd
	if [ ! -f "step${var}.gro" ]; then
		sbatch gromacs_tcb_${var}.sh
	else
		var=$((($var+1)))
		sbatch gromacs_tcb_${var}.sh
        fi 
fi
