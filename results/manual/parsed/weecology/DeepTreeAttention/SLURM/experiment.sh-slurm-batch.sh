#!/bin/bash
#SBATCH --job-name=DeepTreeAttention
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepTreeAttention_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepTreeAttention_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=50GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

ulimit -c 0
module load git gcc
git checkout $1
source activate DeepTreeAttention
cd ~/DeepTreeAttention/
branch_name=$((git symbolic-ref HEAD 2>/dev/null || echo "(unnamed branch)")|cut -d/ -f3-)
commit=$(git log --pretty=format:'%H' -n 1)
python train.py $branch_name $commit
