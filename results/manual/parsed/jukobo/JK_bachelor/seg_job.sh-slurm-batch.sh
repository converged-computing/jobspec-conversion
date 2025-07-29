#!/bin/bash
#SBATCH --job-name=jk_spine_model
#SBATCH --output=jk_spine_model_%J.out
#SBATCH --mail-user=s214725@dtu.dk
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=32gb
#SBATCH --time=7-00:00:00

echo "Node: $(hostname)"
echo "Start: $(date +%F-%R:%S)"
echo -e "Working dir: $(pwd)\n"
SCRATCH=/scratch/$USER
if [[ ! -d $SCRATCH ]]; then
  mkdir $SCRATCH
fi
source ~/JK_bachelor/.bashrc
module load CUDA/11.4
python VertebraeSegmentation/Verse/Predict_mask_titans.py --no-mps 
echo "Done: $(date +%F-%R:%S)"
