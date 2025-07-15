#!/bin/bash
#FLUX: --job-name=anxious-lemon-1556
#FLUX: --priority=16

DATADIR=/lustre/orion/scratch/zw241/csc143/VisPerfData/RedSeaDecomposition
RUNDIR=/lustre/orion/scratch/zw241/csc143/VisPerfExpAssignStrategeis_RedSea_${1}
CURRDIR=$(pwd)
mkdir $RUNDIR
cd $RUNDIR
ln -s $CURRDIR/../install/visReader/workloadEstimation/StreamlineMPI StreamlineMPI
ln -s $CURRDIR/../install/visReader/workloadEstimation/StreamlineMPI2 StreamlineMPI2
ln -s $CURRDIR/../install/visReader/visitReaderAdev visitReaderAdev
STEPSIZE_REDSEA=0.1
MAXSTEPS=2000
NUM_SIM_POINTS_PER_DOM=1000
NUM_TEST_POINTS=50
NXYZ=4
WIDTH_PCT=0.1
echo "NUM_TEST_POINTS:"$NUM_TEST_POINTS
echo "NXYZ:"$NXYZ
echo "WIDTH_PCT:"$WIDTH_PCT
NUM_NODE=1
NUM_RANK=32
NUM_BLOCKS=32
mkdir one_data_per_rank
cd one_data_per_rank
call_redsea () {
echo "number of node ${1} number of ranks ${2}"
echo "executing streamline on dataset ${3} execution index is ${4} strategy ${5}"
srun -N ${1} -n ${2} ../visitReaderAdev \
--vtkm-device serial \
--file=$DATADIR/${3} \
--advect-num-steps=$MAXSTEPS \
--advect-num-seeds=$NUM_SIM_POINTS_PER_DOM \
--seeding-method=domainrandom \
--advect-seed-box-extents=0.010000,498.99,0.010000,498.99,0.010000,98.99 \
--field-name=velocity \
--advect-step-size=$STEPSIZE_REDSEA \
--record-trajectories=false \
--output-results=false \
--sim-code=cloverleaf \
--assign-strategy=${5} \
--block-manual-id=true \
--communication=async_probe &> readerlog_${4}.out
}
DATA_NAME=fb_RedSea0001.4_4_2.128_128_64.visit
call_redsea $NUM_NODE $NUM_RANK $DATA_NAME 0 roundroubin
cd ..
log_suffix=_r${NUM_RANK}_tp${NUM_TEST_POINTS}_nxyz${NXYZ}_pc${WIDTH_PCT}.log
estimate_log_file=sl2_estimate_redsea${log_suffix}
parser_log=parser_log.log
srun -N $NUM_NODE -n $NUM_RANK ./StreamlineMPI2 $DATADIR/${DATA_NAME} velocity $STEPSIZE_REDSEA $MAXSTEPS $NUM_TEST_POINTS $NUM_SIM_POINTS_PER_DOM $NXYZ &> ${estimate_log_file}
python3 $CURRDIR/parser_compare_actual_and_estimation_run.py $RUNDIR/one_data_per_rank $RUNDIR/${estimate_log_file} ${NUM_RANK} &> ${parser_log}
mkdir rrb_placement
cd rrb_placement
NUM_RANK_REDUCED=8
python3 $CURRDIR/generate_assignment_rrb.py $NUM_BLOCKS $NUM_RANK_REDUCED
sleep 1
for run_index in {1..3}
do
call_redsea $NUM_NODE $NUM_RANK_REDUCED $DATA_NAME $run_index file
done
cd ..
mkdir bpacking_placement_actual_log
cd bpacking_placement_actual_log
python3 $CURRDIR/generate_assignment_actual_bpacking.py ../${parser_log} $NUM_BLOCKS $NUM_RANK_REDUCED
sleep 1
for run_index in {1..3}
do
call_redsea $NUM_NODE $NUM_RANK_REDUCED $DATA_NAME $run_index file
done
cd ..
mkdir bpacking_dup_placement_actual_log
cd bpacking_dup_placement_actual_log
python3 $CURRDIR/generate_assignment_actual_bpacking_dup.py ../${parser_log} $NUM_BLOCKS $NUM_RANK_REDUCED
sleep 1
for run_index in {1..3}
do
call_redsea $NUM_NODE $NUM_RANK_REDUCED $DATA_NAME $run_index file
done
cd ..
mkdir bpacking_dup_two_stages_actual_log
cd bpacking_dup_two_stages_actual_log
python3 $CURRDIR/generate_assignment_actual_bpacking_dup_stages2.py $RUNDIR $NUM_BLOCKS $NUM_BLOCKS $NUM_RANK_REDUCED 10 ../${parser_log}
sleep 1
for run_index in {1..3}
do
call_redsea $NUM_NODE $NUM_RANK_REDUCED $DATA_NAME $run_index file
done
cd ..
