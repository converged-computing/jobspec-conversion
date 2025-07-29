#!/bin/bash
#SBATCH --job-name=monoscene
#SBATCH --output=log/dm_%j.out
#SBATCH --error=log/dm_%j.err
#SBATCH --mail-user=xl3136@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=16GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
cd /scratch/$USER/sscbench/MonoScene
singularity exec --nv \
	    --overlay /scratch/$USER/environments/monoscene.ext3:ro \
        --overlay /scratch/$USER/dataset/waymo/waymo.sqf:ro \
        --overlay /scratch/$USER/dataset/waymo/preprocess.sqf:ro \
	    /scratch/work/public/singularity/cuda10.2-cudnn8-devel-ubuntu18.04.sif \
	    /bin/bash -c "source /ext3/env.sh; 
        conda activate monoscene; 
        python monoscene/scripts/eval_waymo.py"
