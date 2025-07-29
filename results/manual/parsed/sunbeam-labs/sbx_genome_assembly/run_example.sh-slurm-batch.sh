#!/bin/bash
#SBATCH --output=slurm_%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=10-00:00:00
#SBATCH --no-requeue

export SUNBEAM_DIR='/home/tuv/sunbeam/sunbeam-stable'
export TMPDIR='/prj/dir/tmp'

source ~/.bashrc.conda #needed to make "conda" command to work
conda activate sunbeam #needed for sunbeam
module load BioPerl
unset LD_LIBRARY_PATH #sunbeam / snakemake clears this path when it launched due to secrutiy issues
export SUNBEAM_DIR="/home/tuv/sunbeam/sunbeam-stable"
export TMPDIR="/prj/dir/tmp"
set -x
set -e
sunbeam run --configfile ./sunbeam_config.yml --use-conda all_WGS -j 50 -w90 -k --keep-going --ignore-incomplete --cluster-config ./cluster.json --notemp -p --nolock --verbose -c 'sbatch --no-requeue --export=ALL --mem={cluster.memcpu} -n {threads} -t 10-0 -J {cluster.name} --output=slurm_%x_%j.out'
