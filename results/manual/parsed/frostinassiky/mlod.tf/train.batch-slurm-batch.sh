#!/bin/bash
#SBATCH --job-name=FROG1
#SBATCH --output=gpu.%j.out
#SBATCH --error=gpu.%j.err
#SBATCH --mail-user=mengmeng.xu@kaust.edu.sa
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:titan_x_p:1
#SBATCH --mem=20480
#SBATCH --time=2-00:23:00
#SBATCH --array=1

set -e
module purge
module load anaconda
module load applications-extra
module load cuda/8.0.44-cudNN5.1
echo "SLURM_JOB_ID" $SLURM_ARRAY_TASK_ID
source activate py2-tf
./experiments/scripts/train_faster_rcnn.sh 0 pascal_voc vgg16
source deactivate py27
