#!/bin/bash
#SBATCH --job-name=pd
#SBATCH --account=default
#SBATCH --output=/home/salvadord/pd/data/pd_scale-1.0_DC-0_TH-0_Balanced-1_1sec_512.run
#SBATCH --error=/home/salvadord/pd/data/pd_scale-1.0_DC-0_TH-0_Balanced-1_1sec_512.err
#SBATCH --mail-user=salvadordura@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-12:00:00
#SBATCH --constraint=ntasks-per-node=64
#SBATCH --exclude=compute[17-64000]

source ~/.bashrc
cd /home/salvadord/pd
mpirun -np 512 nrniv -python -mpi init.py
wait
