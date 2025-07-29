#!/bin/bash
#SBATCH --job-name=4docc
#SBATCH --output=log/eval_%j.out
#SBATCH --error=log/eval_%j.err
#SBATCH --mail-user=xl3136@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=96GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

cd /scratch/$USER/Occ4D/baselines/4docc
singularity exec --nv \
	    --overlay /scratch/$USER/environments/occ4d.ext3:ro \
	    /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
	    /bin/bash -c "source /ext3/env.sh; 
        python eval.py -r /vast/xl3136/lyft_kitti \
            -d results/conv3d_lyft_p1010_lr0.0005_batch4_amp"
