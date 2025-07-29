#!/bin/bash
#SBATCH --account=def-ichiro
#SBATCH --output=run_output/xlnet_cv_output_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=200G
#SBATCH --time=3-00:00:00
#SBATCH --array=1-6

module load python/3.8
module load scipy-stack
module load cuda
module --ignore-cache load torch/1.4.0
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip3 install --upgrade --no-binary numpy==1.20.0 numpy==1.20.0
pip install --no-index -r requirements.txt
echo "Starting Task"
python xlnet_cv.py --ml 512 --bs 8 --epochs 50 --lr $SLURM_ARRAY_TASK_ID --es 5
