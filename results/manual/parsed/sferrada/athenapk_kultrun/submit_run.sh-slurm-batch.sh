#!/bin/bash
#SBATCH --job-name=athenapk_gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=90G
#SBATCH --partition=kurruf_gpu
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=8

export CUDA_VISIBLE_DEVICES='3'

module load openmpi/4.1.5 gcc/12.2.0 hdf5/1.14.1-2_openmpi-4.1.5_parallel cuda/12.2 Python/3.11.4
MAIN_DIR=/home/sferrada/athenapk_kultrun
SIM_DIR=NG_1-NC_256-TCOR_1.00-SOLW_1.00-ARMS_1.00-BINI_0.30-EOSG_1.00
OUT_DIR=outputs/${SIM_DIR}
export CUDA_VISIBLE_DEVICES=3
cd $MAIN_DIR
mpirun ./athenapk/build-host/bin/athenaPK -i ./${OUT_DIR}/turbulence_philipp.in -d ./${OUT_DIR}/ > "./${OUT_DIR}/turbulence_philipp.out"
