#!/bin/bash
#FLUX: --job-name=$1
#FLUX: -c=32
#FLUX: --queue=binf
#FLUX: --urgency=16

cat << EOF  | sbatch
module load cuda10.2
ALG_DIR=$1
ALG_FILE=$2
SLURM_OUT=\$SLURM_SUBMIT_DIR/$1_\$SLURM_JOB_ID.out
save_last_model()
{
echo "time limit expired, so save the last model at \$(date)"
}
trap 'save_last_model' TERM
do_computation() {
BASE_DIR=my-path/pipenn
MODEL_DIR=\$BASE_DIR/models
LOG_DIR=\$BASE_DIR/logs
rm -f \$LOG_DIR/$ALG_DIR.log
cd \$BASE_DIR/$ALG_DIR
pwd
python $ALG_FILE
cp \$LOG_DIR/$ALG_DIR.log \$MODEL_DIR/$ALG_DIR/.
}
echo "starting computation at \$(date)"
do_computation &
wait
EOF
