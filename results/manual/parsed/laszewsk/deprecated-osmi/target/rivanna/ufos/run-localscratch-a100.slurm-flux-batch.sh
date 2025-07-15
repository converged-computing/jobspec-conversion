#!/bin/bash
#FLUX: --job-name=osmi-a100-localscratch
#FLUX: --queue=bii-gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export BASE='/localscratch'
export RUN_DIR='$BASE/$USER/osmi'
export EXEC_DIR='$RUN_DIR/machine/rivanna'
export PROJECT_DIR='$PROJECT/osmi'
export PORT_TF_SERVER='8500'

echo "# cloudmesh status=running progress=1 pid=$$"
nvidia-smi
echo "# cloudmesh status=running progress=2 pid=$$"
export BASE=/localscratch
export RUN_DIR=$BASE/$USER/osmi
export EXEC_DIR="$RUN_DIR/machine/rivanna"
output_dir="$RUN_DIR/osmi-output"
benchmark="$RUN_DIR/benchmark"
export PROJECT_DIR=$PROJECT/osmi
export PORT_TF_SERVER=8500
echo "# cloudmesh status=running progress=3 pid=$$"
time mkdir -p $RUN_DIR
time rsync -r $PROJECT_DIR $RUN_DIR/.. --exclude=.git --exclude=Makefile --exclude=ENV3 --exclude=results.ipynb --exclude=*.md --exclude=*.sif --exclude=osmi-output/*
echo "# cloudmesh status=running progress=4 pid=$$"
echo "# cloudmesh status=running progress=5 pid=$$"
time cd $RUN_DIR
echo "# cloudmesh status=running progress=6 pid=$$"
ls
du -h $RUN_DIR
echo "# cloudmesh status=running progress=7 pid=$$"
diff $PROJECT_DIR $RUN_DIR/..
echo "# cloudmesh status=running progress=8 pid=$$"
module purge
module load  gcc/9.2.0  cuda/11.0.228  openmpi/3.1.6 python/3.8.8
source $PROJECT_DIR/ENV3/bin/activate
echo "# cloudmesh status=running progress=10 pid=$$"
cms gpu watch --gpu=0 --delay=0.5 --dense > $output_dir/a100-gpu.log &
echo "# cloudmesh status=running progress=40 pid=$$"
echo "# ======= SERVER START"
cd $benchmark
time singularity exec --nv --home `pwd` $HOME_DIR/serving_latest-gpu.sif tensorflow_model_server --port=$PORT_TF_SERVER --rest_api_port=0 --model_config_file=models.conf >& $output_dir/a100-$PORT_TF_SERVER.log &
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
time python metabench.py $EXEC_DIR/rivanna-A100.yaml -o $output_dir/a100-results-localscratch.csv
time python metabench.py $EXEC_DIR/fig4-A100-n128.yaml -o $output_dir/a100-results-localscratch-fig4.csv
echo "# ======= END"
echo "# cloudmesh status=running progress=90 pid=$$"
time rsync -r -v $output_dir/a100* $PROJECT_DIR/osmi-output
seff $SLURM_JOB_ID
echo "# cloudmesh status=running progress=100 pid=$$"
