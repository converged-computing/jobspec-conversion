#!/bin/bash
#FLUX: --job-name=loopy-general-8194
#FLUX: --urgency=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
user="robertsj"
runner_dir="/home/$user/NASLib/naslib/runners/bbo"
for config_file_seed in $1/*
    do
        echo submitted ${config_file_seed}
        python -u $runner_dir/runner.py --config-file $config_file_seed
        # python -u -m debugpy --listen 0.0.0.0:$PORT --wait-for-client $runner_dir/runner.py --config-file $config_file_seed
    done
echo "DONE";
echo "Finished at $(date)"; 
