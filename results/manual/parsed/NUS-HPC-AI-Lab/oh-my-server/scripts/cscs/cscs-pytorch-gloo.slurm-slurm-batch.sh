#!/bin/bash
#SBATCH --job-name=gloo-eb
#SBATCH --account=<project>
#SBATCH --output=test_pt_hvd_%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export PMI_NO_PREINITIALIZE='1  # avoid warnings on fork'

module load daint-gpu PyTorch
. /users/lyongbin/miniconda3/bin/activate your_env_name
export PMI_NO_PREINITIALIZE=1  # avoid warnings on fork
for node in $(scontrol show hostnames); do
   HOSTS="$HOSTS$node:$SLURM_NTASKS_PER_NODE,"
done
HOSTS=${HOSTS%?}  # trim trailing comma
echo HOSTS $HOSTS
horovodrun -np $SLURM_NTASKS -H $HOSTS --gloo --network-interface ipogif0 \
   --start-timeout 120 --gloo-timeout-seconds 120 \
python -u your_code.py  \
--epochs 90 \
--model resnet50
