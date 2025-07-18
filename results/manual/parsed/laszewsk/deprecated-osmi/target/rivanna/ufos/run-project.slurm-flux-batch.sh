#!/bin/bash
#FLUX: --job-name=train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=43200
#FLUX: --urgency=16

export RUN_DIR='$PROJECT/osmi'

echo "# cloudmesh status=running progress=1 pid=$$"
nvidia-smi
echo "# cloudmesh status=running progress=3 pid=$$"
export RUN_DIR=$PROJECT/osmi
output_dir="$RUN_DIR/osmi-output"
benchmark="$RUN_DIR/benchmark"
rivanna="$RUN_DIR/machine/rivanna"
echo "# cloudmesh status=running progress=5 pid=$$"
time cd $RUN_DIR
echo "# cloudmesh status=running progress=6 pid=$$"
echo "# cloudmesh status=running progress=7 pid=$$"
module load anaconda
conda activate OSMI
time pip install --user -r $rivanna/requirements-rivanna.txt
echo "# cloudmesh status=running progress=10 pid=$$"
echo "# cloudmesh status=running progress=40 pid=$$"
echo "# ======= SERVER START"
cd $benchmark
time singularity run --nv --home `pwd` $RUN_DIR/serving_latest-gpu.sif tensorflow_model_server --port=8500 --rest_api_port=0 --model_config_file=models.conf >& $output_dir/log &
echo "# cloudmesh status=running progress=45 pid=$$"
start_wait_for_server=`date +%s`
echo start_wait_for_server $start_wait_for_server
for sec in $(seq -w 10000 -1 1); do
    if [[ $(lsof -i :8500) ]]; then break; fi
done
end_wait_for_server=`date +%s`
echo end_wait_for_server $end_wait_for_server
time_server_wait=$((start_wait_for_server-end_wait_for_server))
echo time_server_wait $time_server_wait
echo "# ======= SERVER UP"
echo "# cloudmesh status=running progress=50 pid=$$"
echo "# cloudmesh status=running progress=60 pid=$$"
echo "# ======= START"
time python metabench.py $rivanna/rivanna-A100.yaml -o $output_dir/a100-results.csv
echo "# ======= END"
echo "# cloudmesh status=running progress=90 pid=$$"
seff $SLURM_JOB_ID
echo "# cloudmesh status=running progress=100 pid=$$"
