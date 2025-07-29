#!/bin/bash
#SBATCH --job-name=$appName
#SBATCH --output=%x.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3994MB
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=128

appName=STREAM
./init.sh ./apps/stream/stream_app_script.sh $appName
