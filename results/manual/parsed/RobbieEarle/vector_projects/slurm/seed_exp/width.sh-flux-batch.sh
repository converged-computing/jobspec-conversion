#!/bin/bash
#FLUX: --job-name=width_2
#FLUX: -c=3
#FLUX: --queue=p100,t4v1,t4v2
#FLUX: --urgency=16

​
GPUS_PER_NODE=1
​
start_time=$SECONDS
date
echo ""
echo "Job $SLURM_JOB_NAME ($SLURM_JOB_ID) begins on $SLURM_NODENAME, submitted from $SLURM_SUBMIT_HOST ($SLURM_CLUSTER_NAME)"
echo ""
echo "SLURM_CLUSTER_NAME      = $SLURM_CLUSTER_NAME"        # Name of the cluster on which the job is executing.
echo "SLURM_NODENAME          = $SLURM_NODENAME"
echo "SLURM_JOB_QOS           = $SLURM_JOB_QOS"             # Quality Of Service (QOS) of the job allocation.
echo "SLURM_JOB_ID            = $SLURM_JOB_ID"              # The ID of the job allocation.
echo "SLURM_RESTART_COUNT     = $SLURM_RESTART_COUNT"       # The number of times the job has been restarted.
if [ "$SLURM_ARRAY_TASK_COUNT" != "" ] && [ "$SLURM_ARRAY_TASK_COUNT" -gt 1 ]; then
    echo ""
    echo "SLURM_ARRAY_JOB_ID      = $SLURM_ARRAY_JOB_ID"        # Job array's master job ID number.
    echo "SLURM_ARRAY_TASK_COUNT  = $SLURM_ARRAY_TASK_COUNT"    # Total number of tasks in a job array.
    echo "SLURM_ARRAY_TASK_ID     = $SLURM_ARRAY_TASK_ID"       # Job array ID (index) number.
    echo "SLURM_ARRAY_TASK_MAX    = $SLURM_ARRAY_TASK_MAX"      # Job array's maximum ID (index) number.
    echo "SLURM_ARRAY_TASK_STEP   = $SLURM_ARRAY_TASK_STEP"     # Job array's index step size.
