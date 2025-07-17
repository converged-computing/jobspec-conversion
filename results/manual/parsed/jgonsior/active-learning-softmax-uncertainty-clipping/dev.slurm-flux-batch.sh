#!/bin/bash
#FLUX: --job-name=dirty-train-4765
#FLUX: -c=8
#FLUX: --queue=alpha
#FLUX: -t=363599
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE='./hf-cache'
export HF_DATASETS_CACHE='./hf-cache'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""
module load release/23.04  GCC/11.3.0  OpenMPI/4.1.4
module load PyTorch/1.12.1-CUDA-11.7.0
source /beegfs/ws/1/s5968580-btw/python-environments/btw-v3/bin/activate
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE="./hf-cache"
export HF_DATASETS_CACHE="./hf-cache"
mkdir -p $TRANSFORMERS_CACHE
python /beegfs/ws/1/s5968580-btw/active-learning-softmax-uncertainty-clipping/run_experiment.py --taurus --workload dev --n_array_jobs 100 --array_job_id $SLURM_ARRAY_TASK_ID 
exit 0
