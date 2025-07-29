#!/bin/bash
#SBATCH --job-name=demo
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --mail-user=hrr288@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:2
#SBATCH --mem=32GB
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=2

singularity exec --nv \
--overlay /scratch/hrr288/hrr_env/pytorch1.7.0-cuda11.0.ext3:ro \
--overlay /scratch/xl3136/dl-sp22-final-project/dataset/unlabeled_224.sqsh \
--overlay /scratch/xl3136/dl-sp22-final-project/dataset/labeled.sqsh \
/scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
/bin/bash -c "
source /ext3/env.sh; python3 main.py "
