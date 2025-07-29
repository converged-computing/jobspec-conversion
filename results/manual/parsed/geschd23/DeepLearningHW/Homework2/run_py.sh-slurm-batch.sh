#!/bin/bash
#SBATCH --job-name=DL-HW2
#SBATCH --output=/work/cse496dl/dgeschwe/output/job.%J.out
#SBATCH --error=/work/cse496dl/dgeschwe/output/job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=32000
#SBATCH --time=02:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=[gpu_k20|gpu_k40|gpu_p100]

module load singularity
singularity exec docker://unlhcc/tensorflow-gpu python3 -u $@
