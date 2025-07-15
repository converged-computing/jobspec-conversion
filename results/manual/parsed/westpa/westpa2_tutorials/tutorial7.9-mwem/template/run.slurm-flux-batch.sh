#!/bin/bash
#FLUX: --job-name=milestoning
#FLUX: -c=4
#FLUX: --urgency=16

source env.sh
cd equilibration
$NAMD_PATH/namd2 +p 4 equilibration.conf > equilibration.log
python calc_rxn_coor.py > distance.dat
cd ..
rm -rf traj_segs seg_logs istates west.h5 binbounds.txt
mkdir   seg_logs traj_segs istates
cp equilibration/progress_coordinate.dat bstates/progress_coordinate.dat
cp equilibration/milestone_equilibration.restart.coor bstates/seg.coor
cp equilibration/milestone_equilibration.colvars.traj  bstates/seg.colvars.traj
cp equilibration/milestone_equilibration.restart.vel  bstates/seg.vel
cp equilibration/milestone_equilibration.restart.xsc  bstates/seg.xsc
cp common_files/colvars.in bstates/colvars.in
BSTATE_ARGS="--bstate-file $WEST_SIM_ROOT/bstates/bstates.txt"
w_init $BSTATE_ARGS  --segs-per-state 4  --work-manager=threads "$@"
rm -f west.log 
w_run -r west.cfg --work-manager processes --n-workers 1 "$@" &> west.log
