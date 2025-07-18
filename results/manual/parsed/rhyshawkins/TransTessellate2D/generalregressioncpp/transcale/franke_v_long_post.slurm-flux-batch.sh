#!/bin/bash
#FLUX: --job-name=posttasvv
#FLUX: --queue=transcale
#FLUX: -t=21600
#FLUX: --urgency=16

export INTEL_LICENSE_FILE='/softs/intel/l_ics/license:$INTEL_LICENSE_FILE'

source /softs/intel/l_ics/2017_update4/compilers_and_libraries_2017.4.196/linux/bin/compilervars.sh intel64
source /softs/intel/l_ics/2017_update4/compilers_and_libraries_2017.4.196/linux/mpi/intel64/bin/mpivars.sh intel64
export INTEL_LICENSE_FILE=/softs/intel/l_ics/license:$INTEL_LICENSE_FILE
BASE=/home_nfs/lgltpe/rhys.hawkins/software/GeneralVoronoiCartesian/
LBIN=$BASE/generalregressioncpp/post_likelihood_mpi
BIN=$BASE/generalregressioncpp/post_mean_mpi
TBIN=$BASE/generalregressioncpp/post_mean_tide_mpi
DATABASE=$BASE/generalregressioncpp/example_franke_hmc_pt
INPUT=$DATABASE/syntheticobs_franke.txt
RESULTSBASE=/erc_transcale/rhys.hawkins/regression/
RESULTS=$RESULTSBASE/results_frankev_long/
OUTPUT=$RESULTS/post
mkdir -p $OUTPUT
cd $OUTPUT
BASE_OPTIONS="-i ../ch.dat \
        -x 0.0 -X 1.0 \
        -y 0.0 -Y 1.0 \
        -T 200 \
	-A 0 \
        -t 100" 
MEAN_OPTIONS="$BASE_OPTIONS \
	-s 500000 \
	-W 100 -H 100 \
        -D stddev.txt \
        -m median.txt \
        -g histogram.txt \
        -B best.txt \
        -z -0.5 -Z 2.0 -b 200"
mpirun -PSM2 -n $SLURM_NTASKS -ppn $SLURM_CPUS_ON_NODE $LBIN $BASE_OPTIONS -o like.txt -H hierarchical.txt -K khistory.txt
mpirun -PSM2 -n $SLURM_NTASKS -ppn $SLURM_CPUS_ON_NODE $BIN $MEAN_OPTIONS -o mean.txt
exit
