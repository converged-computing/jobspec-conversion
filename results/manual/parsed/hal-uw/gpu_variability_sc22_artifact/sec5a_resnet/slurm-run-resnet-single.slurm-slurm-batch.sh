#!/bin/bash
#SBATCH --job-name=resnet
#SBATCH --output=debug/myresnet.%j.out
#SBATCH --error=debug/myresnet.%j.err
#SBATCH --mail-user=kchen346@wisc.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

node=$SLURM_JOB_NODELIST
module load tacc-apptainer
echo "Node Number: ${node}"
./resnet-singularity-single.sh
