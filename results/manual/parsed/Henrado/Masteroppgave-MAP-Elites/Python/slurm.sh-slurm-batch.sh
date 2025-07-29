#!/bin/bash
#SBATCH --job-name=$1
#SBATCH --output=result/$5/$1/%a/output.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --array=$2-$3

sbatch<<EOT
source ~/.bashrc
conda activate env39
srun python main3.py -c conf/$1.yaml -w $4 -o $5/$1/$4
sleep 60
EOT
