#!/bin/bash
#SBATCH --job-name=jzfov
#SBATCH --output=output_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=03:59:00
#SBATCH --constraint=ntasks-per-node=1

singularity exec --nv --overlay /scratch/jz5952/neuro-recon-stimuli-env/overlay-25GB-500K.ext3:ro /scratch/work/public/singularity/cuda12.3.2-cudnn9.0.0-ubuntu-22.04.4.sif /bin/bash -c "source /ext3/env.sh && cd /scratch/jz5952/mind-vis && python code/stageA1_mbm_pretrain.py --num_epoch 200 --model_name MAEforFMRI"
