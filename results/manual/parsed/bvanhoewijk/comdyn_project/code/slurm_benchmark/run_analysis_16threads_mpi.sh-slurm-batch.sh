#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:10:00
#SBATCH --exclusive

module load 2022
module load GROMACS/2021.6-foss-2022a
setenv GMX_MAXCONSTRWARN -1
srun gmx grompp -f step7_production.mdp -o step7_production.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx
srun gmx mdrun -deffnm step7_production -ntmpi 2 -ntomp 8
