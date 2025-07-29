#!/bin/bash
#SBATCH --job-name=pkl_cfr_env
#SBATCH --output=logs/%A_%a_%x.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=32GB
#SBATCH --time=02:00:00
#SBATCH --array=0,1,2,3,4
#SBATCH --nodelist=*gr*

echo "Starting SLURM Script"
nums=("000" "010" "025" "050" "100")
num=${nums[${SLURM_ARRAY_TASK_ID}]}
singularity exec --nv \
    --overlay /scratch/nv2099/images/overlay-50G-10M.ext3:ro \
    /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
    /bin/bash -c "
    source /ext3/miniconda3/etc/profile.d/conda.sh;
    conda activate spiel;
    cd /home/nv2099/projects/mcs/pkl_obs;
    python -u cfr_env.py --model rnn --traj trajectories/traj-${num}-*.pkl --env_ckpt runs/env/rnn/${num}/model_epoch_025* --label ${num};
    "
echo "Finishing SLURM Script"
