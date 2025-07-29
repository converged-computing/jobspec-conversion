#!/bin/bash
#SBATCH --job-name=mnist
#SBATCH --account=ict23_smr3872
#SBATCH --output=run.out
#SBATCH --error=run.err
#SBATCH --mail-user=sdigioia@sissa.it
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=00:15:00

module purge
module load gcc
module load cuda
module load openmpi
source $HOME/.bashrc
conda activate /leonardo_work/ICT23_SMR3872/shared-env/Gabenv
kernprof -l mnist_classify.py --epochs=3
