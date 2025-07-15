#!/bin/bash
#FLUX: --job-name=expensive-onion-7004
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --urgency=16

export BENCHMARK_RESULTS_PATH='$SCRATCH/pytorch-benchmarks/results/gpu-$version-$backend-n$SLURM_NTASKS'

set -e
version=1.7.1
backend=nccl
models="alexnet resnet50 lstm cnn3d transformer"
clean=false
usage="$0 --version VERSION --backend BACKEND --models \"MODELS ...\" --clean CLEAN"
while (( "$#" )); do
    case "$1" in
        --version)
            version=$2
            shift 2
            ;;
        --backend)
            backend=$2
            shift 2
            ;;
        --models)
            models=$2
            shift 2
            ;;
        --clean)
            clean=$2
            shift 2
            ;;
        *)
            echo "Usage: $usage"
            exit 1
            ;;
    esac
done
export BENCHMARK_RESULTS_PATH=$SCRATCH/pytorch-benchmarks/results/gpu-$version-$backend-n$SLURM_NTASKS
if $clean; then
    [ -d $BENCHMARK_RESULTS_PATH ] && rm -rf $BENCHMARK_RESULTS_PATH
fi
echo "Running PyTorch benchmarks with"
echo "version $version"
echo "backend $backend"
echo "models $models"
echo "clean $clean"
echo "writing outputs to $BENCHMARK_RESULTS_PATH"
module load pytorch/$version-gpu
module list
for model in $models; do
    srun -l python train.py configs/${model}.yaml -d $backend --rank-gpu \
        --output-dir $BENCHMARK_RESULTS_PATH/$model
done
echo "Collecting benchmark results..."
python parse.py $BENCHMARK_RESULTS_PATH -o $BENCHMARK_RESULTS_PATH/results.txt
