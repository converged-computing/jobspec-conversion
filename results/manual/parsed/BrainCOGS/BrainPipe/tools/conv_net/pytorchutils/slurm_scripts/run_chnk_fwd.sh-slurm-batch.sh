#!/bin/bash
#SBATCH --output=/scratch/gpfs/zmd/logs/array_jobs/chnk_%a_%j.out
#SBATCH --error=/scratch/gpfs/zmd/logs/array_jobs/chnk_%a_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30000
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=1

echo "Array Index: $SLURM_ARRAY_TASK_ID"
module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
cd pytorchutils/
python run_chnk_fwd.py 20200316_peterb_zd_train  models/RSUNet.py 12000 z265 --gpus 0 --noeval --tag noeval ${SLURM_ARRAY_TASK_ID}
