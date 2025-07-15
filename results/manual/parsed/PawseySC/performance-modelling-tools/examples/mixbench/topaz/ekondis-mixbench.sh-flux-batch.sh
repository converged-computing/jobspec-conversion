#!/bin/bash
#FLUX: --job-name=gloopy-train-1974
#FLUX: -c=8
#FLUX: --queue=gpuq-dev
#FLUX: -t=3600
#FLUX: --urgency=16

module load python/3.6.3
module load cuda/11.4.2
module load cmake/3.18.0
mixbench="mixbench-cuda"
cwd=$(pwd)
PERFMODELING="${PERF_ROOT:-$MYGROUP/performance-modelling-tools}"
ODIR="${PERF_ODIR:-$cwd/${HOSTNAME}/$(date +"%Y-%m-%d-%H-%M")}"
echo "Saving results to : $ODIR"
mkdir -p $ODIR
cd $ODIR
git clone https://github.com/ekondis/mixbench.git
mkdir build
cd build
cmake $ODIR/mixbench/$mixbench
make
srun --exact \
     --ntasks=1 \
     --cpus-per-task=1 \
     --ntasks-per-socket=1 \
     --threads-per-core=1 \
     $mixbench > $ODIR/mixbench-log.txt
rm -rf $ODIR/mixbench $ODIR/build
python3 $PERFMODELING/bin/mixbench-report.py --csv --json $ODIR/mixbench-log.txt
