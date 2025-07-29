#!/bin/bash
#SBATCH --account=csci_ga_2572_001-2023fa-27
#SBATCH --output=hidden_infer_%j.out
#SBATCH --error=hidden_infer_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=07:00:00
#SBATCH --exclusive

singularity exec --bind /scratch/ak11089 --nv --overlay /scratch/ak11089/final-project/overlay-50G-10M.ext3:ro /share/apps/images/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/activate_conda.sh
cd /scratch/ak11089/final-project/Deep-Learning-Project-Fall-23/src/mcvd
sh src/mcvd/train.sh
"
