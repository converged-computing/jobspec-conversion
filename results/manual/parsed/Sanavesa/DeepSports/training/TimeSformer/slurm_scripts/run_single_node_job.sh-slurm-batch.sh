#!/bin/bash
#SBATCH --job-name=timesformer
#SBATCH --output=/path/to/output/logs/slog-%A-%a.out
#SBATCH --error=/path/to/error/logs/slog-%A-%a.err
#SBATCH --mail-user=name@domain.com
#SBATCH --mail-type=END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --mem=480GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=volta32gb,ntasks-per-node=1
#SBATCH --array=1

module purge
module load cuda/10.0
module load NCCL/2.4.7-1-cuda.10.0
module load cudnn/v7.4-cuda.10.0
source activate timesformer
WORKINGDIR=/path/to/TimeSformer
CURPYTHON=/path/to/python
srun --label ${CURPYTHON} ${WORKINGDIR}/tools/run_net.py --cfg ${WORKINGDIR}/configs/Kinetics/TimeSformer_divST_8x32_224.yaml NUM_GPUS 8 TRAIN.BATCH_SIZE 8
