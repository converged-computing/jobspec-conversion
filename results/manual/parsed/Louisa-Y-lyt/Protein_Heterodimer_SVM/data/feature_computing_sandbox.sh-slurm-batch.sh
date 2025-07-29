#!/bin/bash
#SBATCH --job-name=feature_compute
#SBATCH --output=/n/home10/ytingliu/alphapulldown_new/logs/%A_%a_out.txt
#SBATCH --error=/n/home10/ytingliu/alphapulldown_new/logs/%A_%a_err.txt
#SBATCH --mail-user=yutingliu@hsph.harvard.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=128G
#SBATCH --time=10:00:00
#SBATCH --qos=high

module load cuda/11.8.0-fasrc01
module load cudnn/8.9.2.26_cuda11-fasrc01
module load python/3.10.9-fasrc01
conda activate alphapulldown_new
cutoff=50
bind_path=$1
singularity exec \
    --no-home \
    --bind "$bind_path":/mnt \
    /n/holyscratch01/ramanathan_lab/yuting/alpha_analysis \
    run_get_good_pae.sh \
    --output_dir=/mnt \
    --cutoff=$cutoff
