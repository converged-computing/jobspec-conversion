#!/bin/bash
#SBATCH --job-name=vae
#SBATCH --output=/home/igatopou/projects/vae/src/jobs/out/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --time=1-16:00:00
#SBATCH --constraint=ntasks-per-node=1

module load cuda80/toolkit prun
module load opencl-nvidia/8.0
for PRIOR in 'mog'
do
    srun python -u /home/igatopou/projects/vae/main.py --prior $PRIOR
done
