#!/bin/bash
#SBATCH --job-name=gouttham-LISA-export
#SBATCH --account=def-amahdavi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:v100l:4
#SBATCH --mem=187G
#SBATCH --time=00:10:00
#SBATCH: --exclusive

cd ~/$projects/projects/def-amahdavi/gna23/LISA/
source ./lisa_env/bin/activate
module load cuda/11.0
module use cuda/11.0
python chat.py --version='./runs/lisa-7b-xbd-14days/export/' --precision='bf16'
echo "Job finished with exit code $? at: `date`"
