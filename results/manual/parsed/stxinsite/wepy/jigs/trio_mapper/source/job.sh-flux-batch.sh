#!/bin/bash
#FLUX: --job-name=lysozyme_test
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

export ANACONDA_DIR='$HOME/.pyenv/versions/miniconda3-latest'

trap teardown SIGINT
teardown () {
    echo "caught signal tearing processes down"
    kill "$node_exporter_pid"
    echo "Killed node_exporter proc"
    kill "$nvidia_exporter_pid"
    echo "Killed nvidia_exporter proc"
    exit 1
}
echo "----------------------"
echo "Running on host: $(hostname)"
echo "----------------------"
./_bin/node_exporter &
node_exporter_pid="$!"
echo "Started the node_exporter as PID: $node_exporter_pid"
./_bin/nvidia_gpu_prometheus_exporter &
nvidia_exporter_pid="$!"
echo "Started the nvidia_gpu_prometheus_exporter as PID: $nvidia_exporter_pid"
module purge
module load GCC/8.3.0
module load CUDA/10.1.243
module list
export ANACONDA_DIR="$HOME/.pyenv/versions/miniconda3-latest"
. ${ANACONDA_DIR}/etc/profile.d/conda.sh
which python
conda activate ./_env || teardown
which python
python -m simtk.testInstallation
echo "Running main process"
python source/lysozyme_we.py 1000 10000 48 8 'CUDA' 'WExploreResampler' 'WorkerMapper' 'debug_gpu' || teardown
teardown
