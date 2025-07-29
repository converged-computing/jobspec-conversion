#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=pn98ve
#SBATCH --output=./%x.%j.out
#SBATCH --error=./%x.%j.err
#SBATCH --mail-user=bieniekmat@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=65
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:30:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=./
#SBATCH --no-requeue

module load slurm_setup
module load namd
TASKS_PER_JOB=48
NODES_PER_JOB=1
LIG_TIMEOUT=$(( 60 * 60 * 4 ))
function schedule_system() {
    echo "system $1"
	echo "Lambda $2"
	echo "Replica $3"
	echo "Scheduling $1 lambda $2 replica $3"
	(
	    timeout -v $LOG_TIMEOUT srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 min.namd > min.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step1.namd > eq_step1.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step2.namd > eq_step2.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step3.namd > eq_step3.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 eq_step4.namd > eq_step4.log &&
        srun -N $NODES_PER_JOB -n $TASKS_PER_JOB namd2 prod.namd > prod.log &&
        echo "Finished protocol for $1 lambda $2 replica $3"
    ) &
}
ROOT_DIR=complex
cd $ROOT_DIR
    for L in lambda*/ ; do
        cd $L
            for R in rep*/ ; do
                cd $R
                    schedule_system $ROOT_DIR $L $R
                cd ..
            done
        cd ..
    done
cd ..
wait
