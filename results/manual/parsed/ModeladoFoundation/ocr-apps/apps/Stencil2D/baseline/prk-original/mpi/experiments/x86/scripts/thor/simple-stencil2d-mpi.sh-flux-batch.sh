#!/bin/bash
#FLUX: --job-name=dirty-signal-0553
#FLUX: --queue=XAS
#FLUX: --priority=16

export I_MPI_DEBUG='3'
export NODEFILE='$runhm/hfile.txt.$$'
export MYITAC=' '
export MYHPCTK=' '

scale=$1
runhm=$2
MYITACIN=$3
psize=$4
EXE=$5
ph=$6
cd ${runhm}
nnodes=$SLURM_NNODES
np="`echo "${nnodes}*$ph"|bc`"
pow2tmp=`echo "l(${nnodes})/l(2)" |bc -l`
printf -v pow2 %.0f "$pow2tmp"
ntiles=(36 72 144 288 576 1152 2304)
nitr=100 #number of iterations
export I_MPI_DEBUG=3
export NODEFILE=$runhm/hfile.txt.$$
pdsh -N -w "${SLURM_NODELIST}" hostname |sort > ${NODEFILE}
export MYITAC=" "
export MYHPCTK=" "
case $MYITACIN in
    p2p)
	### generate itac trace files.
	source /opt/intel/itac_latest/bin/itacvars.sh -s
	export MYITAC="-trace -trace-pt2pt"
	;;
    coll)
	source /opt/intel/itac_latest/bin/itacvars.sh -s
	export MYITAC="-trace -trace-collectives"
	;;
    all)
	source /opt/intel/itac_latest/bin/itacvars.sh -s
	# change this to point to where your vtconfig file is.
	export VT_CONFIG="./vtconfig.conf"
	export MYITAC="-trace "
	export VT_PCTRACE=6
	;;
    hpctoolkit)
	export PATH=/home/rsalmon/dhome/fastfw/src/hpctoolkit/install/bin:$PATH
	hpcstruct ${EXE}
	export MYHPCTK="hpcrun -t -o ./hpcg_meas -e WALLCLOCK@5000"
	;;
    none)
	export MYITAC=" "
	export MYHPCTK=" "
esac
case $scale in
    strong)
	#strong scaling test. Problem size stays constant.
	case $psize in
	    small)
		gsize=23170
		;;
	    medium)
		gsize=32768  # Medium problem size
		;;
	    large)
		gsize=46340  # large problem size
	esac
	i=`echo "${pow2}-1"|bc`
	lname=$scale.np.$np.log
	echo "##s########################## np=$np #############################"
	echo "    problem size          Rank config"
	echo " ${gsize} x ${gsize} "
	echo "mpirun -f $NODEFILE -perhost ${ph} ${MYITAC} -np ${np} ${MYHPCTK} ${EXE} ${nitr} ${gsize} "
	mpirun -f $NODEFILE -perhost ${ph} ${MYITAC} -np ${np} ${MYHPCTK} ${EXE} ${nitr} ${gsize}
	;;
    weak)
	case $psize in
	    small)
		gsize=(9216 9216 18432 18432 36864 36864 73728)
		;;
	    medium)
		gsize=(18432 18432 36864 36864 73728 73728 147456)  # Medium problem size
		;;
	    large)
		gsize=(36864 36864 73728 73728 147456 147456 294912) # Large problem size
	esac
	i=`echo "${pow2}-1"|bc`
	lname=$scale.np.$np.log
	echo "##w########################## np=$np #############################"
	echo "    problem size          Rank config"
	echo " ${gsize[$i]} x ${gsize[$i]}             ${ntiles[$i]}"
	echo "mpirun -f $NODEFILE -perhost ${ph} ${MYITAC} -np ${np} ${MYHPCTK} ${EXE} ${nitr} ${gsize[$i]} "
	mpirun -f $NODEFILE -perhost ${ph} ${MYITAC} -np ${np} ${MYHPCTK} ${EXE} ${nitr} ${gsize[$i]}
esac
case $MYITACIN in
    hpctoolkit)
	hpcprof-mpi -S xhpcg.hpcstruct -I . -o hpcg.db ./hpcg_meas
esac
