#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --time=00:05:00
#SBATCH --partition=gputest
#SBATCH --constraint=ntasks-per-node=1

rm -f LOCK
./start.csh
touch data/jobid.dat
./run.csh
