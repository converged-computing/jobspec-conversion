#!/bin/bash
#SBATCH --job-name=lagosben
#SBATCH --account=project_2003593
#SBATCH --output=res/res_semseg_depth_%a.txt
#SBATCH --error=res/err_semseg_depth_%a.txt
#SBATCH --mail-user=juanpablo.lagosbenitez@tuni.fi
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=16000
#SBATCH --time=2-23:59:00
#SBATCH --partition=gpu

export MASTER_ADDR='$(hostname)'

module load CUDA/9.0
source activate pynoptorch
ip1=`hostname -I | awk '{print $2}'`
echo $ip1
export MASTER_ADDR=$(hostname)
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
MODEL_NAME=$1
BATCH_SIZE=$2
CHECKPOINT=$3
python eval_sem_seg_depth.py --model_name=$MODEL_NAME --batch_size=$BATCH_SIZE --checkpoint=$CHECKPOINT --nodes=1 --ngpus=1 --ip_adress $ip1 $SLURM_TASK_ARRAY_ID
