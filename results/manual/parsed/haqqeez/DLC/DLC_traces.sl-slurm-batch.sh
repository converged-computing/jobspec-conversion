#!/bin/bash
#SBATCH --job-name=TASKNAME
#SBATCH --account=def-markpb68
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=6000
#SBATCH --time=00:14:50

export DLClight='True'

module load scipy-stack/2021a
module load python/3.8
source ENVPATH
export DLClight=True
echo "TESTING GPU"
nvidia-smi
echo "RUNNING NOW"
python DLC_traces.py
