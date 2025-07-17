#!/bin/bash
#FLUX: --job-name=trainer
#FLUX: -c=8
#FLUX: -t=86100
#FLUX: --urgency=16

echo "Hostname: $(hostname)"
echo "Processor: $(lscpu | grep 'Model name' | awk -F ':' '{print $2}' | xargs)"
echo "RAM: $(free -h | grep 'Mem:' | awk '{print $4}')"
echo "GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader)"
echo "GPU Memory: $(nvidia-smi | grep MiB |  awk '{print $9 $10 $11}')"
nvidia-smi
module purge
module load intel/19.1.2
module load python/intel/3.8.6
module load cuda/11.6.2
module load cudnn/8.6.0.163-cuda11
cd /scratch/vgn2004
python -m pip install --upgrade pip setuptools
venv_name="qlora_latest_venv"
if [ ! -d "$venv_name" ]; then
  python -m venv "$venv_name"
fi
source ./$venv_name/bin/activate
python3 /scratch/vgn2004/fine-tuning-large-language-models-on-limited-hardware/src/parallel_qlora_replication.py --is_quantized True --experiment_name fsdp_first_try
