#!/bin/bash
#FLUX: --job-name=osmi-a100-nvidia
#FLUX: --queue=bii-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "# cloudmesh status=running progress=1 pid=$$"
nvidia-smi
hostname
echo "# cloudmesh status=running progress=2 pid=$$"
NAME=cloudmesh-nvidia
RUN_DIR=$PROJECT/osmi
OUTPUT_DIR="$RUN_DIR/osmi-output"
BENCHMARK_DIR="$RUN_DIR/benchmark"
EXEC_DIR=$RUN_DIR/machine/rivanna
PORT_TF_SERVER=8500
echo "# cloudmesh status=running progress=3 pid=$$"
time mkdir -p $OUTPUT_DIR
echo "# cloudmesh status=running progress=4 pid=$$"
echo "# cloudmesh status=running progress=5 pid=$$"
time cd $RUN_DIR
echo "# cloudmesh status=running progress=6 pid=$$"
ls
du -h $RUN_DIR
echo "# cloudmesh status=running progress=7 pid=$$"
echo "# cloudmesh status=running progress=8 pid=$$"
module purge
module load singularity
echo "# cloudmesh status=running progress=10 pid=$$"
echo "# cloudmesh status=running progress=40 pid=$$"
echo "# ======= SERVER START"
cd $BENCHMARK_DIR
time singularity exec --nv --home `pwd` $EXEC_DIR/serving_latest-gpu.sif tensorflow_model_server --port=$PORT_TF_SERVER --rest_api_port=0 --model_config_file=models.conf >& $OUTPUT_DIR/v100-$PORT_TF_SERVER.log &
echo "# cloudmesh status=running progress=45 pid=$$"
start_wait_for_server=`date +%s`
echo start_wait_for_server $start_wait_for_server
for sec in $(seq -w 10000 -1 1); do
    if [[ $(lsof -i :$PORT_TF_SERVER) ]]; then break; fi
    sleep 0.5
    echo "-"
done
end_wait_for_server=`date +%s`
echo "server up"
echo end_wait_for_server $end_wait_for_server
time_server_wait=$((end_wait_for_server-start_wait_for_server))
echo time_server_wait $time_server_wait
echo "# ======= SERVER UP"
echo "# cloudmesh status=running progress=50 pid=$$"
echo "# cloudmesh status=running progress=60 pid=$$"
echo "# ======= START"
singularity exec --nv --bind /localscratch:/localscratch $EXEC_DIR/$NAME.sif \
    python $BENCHMARK_DIR/metabench.py $EXEC_DIR/rivanna-A100.yaml \
    -o $OUTPUT_DIR/a100-results-localscratch.csv
singularity exec --nv --bind /localscratch:/localscratch $EXEC_DIR/$NAME.sif \
    python $BENCHMARK_DIR/metabench.py $EXEC_DIR/fig4-A100-n128.yaml \
    -o $OUTPUT_DIR/a100-results-localscratch-fig4.csv
echo "# ======= END"
echo "# cloudmesh status=running progress=90 pid=$$"
seff $SLURM_JOB_ID
echo "# cloudmesh status=running progress=100 pid=$$"
