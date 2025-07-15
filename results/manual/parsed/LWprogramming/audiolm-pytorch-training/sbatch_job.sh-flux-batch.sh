#!/bin/bash
#FLUX: --job-name=audiolm-e2e-openslr-dev-clean
#FLUX: --queue=g40x
#FLUX: --priority=16

while getopts "r:p:s:S:C:F:t:" opt; do
  case ${opt} in
    r)
      RUN_MODE=$OPTARG
      ;;
    p)
      WITH_PROFILING=$OPTARG
      ;;
    s)
      # which slurm job's scripts (sbatch_job.sh and audiolm_pytorch_demo_laion.py) to use
      POTENTIAL_ALTERNATE_SLURM_JOB_ID=$OPTARG
      ;;
    S)
      SEMANTIC_CHECKPOINT_SLURM_JOB_ID=$OPTARG
      ;;
    C)
      COARSE_CHECKPOINT_SLURM_JOB_ID=$OPTARG
      ;;
    F)
      FINE_CHECKPOINT_SLURM_JOB_ID=$OPTARG
      ;;
    t)
      TRANSFORMER_TO_TARGET=$OPTARG # should be one of semantic, coarse, or fine. or just leave it blank for eval mode. Don't do -t evaluate
      ;;
    \?)
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))
OVERRIDABLE_SLURM_JOB_ID=${POTENTIAL_ALTERNATE_SLURM_JOB_ID:-$SLURM_JOB_ID}  # use this job's slurm job id by default, but allow overriding it with a custom value
SEMANTIC_CHECKPOINT_SLURM_JOB_ID=${SEMANTIC_CHECKPOINT_SLURM_JOB_ID:-$SLURM_JOB_ID}
COARSE_CHECKPOINT_SLURM_JOB_ID=${COARSE_CHECKPOINT_SLURM_JOB_ID:-$SLURM_JOB_ID}
FINE_CHECKPOINT_SLURM_JOB_ID=${FINE_CHECKPOINT_SLURM_JOB_ID:-$SLURM_JOB_ID}
if [[ ! -f audiolm_pytorch_demo_laion_$OVERRIDABLE_SLURM_JOB_ID.py || ! -f sbatch_job_$OVERRIDABLE_SLURM_JOB_ID.sh ]]; then
  cp audiolm_pytorch_demo_laion.py audiolm_pytorch_demo_laion_$OVERRIDABLE_SLURM_JOB_ID.py
  cp sbatch_job.sh sbatch_job_$OVERRIDABLE_SLURM_JOB_ID.sh
fi
echo "SLURM_JOB_ID: $OVERRIDABLE_SLURM_JOB_ID" >> ../audiolm-pytorch-results/output-$OVERRIDABLE_SLURM_JOB_ID.log
source venv/bin/activate # in case this hasn't already been done
echo "run mode: " $RUN_MODE
echo "with profiling: " $WITH_PROFILING
echo "slurm job id to actually use: " $OVERRIDABLE_SLURM_JOB_ID
TRAIN_OR_EVAL="evaluate"
if [ -n "$TRANSFORMER_TO_TARGET" ]; then
  TRAIN_OR_EVAL="train_$TRANSFORMER_TO_TARGET"
  accelerate launch audiolm_pytorch_demo_laion_$OVERRIDABLE_SLURM_JOB_ID.py --run_mode $RUN_MODE $WITH_PROFILING --train_or_eval $TRAIN_OR_EVAL --semantic_checkpoint_job_id $SEMANTIC_CHECKPOINT_SLURM_JOB_ID --coarse_checkpoint_job_id $COARSE_CHECKPOINT_SLURM_JOB_ID --fine_checkpoint_job_id $FINE_CHECKPOINT_SLURM_JOB_ID
else
  python audiolm_pytorch_demo_laion_$OVERRIDABLE_SLURM_JOB_ID.py --run_mode $RUN_MODE $WITH_PROFILING --train_or_eval $TRAIN_OR_EVAL --semantic_checkpoint_job_id $SEMANTIC_CHECKPOINT_SLURM_JOB_ID --coarse_checkpoint_job_id $COARSE_CHECKPOINT_SLURM_JOB_ID --fine_checkpoint_job_id $FINE_CHECKPOINT_SLURM_JOB_ID
fi
