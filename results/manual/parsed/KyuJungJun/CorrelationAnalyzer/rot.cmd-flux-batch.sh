#!/bin/bash
#FLUX: --job-name=blank-latke-6328
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export LD_PRELOAD='/home1/apps/tacc-patches/getcwd-patch.so:$LD_PRELOAD'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export LD_PRELOAD=/home1/apps/tacc-patches/getcwd-patch.so:$LD_PRELOAD
conda activate base
cd 900K;
cp /work2/06107/tg854062/stampede2/LPS_aimd_trajectories/CorrelationAnalyzer/TrajectoryAnalyzerQuat.py .;
cp /work2/06107/tg854062/stampede2/LPS_aimd_trajectories/CorrelationAnalyzer/rots_2023.py .;
python rots_2023.py 900;