fi;
echo ""
echo "SLURM_JOB_NUM_NODES     = $SLURM_JOB_NUM_NODES"       # Total number of nodes in the job's resource allocation.
echo "SLURM_JOB_NODELIST      = $SLURM_JOB_NODELIST"        # List of nodes allocated to the job.
echo "SLURM_TASKS_PER_NODE    = $SLURM_TASKS_PER_NODE"      # Number of tasks to be initiated on each node.
echo "SLURM_NTASKS            = $SLURM_NTASKS"              # Number of tasks to spawn.
echo "SLURM_PROCID            = $SLURM_PROCID"              # The MPI rank (or relative process ID) of the current process
echo ""
echo "SBATCH_GRES             = $SBATCH_GRES"               # Same as --gres
echo "GPUS_PER_NODE           = $GPUS_PER_NODE"             # Number of GPUs requested. Only set if the -G, --gpus option is specified.
echo "SLURM_CPUS_ON_NODE      = $SLURM_CPUS_ON_NODE"        # Number of CPUs allocated to the batch step.
echo "SLURM_JOB_CPUS_PER_NODE = $SLURM_JOB_CPUS_PER_NODE"   # Count of CPUs available to the job on the nodes in the allocation.
echo "SLURM_CPUS_PER_TASK     = $SLURM_CPUS_PER_TASK"       # Number of cpus requested per task. Only set if the --cpus-per-task option is specified.
echo ""
echo "------------------------------------------------------------------------"
echo ""
SAVE_PATH=~/vector_projects/outputs/seed_exp/width_2
DATASET="$1"
EPOCHS=100
RESNET_TYPE="$2"
SEED="$3"
ACTFUN_IDX="$4"
echo "SEED = $SEED"
echo "DATASET = $DATASET"
echo "EPOCHS = $EPOCHS"
echo "RESNET TYPE = $RESNET_TYPE"
echo "ACTFUN INDEX = $ACTFUN_IDX"
echo "EXTRA_ARGS = ${@:5}"
echo ""
echo "------------------------------------------------------------------------"
echo ""
echo "pwd:"
pwd
echo ""
echo "commit ref:"
git rev-parse HEAD
echo ""
git status
echo ""
echo "------------------------------------------------------------------------"
echo ""
date
echo ""
PROJECT_NAME="combinact"
echo "# Sourcing .bashrc file, to set-up conda"
source ~/.bashrc
echo ""
ENVNAME="$PROJECT_NAME"
echo "# Activating environment $ENVNAME"
conda activate "$HOME/venvs/$ENVNAME" || source activate "$HOME/venvs/$ENVNAME" || conda activate "$ENVNAME" || source activate "$ENVNAME"
echo ""
echo "------------------------------------------------------------------------"
echo ""
date
echo ""
echo "# Debugging outputs"
echo ""
echo "pwd:"
pwd
echo ""
echo "python version:"
python --version
echo ""
echo "which conda:"
which conda
echo ""
echo "conda info:"
conda info
echo ""
echo "conda export:"
conda env export
echo ""
echo "which pip:"
which pip
echo ""
echo "pip freeze:"
echo ""
pip freeze
echo ""
echo "which nvcc:"
which nvcc
echo ""
echo "nvcc version:"
nvcc --version
echo ""
echo "nvidia-smi:"
nvidia-smi
echo ""
python -c "import torch; print('pytorch={}, cuda={}, gpus={}'.format(torch.__version__, torch.cuda.is_available(), torch.cuda.device_count()))"
echo ""
python -c "import torch; print(str(torch.ones(2, device=torch.device('cuda')))); print('able to use cuda')"
echo ""
echo "------------------------------------------------------------------------"
echo "# Handling data and checkpoint paths"
echo ""
CKPT_DIR="/checkpoint/${USER}/${SLURM_JOB_ID}"
touch "$CKPT_DIR/DELAYPURGE"
echo "SAVE_PATH = $SAVE_PATH"
echo "CKPT_DIR = $CKPT_DIR"
echo ""
echo "ls -lh ${CKPT_DIR}:"
ls -lh "${CKPT_DIR}"
echo ""
OUTPUT_DIR="/scratch/hdd001/home/$USER/checkpoints/$PROJECT_NAME"
mkdir -p "$OUTPUT_DIR"
ln -sfn "$OUTPUT_DIR" "checkpoints"
JOB_OUTPUT_DIR="$OUTPUT_DIR/${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
echo "JOB_OUTPUT_DIR = $JOB_OUTPUT_DIR"
echo ""
echo "ls -lh ${JOB_OUTPUT_DIR}:"
ls -lh "${JOB_OUTPUT_DIR}"
echo ""
echo "df -h:"
df -h
echo ""
elapsed=$(( SECONDS - start_time ))
eval "echo Total elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo "------------------------------------------------------------------------"
echo ""
date
echo ""
echo "# Running engine.py"
python engine.py \
  --seed "$SEED" \
  --save_path "$SAVE_PATH" \
  --check_path "$CKPT_DIR" \
  --model resnet \
  --batch_size 128 \
  --actfun_idx "$ACTFUN_IDX" \
  --optim onecycle \
  --num_epochs $EPOCHS \
  --dataset "$DATASET" \
  --aug \
  --mix_pre_apex \
  --bs_factor 0.5 \
  --balanced \
  --resnet_type "$RESNET_TYPE" \
  --label _${RESNET_TYPE}_${ACTFUN_IDX} \
  "${@:5}"
echo ""
echo "# Finished running engine.py"
elapsed=$(( SECONDS - start_time ))
eval "echo Total elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo ""
date
echo ""
echo "Copying output checkpoint $CKPT_SOURCE to $JOB_OUTPUT_DIR"
rsync -rvz "$CKPT_DIR" "$JOB_OUTPUT_DIR"
echo ""
echo "Job $SLURM_JOB_NAME ($SLURM_JOB_ID) finished on $SLURM_NODENAME, submitted from $SLURM_SUBMIT_HOST ($SLURM_CLUSTER_NAME)"
date
elapsed=$(( SECONDS - start_time ))
eval "echo Total elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
