#!/bin/bash
#SBATCH --job-name=ImageExtractor
#SBATCH --mail-user=mpeven@jhu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=25G
#SBATCH --time=10:00:00
#SBATCH --array=1-56800:100

source activate activity_recognition
python /home-3/mpeven1\@jhu.edu/work/dev_mp/ntu_rgb/save_images.py $SLURM_ARRAY_TASK_ID
echo "Finished with job $SLURM_JOBID"
