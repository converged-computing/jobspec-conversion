#!/bin/bash
#SBATCH --job-name=bbo-exps
#SBATCH --output=slurmlog/%A.%N.out
#SBATCH --error=slurmlog/%A.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=00:07:00

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
for config_file_seed in $1/*
	do
		echo submitted ${config_file_seed}
		python -u runner.py --config-file $config_file_seed
	done
echo "DONE";
echo "Finished at $(date)";
