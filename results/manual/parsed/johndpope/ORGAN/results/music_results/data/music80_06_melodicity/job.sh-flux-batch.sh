#!/bin/bash
#FLUX: --job-name=music80_06_melodicity
#FLUX: -n=8
#FLUX: --queue=aagk80
#FLUX: -t=1728000
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

export OMP_NUM_THREADS=8
module load cuda/7.5-fasrc02 cudnn/7.0-fasrc02
module load gcc/4.9.3-fasrc01 tensorflow/1.0.0-fasrc04
source activate tfgpu
JOB_NAME=music80_06_melodicity
PY_SCRIPT='train_ogan.py'
CUR_DIR=$(pwd)
SCRATCH=/scratch
RESULTS=$(pwd)
touch $CUR_DIR/$JOB_NAME.start
echo "setuping up directories"
echo "  at ${SCRATCH}/${JOB_NAME}/${SLURM_JOB_ID}"
cd $SCRATCH
mkdir -p $JOB_NAME/$SLURM_JOB_ID
cd $JOB_NAME/$SLURM_JOB_ID
cp -Rv $CUR_DIR/* .
echo "running python"
python ${PY_SCRIPT}  2>&1 | tee ${CUR_DIR}/results.out
echo "copy results"
mv ${JOB_NAME}.out $RESULTS
cp -r * $RESULTS
touch $CUR_DIR/$JOB_NAME.done
