#!/bin/bash
#SBATCH --job-name=full_section_deep
#SBATCH --account=leeju0
#SBATCH --output=./logs/lda-%j_%x.out
#SBATCH --mail-user=weiqiuc@umich.edu
#SBATCH --mail-type=END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000m
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1

smk_dir="/path/to/NovaScope"                                            # [REPLACE] Path to the NovaScope pipeline repo.
job_dir="$smk_dir/testrun/full_section_deep"                            # Path to your Job directory, which should have a config_job.yaml file and will be used to save the log files.
slurm_params="--profile /path/to/the/slurm/configuration/directory"     # [REPLACE] Path to the SLURM parameter directory, which should include a config.yaml file. For example, if your snakemake is version v7.29.0, use `--profile $smk_dir/info/slurm/v7.29.0`
snakemake $slurm_params --latency-wait 120 -s $smk_dir/NovaScope.smk -d $job_dir
