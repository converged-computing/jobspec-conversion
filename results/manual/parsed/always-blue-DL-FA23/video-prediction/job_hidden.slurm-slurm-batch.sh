#!/bin/bash
#SBATCH --account=csci_ga_2572_001-2023fa-30
#SBATCH --output=demo_%j.out
#SBATCH --error=demo_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --exclusive

export SINGULARITY_CACHEDIR='/tmp/$USER'

mkdir /tmp/$USER
export SINGULARITY_CACHEDIR=/tmp/$USER
echo '1gpu'
singularity exec --nv \
--bind /scratch \
--overlay /scratch/dnp9357/base_env/base_image.ext3:ro \
/share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif \
/bin/bash -c "
source /ext3/env.sh
cd /home/dnp9357/video-prediction
pwd
python3 Hidden_dataset.py
"
