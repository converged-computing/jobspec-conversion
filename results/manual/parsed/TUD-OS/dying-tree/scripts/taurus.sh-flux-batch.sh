#!/bin/bash
#FLUX: --job-name=fugly-puppy-5175
#FLUX: -N=18
#FLUX: --exclusive
#FLUX: --queue=haswell64
#FLUX: -t=1800
#FLUX: --urgency=16

export MODULEPATH='~s9951545/.modules:$MODULEPATH'
export CORRT_GOSSIP_SEEDS='$RANDOM'

export MODULEPATH=~s9951545/.modules:$MODULEPATH
module load CMake/3.11.4-GCCcore-6.4.0 Python/3.6.4-foss-2018a OpenMPI/3.1.1-GCC-7.3.0-2.30 GCC/7.3.0-2.30
SCRIPTDIR="$( cd "$( dirname "$0" )" && pwd )"
BASEDIR=$HOME/corrected-mpi
DYING_LIB=$BASEDIR/dying/build/libdying.so
WORKDIR=$BASEDIR/osu-micro-benchmarks-5.4.1/mpi/collective
ITERATIONS=1000
MSG_SIZE_MIN="8"
MSG_SIZE_MAX="256"
MSG_SIZE="$MSG_SIZE_MIN:$MSG_SIZE_MAX"
CORRT_COUNT_MAX=$MSG_SIZE_MAX
TASKS_PER_NODE=$(echo $SLURM_TASKS_PER_NODE | sed 's/\(.*\)(.*).*/\1/g;s/[^0-9]//g')
REPETITION="2"
export CORRT_GOSSIP_SEEDS=$RANDOM
CORRT_GOSSIP_ROUNDSS=1
NNODES="{18,36,72}"
NNODES="18"
ALGORITHMS="7"
CORRT_DISS_TYPE=tree_binomial
CORRT_DISTS="{0,2}"
FAULTS="0"
FAULTS="{1,2}"
ALGORITHMS="7"
CORRT_DISS_TYPE=gossip
CORRT_DISTS="{0,2}"
CORRT_GOSSIP_SEEDS=23
CORRT_GOSSIP_ROUNDSS=25
FAULTS="0"
FAULTS="{1,2}"
ALGORITHMS="Wrapper"
CORRT_DISS_TYPE=tree_binomial
CORRT_DISTS="{0,1,2}"
FAULTS="0"
COMBINATIONS=$(eval echo "$ALGORITHMS+$NNODES+$CORRT_DISTS+$FAULTS+$CORRT_GOSSIP_SEEDS+$CORRT_GOSSIP_ROUNDSS")
FAULTS="36"
CORRT_DISTS="{1,2}"
COMBINATIONS="$COMBINATIONS "$(eval echo "$ALGORITHMS+$NNODES+$CORRT_DISTS+$FAULTS+$CORRT_GOSSIP_SEEDS+$CORRT_GOSSIP_ROUNDSS")
ALGORITHMS="Wrapper"
CORRT_DISS_TYPE=tree_lame
CORRT_DISTS="{0,1,2}"
TREE_LAME_KS="{1,2,4}"
FAULTS="0"
COMBINATIONS=$(eval echo "$ALGORITHMS+$NNODES+$CORRT_DISTS+$FAULTS+$CORRT_GOSSIP_SEEDS+$CORRT_GOSSIP_ROUNDSS")
FAULTS="36"
CORRT_DISTS="{1,2}"
COMBINATIONS="$COMBINATIONS "$(eval echo "$ALGORITHMS+$NNODES+$CORRT_DISTS+$FAULTS+$CORRT_GOSSIP_SEEDS+$CORRT_GOSSIP_ROUNDSS")
CORRT_DISS_TYPE=gossip
CORRT_GOSSIP_ROUNDSS="{14,15,16}"
CORRT_DISTS="4"
FAULTS="0"
FAULTS="36"
ALGORITHMS="6"
CORRT_DISTS="0"
FAULTS="0"
ALGORITHMS="Native"
CORRT_DISTS="0"
FAULTS="0"
COMBINATIONS="$COMBINATIONS "$(eval echo "$ALGORITHMS+$NNODES+$CORRT_DISTS+$FAULTS+$CORRT_GOSSIP_SEEDS+$CORRT_GOSSIP_ROUNDSS")
cd $WORKDIR
echo "Algorithm	Nnodes	Size	Avg	Min	Max	Iterations	Rep	Faults	GossipSeed	GossipRounds"
OUTDIR="$BASEDIR/logs/$(date "+%d%m%y_%H-%M-%S".$RANDOM).taurus"
mkdir -p $OUTDIR
echo $OUTDIR
for NNODES in $(eval echo $NNODES)
do
    mpiexec hostname | sort -u | tail -n $NNODES > $OUTDIR/hostfile.$NNODES
done
cat $SCRIPTDIR/$0 > $OUTDIR/script.sh
env > $OUTDIR/script.env
for i in $(seq 1 $REPETITION)
do
    for EXPERIMENT in $COMBINATIONS
    do
	read ALGORITHM NNODES CORRT_DIST FAULT CORRT_GOSSIP_SEED CORRT_GOSSIP_ROUNDS <<<$(IFS="+"; echo $EXPERIMENT)
	export NPROC=$(($TASKS_PER_NODE*$NNODES))
	OUTFILE="$OUTDIR/$EXPERIMENT+$TASKS_PER_NODE+$NPROC+$i"
	# Rank zero may never die
	DYING_LIST=($(shuf -i 1-$(($NPROC - 1)) -n $FAULT))
	# DYING_LIST=($(seq 1 $FAULT))
	DYING_LIST=$(IFS=';'; echo "${DYING_LIST[*]}")
	export DYING_LIST
	export CORRT_DIST
	export CORRT_COUNT_MAX
	EXPORT="-x DYING_LIST=$DYING_LIST -x CORRT_DISS_TYPE=$CORRT_DISS_TYPE -x CORRT_DIST=$CORRT_DIST -x CORRT_COUNT_MAX=$CORRT_COUNT_MAX -x CORRT_GOSSIP_SEED=$CORRT_GOSSIP_SEED -x CORRT_GOSSIP_ROUNDS=$CORRT_GOSSIP_ROUNDS"
	case "$ALGORITHM" in
	    'Native')
		# Nothing
		;;
	    'Wrapper')
		EXPORT="$EXPORT -x LD_PRELOAD=$DYING_LIB"
		;;
	    *)
		EXPORT="$EXPORT --mca pml ob1 --mca coll_tuned_bcast_algorithm $ALGORITHM"
		EXPORT="$EXPORT --mca coll_tuned_use_dynamic_rules 1"
		EXPORT="$EXPORT -x LD_PRELOAD=$DYING_LIB"
		;;
	esac
	echo "$DYING_LIST" > $OUTFILE
	echo "$EXPERIMENT"
	echo mpiexec $EXPORT -np $NPROC --map-by core --bind-to core bash -c "ulimit -s 10240; $WORKDIR/osu_bcast -m $MSG_SIZE -f -i $ITERATIONS"
	OUT=$(mpiexec $EXPORT -np $NPROC --map-by core --bind-to core bash -c "ulimit -s 10240; $WORKDIR/osu_bcast -m $MSG_SIZE -f -i $ITERATIONS")
	echo "$OUT"
	echo "$OUT" | grep -v WARN | tail -n +3 >> $OUTFILE
    done
done
