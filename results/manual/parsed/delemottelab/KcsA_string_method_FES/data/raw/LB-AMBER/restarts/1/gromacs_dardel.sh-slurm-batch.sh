#!/bin/bash
#SBATCH --job-name=LB-AMBER_s1
#SBATCH --account=snic2021-3-15
#SBATCH --output=slurm.err
#SBATCH --error=slurm.out
#SBATCH --mail-user=sergiopc@kth.se
#SBATCH --mail-type=FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=128

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
