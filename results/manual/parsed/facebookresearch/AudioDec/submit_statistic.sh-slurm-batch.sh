#!/bin/bash
#SBATCH --job-name=extraction
#SBATCH --output=/mnt/home/slurmlogs/vctk/extraction/symAD_vctk.out
#SBATCH --error=/mnt/home/slurmlogs/vctk/extraction/symAD_vctk.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=124g
#SBATCH --time=1-00:00:00

tag_name=statistic/symAD_vctk_48000_hop300_clean
subset=train
subset_num=-1
. ./parse_options.sh || exit 1;
config_name="config/${tag_name}.yaml"
echo "Configuration file="$config_name
python codecStatistic.py -c ${config_name} --subset ${subset} --subset_num ${subset_num}
