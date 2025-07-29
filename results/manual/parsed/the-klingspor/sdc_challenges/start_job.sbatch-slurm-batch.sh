#!/bin/bash
#SBATCH --job-name=TutorialJob
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --mail-user=Your.Name@uni-tuebingen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=3G
#SBATCH --time=00:10:00

singularity exec --nv ~/sdc_gym.simg python your_file.py
echo DONE!
