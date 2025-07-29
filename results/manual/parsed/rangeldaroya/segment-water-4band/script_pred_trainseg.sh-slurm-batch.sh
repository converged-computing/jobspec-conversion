#!/bin/bash
#SBATCH --job-name=predseg
#SBATCH --output=slurm_trainseg_pred/%j-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=48G
#SBATCH --time=01:00:00
#SBATCH --array=0-31%10

variations=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31)
casenumidx=$((SLURM_ARRAY_TASK_ID))
echo "Running i=${variations[$casenumidx]}"
python 04_predict_trainseg.py --i ${variations[$casenumidx]} --with_transforms 1 --ckpt_path "ckpts/deeplab_mobilenet/20240121-224805_e72.pth" --thresh 0.4 --crop_size 768
