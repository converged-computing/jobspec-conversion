#!/bin/bash
#FLUX: --job-name=misunderstood-noodle-6278
#FLUX: -c=18
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load 2022
module load GROMACS/2021.6-foss-2022a-CUDA-11.7.0
THREADS=18
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
setenv GMX_MAXCONSTRWARN -1
srun gmx grompp -f step7_production.mdp -o step7_production.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx
srun gmx mdrun -deffnm step7_production -ntomp ${THREADS} -pin on -pinstride 1 -g default.log -ntmpi 1
srun gmx grompp -f step7_production.mdp -o step7_production.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx
srun gmx mdrun -deffnm step7_production -ntomp ${THREADS} -pin on -pinstride 1 -g manual-nb-bonded.log -nb gpu -bonded gpu -ntmpi 1
srun gmx grompp -f step7_production.mdp -o step7_production.tpr -c step6.6_equilibration.gro -p system.top -n index.ndx
srun gmx mdrun -deffnm step7_production -ntomp ${THREADS} -pin on -pinstride 1 -g manual-nb.log -nb gpu -bonded cpu -ntmpi 1
echo Done
rm -f *cpt *edr *trr *tng *gro \#*
