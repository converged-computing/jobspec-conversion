#!/bin/bash
#FLUX: --job-name=template-experiment
#FLUX: --queue=t4v1,t4v2
#FLUX: -t=28800
#FLUX: --urgency=16

export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_GPUS_ON_NODE))'
export NCCL_IB_DISABLE='1'
export TORCH_NCCL_BLOCKING_WAIT='1'

                                    # %x=job-name, %A=job ID, %a=array value, %n=node rank, %t=task rank, %N=hostname
                                    # Note: You must create output directory "slogs" before launching job, otherwise it will immediately
                                    # fail without an error message.
                                    # Note: If you specify --output and not --error, then both STDOUT and STDERR will both be sent to the
                                    # file specified by --output.
                                    # In this example, we use this to set the seed. You can run multiple seeds with --array=0-4, for example.
PROJECT_NAME="template-experiment"
PROJECT_DIRN="${PROJECT_NAME//-/_}"
set -e
function term_handler()
{
    echo "** Job $SLURM_JOB_NAME ($SLURM_JOB_ID) received SIGUSR1 at $(date) **"
    echo "** Requeuing job $SLURM_JOB_ID so it can run for longer **"
    scontrol requeue "${SLURM_JOB_ID}"
}
trap term_handler SIGUSR1
start_time="$SECONDS"
echo "Job $SLURM_JOB_NAME ($SLURM_JOB_ID) begins on $(hostname), submitted from $SLURM_SUBMIT_HOST ($SLURM_CLUSTER_NAME)"
echo ""
echo "Running slurm/utils/report_slurm_config.sh"
source "slurm/utils/report_slurm_config.sh"
echo "Running slurm/utils/report_repo.sh"
source "slurm/utils/report_repo.sh"
echo ""
if false; then
    # Print disk usage report, to catch errors due to lack of file space.
    # This is disabled by default to prevent confusing new users with too
    # much output.
    echo "------------------------------------"
    echo "df -h:"
    # Print header, then sort the rows alphabetically by mount point
    df -h --output=target,pcent,size,used,avail,source | head -n 1
    df -h --output=target,pcent,size,used,avail,source | tail -n +2 | sort -h
    echo ""
fi
echo "-------- Input handling ------------------------------------------------"
date
echo ""
SEED="$SLURM_ARRAY_TASK_ID"
if [[ "$SEED" == "" ]];
then
    SEED=0
fi
echo "SEED = $SEED"
if [[ "$1" == *.py ]];
then
    # If it is, we'll run this python script and remove it from the list of
    # arguments to pass on to the script.
    SCRIPT_PATH="$1"
    shift
else
    # Otherwise, use our default python training script.
    SCRIPT_PATH="$PROJECT_DIRN/train.py"
fi
echo "SCRIPT_PATH = $SCRIPT_PATH"
echo "Pass-through args: ${@}"
echo ""
echo "-------- Activating environment ----------------------------------------"
date
echo ""
echo "Running ~/.bashrc"
source ~/.bashrc
ENVNAME="$PROJECT_NAME"
echo "Activating conda environment $ENVNAME"
conda activate "$ENVNAME"
echo ""
echo "Running slurm/utils/report_env_config.sh"
source "slurm/utils/report_env_config.sh"
echo "-------- Setting JOB_LABEL ---------------------------------------------"
echo ""
if [ "$SLURM_ARRAY_TASK_COUNT" != "" ] && [ "$SLURM_ARRAY_TASK_COUNT" -gt 1 ];
then
    JOB_ID="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}";
else
    JOB_ID="${SLURM_JOB_ID}";
fi
JOB_LABEL="${SLURM_JOB_NAME}__${JOB_ID}";
echo "JOB_ID = $JOB_ID"
echo "JOB_LABEL = $JOB_LABEL"
echo ""
echo "-------- Setting checkpoint and output path variables ------------------"
echo ""
CKPT_DIR="/checkpoint/${SLURM_JOB_USER}/${SLURM_JOB_ID}"
echo "CKPT_DIR = $CKPT_DIR"
CKPT_PTH="$CKPT_DIR/checkpoint_latest.pt"
echo "CKPT_PTH = $CKPT_PTH"
echo ""
mkdir -p "$CKPT_DIR"
echo "Current contents of ${CKPT_DIR}:"
ls -lh "${CKPT_DIR}"
echo ""
mkdir -p "checkpoints_working"
ln -sfn "$CKPT_DIR" "$PWD/checkpoints_working/$SLURM_JOB_NAME"
if [[ -d "/scratch/hdd001/home/$SLURM_JOB_USER" ]];
then
    OUTPUT_DIR="/scratch/hdd001/home/$SLURM_JOB_USER"
elif [[ -d "/scratch/ssd004/scratch/$SLURM_JOB_USER" ]];
then
    OUTPUT_DIR="/scratch/ssd004/scratch/$SLURM_JOB_USER"
else
    OUTPUT_DIR=""
fi
if [[ "$OUTPUT_DIR" != "" ]];
then
    # Directory OUTPUT_DIR will contain all completed jobs for this project.
    OUTPUT_DIR="$OUTPUT_DIR/checkpoints/$PROJECT_NAME"
    # Subdirectory JOB_OUTPUT_DIR will contain the outputs from this job.
    JOB_OUTPUT_DIR="$OUTPUT_DIR/$JOB_LABEL"
    echo "JOB_OUTPUT_DIR = $JOB_OUTPUT_DIR"
    if [[ -d "$JOB_OUTPUT_DIR" ]];
    then
        echo "Current contents of ${JOB_OUTPUT_DIR}"
        ls -lh "${JOB_OUTPUT_DIR}"
    fi
    echo ""
