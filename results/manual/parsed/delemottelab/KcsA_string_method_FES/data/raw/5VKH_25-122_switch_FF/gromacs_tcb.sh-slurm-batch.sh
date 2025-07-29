#!/bin/bash
#SBATCH --job-name=switch_FF
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --mail-user=sergio.perez.conesa@scilifelab.se
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=23:30:00
#SBATCH --partition=tcb
#SBATCH --constraint=gpu

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
