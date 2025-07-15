#!/bin/bash
#FLUX: --job-name=qfm
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='4'

module load intel/19.1.2
module load python/intel/3.8.6
module load openmpi/intel/4.0.5
export OMP_NUM_THREADS=4
cd /scratch/fw18/stochastic-stage-two/src/Stochastic-Stage-II-Optimization-2/
source /scratch/fw18/stochastic-stage-two/bin/activate
mkdir -p logs
mkdir -p output
WELL="--well"
SIDX=`expr $SLURM_ARRAY_TASK_ID - 1`
for OUTDIRIDX in 0 1 2 3 4 5 6 7; do
    for SIGMA in 1e-3; do
        for CL in 0; do
            python3 eval_compute_qfm.py  $WELL  --outdiridx $OUTDIRIDX --sampleidx $SIDX --sigma $SIGMA --correctionlevel $CL --flux 0.25
            python3 eval_compute_qfm.py  $WELL  --outdiridx $OUTDIRIDX --sampleidx $SIDX --sigma $SIGMA --correctionlevel $CL --flux 1.0
        done
    done
done
for OUTDIRIDX in 3; do
    for SIGMA in 1e-3; do
        for CL in 1 2 3; do
            python3 eval_compute_qfm.py  $WELL  --outdiridx $OUTDIRIDX --sampleidx $SIDX --sigma $SIGMA --correctionlevel $CL --flux 0.25
            python3 eval_compute_qfm.py  $WELL  --outdiridx $OUTDIRIDX --sampleidx $SIDX --sigma $SIGMA --correctionlevel $CL --flux 1.0
        done
    done
done
