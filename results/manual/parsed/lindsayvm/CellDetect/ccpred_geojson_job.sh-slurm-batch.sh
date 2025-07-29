#!/bin/bash
#SBATCH --job-name=celldetect
#SBATCH --output=slurm_output_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=10:00:00
#SBATCH --partition=a6000
#SBATCH --nodelist=ptolemaeus

JOBS_SOURCE="/home/l.leek/src/CellDetect/"
SINGULARITYIMAGE="/home/l.leek/docker_singularity_images/u20c114s.sif"
COMMAND="python3 export_ccpred_geojson.py"
singularity exec --nv \
--no-home \
--bind "$JOBS_SOURCE" \
--bind "$SCRATCH" \
--pwd "$JOBS_SOURCE" \
$SINGULARITYIMAGE \
$COMMAND 
echo "Job finished succesfully"
