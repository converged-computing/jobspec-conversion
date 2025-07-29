#!/bin/bash
#SBATCH --job-name=BERL
#SBATCH --mail-user=paul.templier@isae-supaero.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=6
#SBATCH --ntasks=216
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=36

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module purge
module load intel/18.2
module load intelmpi/18.2
module load python/3.6.8
source activate /tmpdir/templier/envs/torchenv
echo $(which python)
cd
wandb enabled
wandb offline
echo CMD srun python BERL/run.py --wandb=sureli/BERL_paper --seed=$seed --job=$SLURM_JOB_ID --save_freq=50 --preset calmip atari canonical --net=canonical --pop_per_cpu=4 --env=SpaceInvaders-v0 --tag=canonical_paper
for seed in 0 1 2
do 
srun python BERL/run.py --wandb=sureli/BERL_paper --seed=$seed --job=$SLURM_JOB_ID --save_freq=50 --preset calmip atari canonical --net=canonical --pop_per_cpu=4 --env=SpaceInvaders-v0 --tag=canonical_paper
done
