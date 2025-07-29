#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --account=Hardware-Acceleratio
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=siyuan.ma@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=gtx

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/apps/cuda10_1/lib64'

module load intel/18.0.2 python3/3.7.0
module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/apps/cuda10_1/lib64
source $WORK/Lab1B_virtualenv/bin/activate
mkdir -p $WORK/Lab1B/output
for code in 0 1 00 01 10 11 000 001 010 011 100 101 110 111 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111
do
    python $WORK/Lab1B/cnn_keras.py ${code} > $WORK/Lab1B/output/out_cnn_${code} # Do not use ibrun or any other MPI launcher
done
