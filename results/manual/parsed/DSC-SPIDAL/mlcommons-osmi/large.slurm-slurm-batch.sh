#!/bin/bash
#SBATCH --account=bii_dsc_community
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=1-12:00:00

source ~/.bashrc
conda activate osmi
cd /project/bii_dsc_community/osmibench/code/osmi-bench/benchmark
singularity run --nv --home `pwd` ../tensorflow-serving_latest.sif tensorflow_model_server --port=8500 --rest_api_port=0 --model_config_file=models.conf >& log &
sleep 12
nvidia-smi
python tfs_grpc_client.py -m large_tcnn -b 32 -n 48 localhost:8500
