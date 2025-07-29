#!/bin/bash
#SBATCH --job-name=per_problem_pass_rates
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:00
#SBATCH --partition=express

module load gnu-parallel
PARALLEL_TASKS=$(($SLURM_NTASKS - 1))
PARALLEL="parallel -j $PARALLEL_TASKS"
SRUN="srun -N1 -n1"
OUT_FILE=$1
shift
echo "BaseDataset,ProblemName,Model,Language,Temperature,NumPassed,NumCompletions" > $OUT_FILE
$PARALLEL "$SRUN python3 ../per_problem_pass_rates.py --suppress-header" ::: $@ >> $OUT_FILE
