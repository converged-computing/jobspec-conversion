#!/bin/bash
#SBATCH --account=project_2004600
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=1428G
#SBATCH --time=1-00:00:00

export HF_DATASETS_CACHE='$CACHEDIR'

DATADIR="texts"
OUTDIR="processed"
TOKENIZER="tokenizer"
rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
module purge
module load pytorch
CACHEDIR="$PWD/datasets_cache_$SLURM_JOBID"
export HF_DATASETS_CACHE="$CACHEDIR"
function on_exit {
    rm -f "$CACHEDIR"
}
trap on_exit EXIT
NUM_WORKERS=$SLURM_CPUS_PER_TASK
echo "START $SLURM_JOBID: $(date)"
python prepare_data.py \
       --data "$DATADIR" \
       --tokenizer "$TOKENIZER" \
       --output_dir "$OUTDIR" \
       --num_workers $NUM_WORKERS \
       --in_memory_max_size 1024
seff $SLURM_JOBID
echo "END $SLURM_JOBID: $(date)"
