#!/bin/bash
#SBATCH --output=<absolute-path-to-code>/slurmlogs/%A-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=06:00:00
#SBATCH --array=1-5%1

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
python ddp_train_nerf.py --config configs/e2vid/chair.txt
echo Finished
