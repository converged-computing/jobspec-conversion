#!/bin/bash
#SBATCH --job-name=hivclass-train
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --partition=v100

USR_HOME=/home/07655/jsreyl/
NAME=$1
SCRIPT_DIR=`pwd`
time python3 $SCRIPT_DIR/$NAME
