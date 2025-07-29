#!/bin/bash
#SBATCH --job-name=resnet
#SBATCH --output=debug/myresnet.%j.out
#SBATCH --error=debug/myresnet.%j.err
#SBATCH --mail-user=bqtran2@wisc.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=v100
#SBATCH --exclude=c002-[001-012],c003-[001-012],c004-[001-012],c005-[001-012],c006-[001-012],c007-[001-012],c009-[001-012]

node=$SLURM_JOB_NODELIST
echo "Node Number: ${node}"
run-resnet.sh
