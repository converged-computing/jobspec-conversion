#!/bin/bash
#FLUX: --job-name=o2-pentane_short
#FLUX: -n=8
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load   StdEnv/2020  intel/2020.1.217 namd-multicore/2.14
for CYCLE in  `seq 1 5`;
do
	echo "Cycle $CYCLE"
	export CYCLE=$CYCLE
	namd2 +p8 eq.conf > eq.log
	namd2 +p8 prod.conf > prod.log
	python ../removePBC.py prod_$CYCLE.colvars.traj prod_$CYCLE.unwrap.colvars.traj 33.20715
done
