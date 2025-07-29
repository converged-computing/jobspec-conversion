#!/bin/bash
#SBATCH --job-name=bevformer_small_DFA3D_rerun3
#SBATCH --output=./work_dirs/bevformer_small_DFA3D_rerun3.log
#SBATCH --mail-user=lihongyang@idea.edu.cn
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gres=gpu:hgx:8
#SBATCH --mem=800G
#SBATCH --partition=cvr
#SBATCH --qos=preemptive
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --exclude=True

export TORCH_DISTRIBUTED_DEBUG='DETAIL  # for debug the "unused_parameter'

N_GPU=8  #* sync_gpu
JOB_NAME="bevformer_small_DFA3D_rerun3"  #! sync_name
CONFIG="./projects/configs/bevformer/bevformer_small_DFA3D.py"  #! sync_name
PATH_SCRIPT="tools/train.py"
WORK_DIR="./work_dirs/"$JOB_NAME
OUTPUT_FILE="./work_dirs/"$JOB_NAME".log"
echo ${WORK_DIR}
echo ${OUTPUT_FILE}
mkdir -p ${WORK_DIR}
function rand(){
        min=20000
        max=$(($60000-$min+1))
        num=$(($RANDOM+1000000000))
        echo $(($num%$max+$min))
}
p=$(rand)
PORT=${PORT:-$p}
export TORCH_DISTRIBUTED_DEBUG=DETAIL  # for debug the "unused_parameter"
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -m torch.distributed.launch --nproc_per_node=$N_GPU --master_port=$PORT \
    $PATH_SCRIPT $CONFIG --launcher pytorch ${@:3} --deterministic  --work-dir=${WORK_DIR} 
