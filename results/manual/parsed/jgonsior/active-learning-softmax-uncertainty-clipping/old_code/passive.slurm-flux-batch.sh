#!/bin/bash
#FLUX: --job-name=buttery-despacito-0471
#FLUX: -c=8
#FLUX: --queue=alpha
#FLUX: -t=86399
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE='./hf-cache'
export HF_DATASETS_CACHE='./hf-cache'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""
module load modenv/hiera  GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
module load PyTorch/1.10.0
source /scratch/ws/1/s5968580-btw/venv/bin/activate
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE="./hf-cache"
export HF_DATASETS_CACHE="./hf-cache"
mkdir -p $TRANSFORMERS_CACHE
python /scratch/ws/1/s5968580-btw/code/run_experiment.py --taurus --workload passive --n_array_jobs 201 --array_job_id $SLURM_ARRAY_TASK_ID
exit 0
