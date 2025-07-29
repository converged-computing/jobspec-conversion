#!/bin/bash
#SBATCH --job-name=milestoning
#SBATCH --account=andricio_lab
#SBATCH --error=slurm-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=free

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
w_run -r west.cfg --work-manager processes --n-workers 4 "$@" &> west.log
