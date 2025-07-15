#!/bin/bash
#FLUX: --job-name=scruptious-bike-2924
#FLUX: --urgency=16

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
