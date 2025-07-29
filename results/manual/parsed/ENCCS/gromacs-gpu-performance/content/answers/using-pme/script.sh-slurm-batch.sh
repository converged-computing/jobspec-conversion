#!/bin/bash
#SBATCH --account=project_2003752
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:15:00
#SBATCH --partition=gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
options="-nsteps 20000 -resetstep 19000 -ntomp $SLURM_CPUS_PER_TASK -pin on -pinstride 1"
srun gmx mdrun $options -g default.log
srun gmx mdrun $options -g manual-nb.log           -nb gpu -pme cpu
srun gmx mdrun $options -g manual-nb-pmeall.log    -nb gpu -pme gpu
srun gmx mdrun $options -g manual-nb-pmefirst.log  -nb gpu -pme gpu -pmefft cpu
echo Done
rm -f *cpt *edr *trr *tng *gro \#*
