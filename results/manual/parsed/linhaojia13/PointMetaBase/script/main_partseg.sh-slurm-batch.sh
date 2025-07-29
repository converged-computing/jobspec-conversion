#!/bin/bash
#SBATCH --job-name=partseg
#SBATCH --output=slurm_logs/%x.%3a.%A.out
#SBATCH --error=slurm_logs/%x.%3a.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=[v100]
#SBATCH --array=0

[ ! -d "slurm_logs" ] && echo "Create a directory slurm_logs" && mkdir -p slurm_logs
module load cuda/11.1.1
module load gcc
echo "===> Anaconda env loaded"
source activate openpoints
while true
do
    PORT=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $PORT < /dev/null &>/dev/null; echo $?)"
    if [ "${status}" != "0" ]; then
        break;
    fi
done
echo $PORT
nvidia-smi
nvcc --version
hostname
NUM_GPU_AVAILABLE=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
echo $NUM_GPU_AVAILABLE
cfg=$1
PY_ARGS=${@:2}
python examples/shapenetpart/main.py --cfg $cfg ${PY_ARGS}
