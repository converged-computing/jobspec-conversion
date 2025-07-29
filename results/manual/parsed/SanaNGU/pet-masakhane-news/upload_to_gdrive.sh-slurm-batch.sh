#!/bin/bash
#SBATCH --job-name=upload
#SBATCH --output=/home/mila/c/chris.emezue/pet-masakhane-news/slurmoutput_upload_%j.txt
#SBATCH --error=/home/mila/c/chris.emezue/pet-masakhane-news/slurmerror_upload_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --time=2-00:00:00

cd /home/mila/c/chris.emezue/scratch/pet-masakhane-results2/pet-masakhane
module load python/3
module load cuda/11.0/cudnn/8.0
source /home/mila/c/chris.emezue/scratch/pet-env/bin/activate
gdrive upload -r -p 1jtCdy0-TPDRkA_9BXys5JMCR0C9-SRGB results_pet/
