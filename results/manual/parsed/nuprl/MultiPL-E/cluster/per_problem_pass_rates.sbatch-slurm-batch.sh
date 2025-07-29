#!/bin/bash
#FLUX: --job-name=per_problem_pass_rates
#FLUX: -n=100
#FLUX: -c=2
#FLUX: --queue=express
#FLUX: -t=600
#FLUX: --urgency=16

module load gnu-parallel
PARALLEL_TASKS=$(($SLURM_NTASKS - 1))
PARALLEL="parallel -j $PARALLEL_TASKS"
SRUN="srun -N1 -n1"
OUT_FILE=$1
shift
echo "BaseDataset,ProblemName,Model,Language,Temperature,NumPassed,NumCompletions" > $OUT_FILE
$PARALLEL "$SRUN python3 ../per_problem_pass_rates.py --suppress-header" ::: $@ >> $OUT_FILE
