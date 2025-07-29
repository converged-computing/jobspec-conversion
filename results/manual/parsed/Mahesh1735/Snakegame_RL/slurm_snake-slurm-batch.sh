#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:29:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=12

nproc
sleep 1
module load cuda75/toolkit/7.5.18
source /home/s.aakhil/snake_env/bin/activate
ipython /home/s.aakhil/snakegame/ddqn.py
