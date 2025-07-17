#!/bin/bash
#FLUX: --job-name=zs-ssl-clus
#FLUX: -c=2
#FLUX: --queue=cpu
#FLUX: -t=345600
#FLUX: --urgency=16

                                    # %x=job-name, %A=job ID, %a=array value, %n=node rank, %t=task rank, %N=hostname
                                    # Note: You must create output directory "slogs" before launching job, otherwise it will immediately
                                    # fail without an error message.
                                    # Note: If you specify --output and not --error, then both STDOUT and STDERR will both be sent to the
                                    # file specified by --output.
                                    # We use this to set the seed. You can run multiple seeds with --array=0-4, for example.
PROJECT_NAME="zs-ssl-clustering"
PROJECT_DIRN="${PROJECT_NAME//-/_}"
set -e
start_time="$SECONDS"
echo "Job $SLURM_JOB_NAME ($SLURM_JOB_ID) begins on $(hostname), submitted from $SLURM_SUBMIT_HOST ($SLURM_CLUSTER_NAME)"
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
echo "Pass-through args: ${@}"
echo ""
echo "-------- Activating environment ----------------------------------------"
date
echo ""
echo "Running ~/.bashrc"
source ~/.bashrc
echo ""
ENVNAME="$PROJECT_NAME"
echo "Activating conda environment $ENVNAME"
conda activate "$ENVNAME"
echo ""
echo "Running slurm/utils/report_env_config.sh"
source "slurm/utils/report_env_config.sh"
echo "Running slurm/utils/set_job-label.sh"
source "slurm/utils/set_job-label.sh"
echo ""
echo "-------- Begin main script ---------------------------------------------"
date
python "$PROJECT_DIRN/cluster.py" \
    --seed="$SEED" \
    --log-wandb \
    --run-name="$SLURM_JOB_NAME" \
    --run-id="$JOB_ID" \
    "${@}"
echo ""
echo "------------------------------------------------------------------------"
echo ""
echo "Job $SLURM_JOB_NAME ($SLURM_JOB_ID) finished, submitted from $SLURM_SUBMIT_HOST ($SLURM_CLUSTER_NAME)"
date
echo "------------------------------------"
elapsed=$(( SECONDS - start_time ))
eval "echo Total elapsed time: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"
echo "========================================================================"
