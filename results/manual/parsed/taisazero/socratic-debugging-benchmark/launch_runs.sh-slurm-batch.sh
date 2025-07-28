#!/bin/bash
#FLUX: --job-name=socratic_exp
#FLUX: --queue=GPU
#FLUX: -t=86400
#FLUX: --urgency=16

source activate socratic_env
echo "loaded module"
cd $SLURM_SUBMIT_DIR
mkdir -p job_logs
echo "running code"
python -u run_socratic_benchmark_metrics.py --generation_mode multiple
echo "finished running"
cd $SLURM_SUBMIT_DIR
mv $SLURM_JOB_ID.o job_logs/$SLURM_JOB_ID.o
mv $SLURM_JOB_ID.e job_logs/$SLURM_JOB_ID.e
