#!/bin/bash
#SBATCH --job-name=pps
#SBATCH --output=cs-%j.out
#SBATCH --error=cs-%j.err
#SBATCH --mail-user=youremail@email.org
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00

cd $SLURM_SUBMIT_DIR
module load singularity
singularity run http://s3-far.jax.org/builder/builder sing_img.def sing.sif
