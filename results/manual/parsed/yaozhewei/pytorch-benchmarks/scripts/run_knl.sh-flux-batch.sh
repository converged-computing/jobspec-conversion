#!/bin/bash
#FLUX: --job-name=chocolate-snack-9641
#FLUX: --urgency=16

export OMP_NUM_THREADS='68'
export KMP_AFFINITY='granularity=fine,compact,1,0'
export KMP_BLOCKTIME='1'
export BENCHMARK_RESULTS_PATH='$SCRATCH/pytorch-benchmarks/knl-$version-n${SLURM_JOB_NUM_NODES}'

set -e
version=v1.3.1
clean=false
backend=mpi
models="alexnet vgg11 resnet50 inceptionV3 lstm cnn3d"
if [ $# -ge 1 ]; then models=$@; fi
export OMP_NUM_THREADS=68
export KMP_AFFINITY="granularity=fine,compact,1,0"
export KMP_BLOCKTIME=1
export BENCHMARK_RESULTS_PATH=$SCRATCH/pytorch-benchmarks/knl-$version-n${SLURM_JOB_NUM_NODES}
if $clean; then
    [ -d $BENCHMARK_RESULTS_PATH ] && rm -rf $BENCHMARK_RESULTS_PATH
fi
module load pytorch/$version
for m in $models; do
    srun -l python train.py -d $backend configs/${m}.yaml
done
echo "Collecting benchmark results..."
python parse.py $BENCHMARK_RESULTS_PATH -o $BENCHMARK_RESULTS_PATH/results.txt
