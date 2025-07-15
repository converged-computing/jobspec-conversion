#!/bin/bash
#FLUX: --job-name=VesselStatsToPhenofile_vein
#FLUX: --queue=normal
#FLUX: -t=21600
#FLUX: --urgency=16

source $HOME/retina/configs/config.sh
output_dir=$scratch/retina/GWAS/output/VesselStatsToPhenofile/
output=$output_dir/phenofile_vein00.csv
sample_file=$data/retina/UKBiob/genotypes/ukb43805_imp_chr1_v3_s487297.sample
stats_dir=$scratch/retina/preprocessing/output/backup/2020_09_14__10_52_32_lwnet00_vein/
echo "Producing phenofile for vessel statistics for run: ${stats_dir: -22}"
source /dcsrsoft/spack/bin/setup_dcsrsoft
module purge
module load gcc/8.3.0
module load python/3.7.7
module load py-biopython
python3.7 $PWD/helpers/VesselStatsToPhenofile/run.py $output $sample_file $stats_dir
module purge
qq_input=$output
qq_output=$output_dir/phenofile_qqnorm.csv
source /dcsrsoft/spack/bin/setup_dcsrsoft
module purge
module load gcc/8.3.0
module load r/3.6.3
Rscript $PWD/helpers/utils/QQnorm/QQnormMatrix.R $qq_input $qq_output
module purge
echo FINISHED: output has been written to $output_dir
