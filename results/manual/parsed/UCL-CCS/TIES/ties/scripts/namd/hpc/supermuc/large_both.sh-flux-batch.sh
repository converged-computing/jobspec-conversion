#!/bin/bash
#FLUX: --job-name="TIESnamd"
#FLUX: -N=65
#FLUX: --queue=general # test, micro, general, large or fat
#FLUX: -t=81000
#FLUX: --priority=16

module load slurm_setup
module load namd
TASKS_PER_JOB=48
NODES_PER_JOB=1
BASE_DIR=`pwd`
function schedule_system() {
    local lambda=$1
	local replica=$2
	echo "Scheduling ligand and complex for lambda $lambda replica $replica"
	LIG_PATH="lig/lambda_$lambda/rep$replica"
	COMPLEX_PATH="complex/lambda_$lambda/rep$replica"
	# We use timeout to ensure that each NAMD ligand process is terminated in case it gets stuck
    # e.g. 60 seconds * 60 minutes * 4 hours = 4 hours timeout for the ligand
    local LIG_TIMEOUT=$(( 60 * 60 * 6 ))
    # move to the correct ligand directory
    cd $BASE_DIR
    cd $LIG_PATH
	(
	    # first is the ligand part with the timeout
	    ( timeout $LIG_TIMEOUT srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 min.namd > min.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step1.namd > eq_step1.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step2.namd > eq_step2.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step3.namd > eq_step3.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step4.namd > eq_step4.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 prod.namd > prod.log &&
        echo "Finished ligand: lambda $lambda replica $replica"
        ) ;
        (
        # then the complex part, no timeout
        cd $BASE_DIR && cd $COMPLEX_PATH &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 min.namd > min.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step1.namd > eq_step1.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step2.namd > eq_step2.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step3.namd > eq_step3.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step4.namd > eq_step4.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 prod.namd > prod.log &&
        echo "Finished complex: lambda $lambda replica $replica"
        )
    ) &
}
declare -a lambdas=(0.00 0.05 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.00)
declare -a replicas=(1 2 3 4 5)
for lambda in "${lambdas[@]}"; do
    for replica in "${replicas[@]}"; do
       schedule_system $lambda $replica
    done
done
wait
