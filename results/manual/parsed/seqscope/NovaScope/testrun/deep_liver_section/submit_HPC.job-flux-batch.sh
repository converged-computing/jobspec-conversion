#!/bin/bash
#FLUX: --job-name=full_section_deep
#FLUX: --queue=standard
#FLUX: -t=259200
#FLUX: --urgency=16

smk_dir="/path/to/NovaScope"                                            # [REPLACE] Path to the NovaScope pipeline repo.
job_dir="$smk_dir/testrun/full_section_deep"                            # Path to your Job directory, which should have a config_job.yaml file and will be used to save the log files.
slurm_params="--profile /path/to/the/slurm/configuration/directory"     # [REPLACE] Path to the SLURM parameter directory, which should include a config.yaml file. For example, if your snakemake is version v7.29.0, use `--profile $smk_dir/info/slurm/v7.29.0`
snakemake $slurm_params --latency-wait 120 -s $smk_dir/NovaScope.smk -d $job_dir
