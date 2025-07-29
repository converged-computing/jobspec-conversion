#!/bin/bash
#SBATCH --job-name=BAIL_Dialog
#SBATCH --account=csci_ga_2590-2023sp
#SBATCH --output=./%j.out
#SBATCH --error=./%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=48GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=n1s16-v100-2

singularity exec --bind /scratch --nv --overlay /scratch/zd662/overlay-25GB-500K.ext3:rw /scratch/zd662/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate rl4lm
python ./train_text_generation.py --config_path ./task_configs/dialog/gpt2_bail.yml
"
