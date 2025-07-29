#!/bin/bash
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=60GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=2

module purge
singularity exec --nv \
	    --overlay /scratch/nn1331/whisper/whisper.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif\
	    /bin/bash -c "source /ext3/env.sh; python whisper.py"
