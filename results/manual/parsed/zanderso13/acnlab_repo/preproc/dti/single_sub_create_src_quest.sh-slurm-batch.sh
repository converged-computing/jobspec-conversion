#!/bin/bash
#SBATCH --job-name=dti_create_src
#SBATCH --account=p30954
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=00:10:00
#SBATCH --partition=short

module load singularity/latest
action=src
source=$1
bval=$3
bvec=$2
recursive=0
echo "Work on the following folder: $1"
projdir=/projects/b1108
cd ${projdir}
singularity exec /home/zaz3744/ACNlab/software/singularity_images/dsi-studio-docker.sif /dsistudio/dsi_studio_64/dsi_studio --action=$action --source=$source --bval=${bval} --bvec=${bvec}
