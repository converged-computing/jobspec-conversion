#!/bin/bash
#FLUX: --job-name=debug_sft_small
#FLUX: -c=4
#FLUX: --queue=dev-g
#FLUX: -t=3600
#FLUX: --urgency=16

export TORCH_EXTENSIONS_DIR='/tmp/$USER/torch_extensions'
export CACHE='/scratch/project_462000241/$USER/cache'
export MODEL_PATH='/scratch/project_462000241/$USER/oa_models/debug'
export LOGS='/scratch/project_462000241/$USER/logs'
export PYTORCH_ROCM_ARCH='gfx90a'
export LOCAL_RANK='$SLURM_LOCALID'
export RANK='$SLURM_PROCID'
export WORLD_SIZE='$((SLURM_GPUS_ON_NODE*SLURM_NNODES))'
export TRANSFORMERS_NO_ADVISORY_WARNINGS='1'
export TOKENIZERS_PARALLELISM='true'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOB_NAME-$SLURM_JOB_ID.out logs/latest.out
ln -s $SLURM_JOB_NAME-$SLURM_JOB_ID.err logs/latest.err
echo "Job name" $SLURM_JOB_NAME
module --force purge
module load LUMI/22.08 partition/G 
module load rocm/5.2.3
module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
module load aws-ofi-rccl/rocm-5.2.3
module use /appl/local/csc/modulefiles
module load pytorch
export TORCH_EXTENSIONS_DIR=/tmp/$USER/torch_extensions
export CACHE=/scratch/project_462000241/$USER/cache
export MODEL_PATH=/scratch/project_462000241/$USER/oa_models/debug
export LOGS=/scratch/project_462000241/$USER/logs
export PYTORCH_ROCM_ARCH=gfx90a
export LOCAL_RANK=$SLURM_LOCALID
export RANK=$SLURM_PROCID
export WORLD_SIZE=$((SLURM_GPUS_ON_NODE*SLURM_NNODES))
export TRANSFORMERS_NO_ADVISORY_WARNINGS=1
export TOKENIZERS_PARALLELISM=true
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python3 -m torch.distributed.run --standalone --nproc-per-node=$SLURM_GPUS_ON_NODE \
        trainer_sft.py --configs gpt3-finnish-small \
        --debug \
        --cache_dir $CACHE \
        --output_dir $MODEL_PATH/$SLURM_JOB_NAME \
        --log_dir $LOGS \
        --local_rank $LOCAL_RANK \
        --report_to tensorboard
