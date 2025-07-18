#!/bin/bash
#FLUX: --job-name=namd
#FLUX: -N=325
#FLUX: -n=325
#FLUX: --queue=normal
#FLUX: -t=72000
#FLUX: --urgency=16

module load namd
TASKS_PER_JOB=55
NODES_PER_JOB=1
BASE_DIR=`pwd`
function schedule_system() {
    local sim_num=$1
    local lambda=$2
	local replica=$3
	# note that this is not required, without it will simply be Base
	local transformation=$4
	local THIS_BASE="$BASE_DIR/$transformation"
	echo "The transformation of this directory is: $THIS_BASE"
	echo "Scheduling ligand and complex for lambda $lambda replica $replica"
	LIG_PATH="lig/lambda_$lambda/rep$replica"
	COMPLEX_PATH="complex/lambda_$lambda/rep$replica"
	# We use timeout to ensure that each NAMD ligand process is terminated in case it gets stuck
    # e.g. 60 seconds * 60 minutes * 4 hours = 4 hours timeout for the ligand
    local LIG_TIMEOUT=$(( 60 * 60 * 6 ))
    # move to the correct ligand directory
    cd $THIS_BASE
    cd $LIG_PATH
    local NUM_CPUS=$(( $NODES_PER_JOB * $TASKS_PER_JOB ))
    local CPU_OFFSET=$(( $sim_num ))
    cmd_namd="ibrun -n 1 -o $CPU_OFFSET namd2 +setcpuaffinity ++ppn $NUM_CPUS +pemap 1-$NUM_CPUS +commap 0 "
	(
	    # first is the ligand part with the timeout
	    ( timeout $LIG_TIMEOUT ${cmd_namd} min.namd > min.log &&
        ${cmd_namd} eq_step1.namd > eq_step1.log &&
        ${cmd_namd} eq_step2.namd > eq_step2.log &&
        ${cmd_namd} eq_step3.namd > eq_step3.log &&
        ${cmd_namd} eq_step4.namd > eq_step4.log &&
        ${cmd_namd} prod.namd > prod.log &&
        echo "Finished ligand: lambda $lambda replica $replica"
        ) ;
        (
        # then the complex part, no timeout
        cd $THIS_BASE && cd $COMPLEX_PATH &&
        ${cmd_namd} min.namd > min.log &&
        ${cmd_namd} eq_step1.namd > eq_step1.log &&
        ${cmd_namd} eq_step2.namd > eq_step2.log &&
        ${cmd_namd} eq_step3.namd > eq_step3.log &&
        ${cmd_namd} eq_step4.namd > eq_step4.log &&
        ${cmd_namd} prod.namd > prod.log &&
        echo "Finished complex: lambda $lambda replica $replica"
        )
    ) &
}
declare -a lambdas=(0.00 0.05 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.00)
declare -a replicas=(1 2 3 4 5)
declare -a transformations=(l1_l8  l1_l9  l3_l5  l4_l10  l5_l6)
counter=0
for base in "${transformations[@]}"; do
    for lambda in "${lambdas[@]}"; do
        for replica in "${replicas[@]}"; do
           schedule_system $counter $lambda $replica $base
           (( counter++ ))
        done
    done
done
wait
