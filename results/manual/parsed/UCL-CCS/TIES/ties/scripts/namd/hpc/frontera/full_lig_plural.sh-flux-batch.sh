#!/bin/bash
#FLUX: --job-name=rainbow-poodle-6453
#FLUX: --urgency=16

module load namd
TASKS_PER_JOB=55 # 1 reserved for comm
BASE_DIR=`pwd`
function schedule_system() {
    local sim_num=$1
    local lambda=$2
	local replica=$3
	# note that this is not required, without it will simply be Base
	local transformation=$4
	# set up the root working directory
	local THIS_BASE="$BASE_DIR/$transformation"
	echo "The transformation directory: $THIS_BASE"
	echo "Scheduling ligand for lambda $lambda replica $replica"
	local LIG_PATH="lig/lambda_$lambda/rep$replica"
    # move to the correct ligand directory
    cd $THIS_BASE
    cd $LIG_PATH
    local CPU_OFFSET=$(( $sim_num ))
    cmd_namd="ibrun -n 1 -o $CPU_OFFSET namd2 +setcpuaffinity ++ppn $TASKS_PER_JOB +pemap 1-$TASKS_PER_JOB +commap 0 "
	(
	    # first is the ligand part with the timeout
	    ${cmd_namd} min.namd > min.log &&
        ${cmd_namd} eq_step1.namd > eq_step1.log &&
        ${cmd_namd} eq_step2.namd > eq_step2.log &&
        ${cmd_namd} eq_step3.namd > eq_step3.log &&
        ${cmd_namd} eq_step4.namd > eq_step4.log &&
        ${cmd_namd} prod.namd > prod.log &&
        echo "Finished ligand: lambda $lambda replica $replica"
    ) &
}
declare -a lambdas=(0.00 0.05 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.00)
declare -a replicas=(1)
declare -a transformations=(l6_l41)
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
