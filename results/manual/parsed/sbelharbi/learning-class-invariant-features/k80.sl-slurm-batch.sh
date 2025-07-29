#!/bin/bash
#SBATCH --job-name=lenet
#SBATCH --output=./outputjobs/lenet.o%J
#SBATCH --error=./outputjobs/lenet.e%J
#SBATCH --mail-user=soufiane.belharbi@insa-rouen.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=3000
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu_k80

module load cuda/8.0
module load python/2.7.12
cd $LOCAL_WORK_DIR/workspace/code/class-invariance-hint/
