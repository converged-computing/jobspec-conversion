#!/bin/bash
#FLUX: --job-name=boopy-punk-0796
#FLUX: -c=8
#FLUX: -t=172500
#FLUX: --urgency=16

echo "Hostname: $(hostname)"
echo "Processor: $(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | xargs)"
echo "RAM: $(free -h | grep 'Mem:' | awk '{print $4}')"
echo "GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader)"
echo "GPU Memory: $(nvidia-smi | grep MiB |  awk '{print $9 $10 $11}')"
module purge
module load intel/19.1.2
module load python/intel/3.8.6
module load cuda/11.6.2
module load cudnn/8.6.0.163-cuda11
cd /scratch/vgn2004/fine-tuning-large-language-models-on-limited-hardware/src
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 CONFIG_NAME"
    exit 1
fi
CONFIG_NAME=$1
python qlora_runner.py --config_path ./run_configurations/{CONFIG_NAME}.json
