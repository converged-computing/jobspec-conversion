#!/bin/bash
#FLUX: --job-name=Allscale.ipic3d.only.shared
#FLUX: -N=2
#FLUX: -t=14400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/cfs/klemming/nobackup/r/riakymch/allscale_compiler/build/allscale_runtime-prefix/src/allscale_runtime-build/src:/cfs/klemming/nobackup/r/riakymch/allscale_compiler/build/third_party/boost/lib:/cfs/klemming/nobackup/r/riakymch/allscale_compiler/build/hpx-prefix/src/hpx-build/lib'
export PATH='/cfs/klemming/nobackup/p/philgs/allscale/libs/ruby-1.9.3-p125/bin:$PATH'
export CRAYPE_LINK_TYPE='dynamic'
export CRAY_ROOTFS='DSL'

APP=/cfs/klemming/nobackup/r/riakymch/workspace/allscale_ipic3d/build/ipic3d_allscalecc
HOME=/cfs/klemming/nobackup/r/riakymch/workspace/allscale_ipic3d
module swap PrgEnv-cray PrgEnv-gnu
module swap gcc gcc/7.3.0
module load cmake/3.7.1 
module load git
export LD_LIBRARY_PATH=/cfs/klemming/nobackup/p/philgs/allscale/libs/ncurses-5.9/lib:$LD_LIBRARY_PATH
export PATH=/cfs/klemming/nobackup/p/philgs/allscale/libs/ruby-1.9.3-p125/bin:$PATH
export CRAYPE_LINK_TYPE=dynamic
export CRAY_ROOTFS=DSL
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cfs/klemming/nobackup/r/riakymch/allscale_compiler/build/allscale_runtime-prefix/src/allscale_runtime-build/src:/cfs/klemming/nobackup/r/riakymch/allscale_compiler/build/third_party/boost/lib:/cfs/klemming/nobackup/r/riakymch/allscale_compiler/build/hpx-prefix/src/hpx-build/lib
for RES in 0 1
do
	for MON in 0 1
	do
		export ALLSCALE_MONITOR=$MON
		export ALLSCALE_RESILIENCE=$RES
        echo "Running on ipic3d with MONITORING=$ALLSCALE_MONITOR and RESILIENCE=$ALLSCALE_RESILIENCE"
		for PARTICLES in 1000000 2000000 4000000 8000000 16000000 32000000
		do
			PARTICLES=$((PARTICLES * SLURM_NNODES))
			aprun -n 2 -N 1 $APP :E:$PARTICLES --hpx:threads=32 
		done
	done
done
