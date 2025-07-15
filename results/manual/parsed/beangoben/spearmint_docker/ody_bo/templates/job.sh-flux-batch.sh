#!/bin/bash
#FLUX: --job-name=chocolate-knife-0761
#FLUX: --priority=16

module load gcc/4.9.3-fasrc01 tensorflow/1.0.0-fasrc03
source activate keras_cpu
JOB_NAME={{job_name}}
SCRIPT={{script_name}}
CUR_DIR=$(pwd)
SCRATCH=/scratch
RESULTS=$(pwd)
touch $CUR_DIR/$JOB_NAME.start
echo "setuping up directories"
echo "  at ${JOB_NAME}/${SLURM_JOB_ID}"
cd $SCRATCH
mkdir -p bo_${JOB_NAME}/${SLURM_JOB_ID}
cd ${JOB_NAME}/${SLURM_JOB_ID}
cp -v ${CUR_DIR}/${SCRIPT} .
cp -v ${CUR_DIR}/params.json .
echo "running python"
python ${SCRIPT} > results.out 2>&1
echo "copy results"
mv results.out $RESULTS
touch $CUR_DIR/$JOB_NAME.done
