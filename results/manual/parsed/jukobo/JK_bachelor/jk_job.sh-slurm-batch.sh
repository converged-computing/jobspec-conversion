#!/bin/bash
#SBATCH --job-name=jk_model
#SBATCH --output=jk_model_%J.out
#SBATCH --mail-user=s214704@dtu.dk
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=32gb
#SBATCH --time=14:00:00

echo "Node: $(hostname)"
echo "Start: $(date +%F-%R:%S)"
echo -e "Working dir: $(pwd)\n"
SCRATCH=/scratch/$USER
if [[ ! -d $SCRATCH ]]; then
  mkdir $SCRATCH
fi
source ~/JK_bachelor/.bashrc
module load CUDA/11.4
python OutlierDetection/training_conv.py --no-mps 
echo "Done: $(date +%F-%R:%S)"