fi
conda env export > "$CKPT_DIR/environment.yml"
pip freeze > "$CKPT_DIR/frozen-requirements.txt"
if [[ "$SLURM_RESTART_COUNT" > 0 && ! -f "$CKPT_PTH" ]];
then
    echo ""
    echo "====================================================================="
    echo "SLURM SCRIPT ERROR:"
    echo "    Resuming after pre-emption (SLURM_RESTART_COUNT=$SLURM_RESTART_COUNT)"
    echo "    but there is no checkpoint file at $CKPT_PTH"
    echo "====================================================================="
    exit 1;
fi;
echo ""
echo "------------------------------------"
elapsed=$(( SECONDS - start_time ))
eval "echo Running total elapsed time for restart $SLURM_RESTART_COUNT: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo ""
echo "-------- Begin main script ---------------------------------------------"
date
echo ""
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
echo "Rank 0 node is at $MASTER_ADDR"
MASTER_PORT="$(( $SLURM_JOB_ID % 16384 + 49152 ))"
if ss -tulpn | grep -q ":$MASTER_PORT ";
then
    # The port we selected is in use, so we'll get a random available port instead.
    echo "Finding a free port to use for $SLURM_NNODES node training"
    MASTER_PORT="$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')";
fi
export MASTER_PORT;
echo "Will use port $MASTER_PORT for c10d communication"
export WORLD_SIZE="$(($SLURM_NNODES * $SLURM_GPUS_ON_NODE))"
echo "WORLD_SIZE = $WORLD_SIZE"
export NCCL_IB_DISABLE=1
if [[ "${SLURM_JOB_PARTITION}" == "t4v2" ]] || [[ "${SLURM_JOB_PARTITION}" == "rtx6000" ]];
then
    echo "Using NCCL_SOCKET_IFNAME=bond0 on ${SLURM_JOB_PARTITION}"
    export NCCL_SOCKET_IFNAME=bond0
fi
export TORCH_NCCL_BLOCKING_WAIT=1
echo ""
echo "Main script begins via torchrun with host tcp://${MASTER_ADDR}:$MASTER_PORT with backend NCCL"
if [[ "$SLURM_JOB_NUM_NODES" == "1" ]];
then
    echo "Single ($SLURM_JOB_NUM_NODES) node training ($SLURM_GPUS_ON_NODE GPUs)"
else
    echo "Multiple ($SLURM_JOB_NUM_NODES) node training (x$SLURM_GPUS_ON_NODE GPUs per node)"
fi
echo ""
srun -N "$SLURM_NNODES" --ntasks-per-node=1 \
    torchrun \
    --nnodes="$SLURM_JOB_NUM_NODES" \
    --nproc_per_node="$SLURM_GPUS_ON_NODE" \
    --rdzv_id="$SLURM_JOB_ID" \
    --rdzv_backend=c10d \
    --rdzv_endpoint="$MASTER_ADDR:$MASTER_PORT" \
    "$SCRIPT_PATH" \
    --cpu-workers="$SLURM_CPUS_PER_GPU" \
    --seed="$SEED" \
    --checkpoint="$CKPT_PTH" \
    --log-wandb \
    --run-name="$SLURM_JOB_NAME" \
    --run-id="$JOB_ID" \
    "${@}" &
child="$!"
wait "$child"
echo ""
echo "------------------------------------"
elapsed=$(( SECONDS - start_time ))
eval "echo Running total elapsed time for restart $SLURM_RESTART_COUNT: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo ""
rm "$PWD/checkpoints_working/$SLURM_JOB_NAME"
JOB_OUTPUT_DIR=""
if [[ "$CKPT_DIR" == "" ]];
then
    # This shouldn't ever happen, but we have a check for just in case.
    # If $CKPT_DIR were somehow not set, we would mistakenly try to copy far
    # too much data to $JOB_OUTPUT_DIR.
    echo "CKPT_DIR is unset. Will not copy outputs to $JOB_OUTPUT_DIR."
elif [[ "$JOB_OUTPUT_DIR" == "" ]];
then
    echo "JOB_OUTPUT_DIR is unset. Will not copy outputs from $CKPT_DIR."
else
    echo "-------- Saving outputs for long term storage --------------------------"
    date
    echo ""
    echo "Copying outputs from $CKPT_DIR to $JOB_OUTPUT_DIR"
    mkdir -p "$JOB_OUTPUT_DIR"
    rsync -rutlzv "$CKPT_DIR/" "$JOB_OUTPUT_DIR/"
    echo ""
    echo "Output contents of ${JOB_OUTPUT_DIR}:"
    ls -lh "$JOB_OUTPUT_DIR"
    # Set up a symlink to the long term storage directory
    ln -sfn "$OUTPUT_DIR" "checkpoints_finished"
fi
echo ""
echo "------------------------------------------------------------------------"
echo ""
echo "Job $SLURM_JOB_NAME ($SLURM_JOB_ID) finished, submitted from $SLURM_SUBMIT_HOST ($SLURM_CLUSTER_NAME)"
date
echo "------------------------------------"
elapsed=$(( SECONDS - start_time ))
eval "echo Total elapsed time for restart $SLURM_RESTART_COUNT: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo "========================================================================"
