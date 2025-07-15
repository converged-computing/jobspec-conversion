#!/bin/bash
#FLUX: --job-name=milestoning
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

module load cuda/10.1.243
module load namd/2.14b2/gcc.8.4.0-cuda.10.1.243
source /data/homezvol2/dray1/Miniconda2/etc/profile.d/conda.sh
cd equilibration
namd2 +p 4 equilibration.conf > equilibration.log
python calc_rxn_coor.py > distance.dat
cd ..
source env.sh
rm -rf traj_segs seg_logs istates west.h5 binbounds.txt
mkdir   seg_logs traj_segs istates
cp equilibration/distance.dat bstates/dist.dat
cp equilibration/milestone_equilibration.restart.coor bstates/seg.coor
cp equilibration/milestone_equilibration.colvars.traj  bstates/seg.colvars.traj
cp equilibration/milestone_equilibration.restart.vel  bstates/seg.vel
cp equilibration/milestone_equilibration.restart.xsc  bstates/seg.xsc
cp common_files/colvars.in bstates/colvars.in
BSTATE_ARGS="--bstate-file $WEST_SIM_ROOT/bstates/bstates.txt"
$WEST_ROOT/bin/w_init $BSTATE_ARGS  $TSTATE_ARGS  --segs-per-state 4  --work-manager=threads "$@"
rm -f west.log 
$WEST_ROOT/bin/w_run -r west.cfg --work-manager processes --n-workers 1 "$@" &> west.log
