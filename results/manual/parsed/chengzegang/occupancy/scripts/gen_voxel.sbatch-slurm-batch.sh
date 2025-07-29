#!/bin/bash
#SBATCH --job-name=gen_voxel
#SBATCH --output=gen_voxel.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=128GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec --nv \
        --overlay /scratch/zc2309/nuscenes.ext3:ro \
	    --overlay /scratch/$USER/containers/overlay.ext3:ro  \
	    /scratch/work/public/singularity/cuda12.2.2-cudnn8.9.4-devel-ubuntu22.04.3.sif \
	    /bin/bash -c "source /ext3/env.sh; cd /scratch/zc2309/occupancy; bash scripts/gen_voxel.sh"
