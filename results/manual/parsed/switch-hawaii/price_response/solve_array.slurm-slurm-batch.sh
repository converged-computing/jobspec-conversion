#!/bin/bash
#SBATCH --job-name=demand_scenarios
#SBATCH --output=logs/%A_%a.out
#SBATCH --error=logs/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6400
#SBATCH --time=3-00:00:00
#SBATCH --array=1-40

scen_name=$(awk -v line="${SLURM_ARRAY_TASK_ID}" -v field="2" 'NR==line{print $field}' scenarios_2018_04_29_theta01.txt)
echo "Solving scenario $scen_name."
module load lang/Python/2.7.10/python
srun --unbuffered --time=3-00:00:00 --partition=community.q switch solve-scenarios --scenario $scen_name --scenario-queue sq/sq_$SLURM_ARRAY_JOB_ID "$@" --tempdir ./tmp
