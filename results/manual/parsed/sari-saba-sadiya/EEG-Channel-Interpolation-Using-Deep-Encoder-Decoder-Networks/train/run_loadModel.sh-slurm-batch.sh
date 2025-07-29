#!/bin/bash
#SBATCH --output=out_load/modelPred_%a.out
#SBATCH --error=err_load/modelPred_%a.err
#SBATCH --mail-user=sadiyasa@msu.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=350G
#SBATCH --time=4-00:00:00
#SBATCH --partition=sched_mit_rgmark
#SBATCH: --exclusive
#SBATCH --array=1

. /etc/profile.d/modules.sh
module load python/3.6.3
module load cuda/8.0
module load cudnn/6.0
pip3 install --user virtualenv
virtualenv -p python3 venv
source venv/bin/activate
pip3 install -r requirements.txt
KERAS_BACKEND=tensorflow
python3 ecr_loadmodel.py $SLURM_ARRAY_TASK_ID
