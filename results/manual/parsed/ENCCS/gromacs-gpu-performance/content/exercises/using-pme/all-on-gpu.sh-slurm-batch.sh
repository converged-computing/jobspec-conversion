#!/bin/bash
#SBATCH --account=project_2003752
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:15:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
options="-nsteps 20000 -resetstep 19000 -ntomp $SLURM_CPUS_PER_TASK -pin on -pinstride 1"
srun gmx mdrun $options -g manual-nb-pme-update.log        **FIXME**
srun gmx mdrun $options -g manual-nb-pme-bonded-update.log **FIXME**
echo Done
rm -f *cpt *edr *trr *tng *gro \#*
