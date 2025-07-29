#!/bin/bash
#SBATCH --account=plgcholdadyplomy
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=40GB
#SBATCH --time=1-02:00:00

module add plgrid/tools/python/3.8
module add plgrid/libs/tensorflow-gpu/2.3.1-python-3.8
module add plgrid/apps/cuda/10.1
cd $SLURM_SUBMIT_DIR
cd ../..
pip install -r requirements.txt
python3 main.py -d "/net/archive/groups/plggpchdyplo/augmented_data/"
