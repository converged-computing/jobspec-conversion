#!/bin/bash
#SBATCH --job-name=transformer-xl
#SBATCH --account=umutlu
#SBATCH --output=transformer-%j.out
#SBATCH --mail-user=urasmutlu@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:4
#SBATCH --time=6-00:00:00

module load /truba/home/umutlu/cuda_9.0_module
srun bash run_papers_base.sh train --work_dir experiments
