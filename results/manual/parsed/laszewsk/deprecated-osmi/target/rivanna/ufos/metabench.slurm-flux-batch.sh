#!/bin/bash
#FLUX: --job-name=train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=43200
#FLUX: --priority=16

nvidia-smi
dir="/project/bii_dsc_community/$USER/osmi-scratch/osmi"
output_dir="/project/bii_dsc_community/$USER/osmi-scratch/osmi/osmi-output"
rivanna="$dir/machine/rivanna"
benchmark="$dir/benchmark"
mkdir -p $output_dir
module load anaconda
conda activate OSMI
pip install --user -r $rivanna/requirements-rivanna.txt
cd $benchmark
singularity run --nv --home `pwd` $dir/serving_latest-gpu.sif tensorflow_model_server --port=8500 --rest_api_port=0 --model_config_file=models.conf >& $output_dir/log &
date
for sec in $(seq -w 10000 -1 1); do
    if [[ $(lsof -i :8500) ]]; then break; fi
done
date
python metabench.py $rivanna/rivanna-V100.yaml -o $output_dir/p100-results.csv
