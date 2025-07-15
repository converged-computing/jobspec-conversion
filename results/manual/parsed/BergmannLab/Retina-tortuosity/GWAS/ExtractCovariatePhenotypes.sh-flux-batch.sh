#!/bin/bash
#FLUX: --job-name=ExtractCovariatePhenotypes
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

source $HOME/retina/configs/config.sh
output_dir=$scratch/retina/GWAS/output/ExtractCovariatePhenotypes
output=$output_dir/covars.csv
pheno_file=$data/retina/UKBiob/phenotypes/1_data_extraction/ukb34181.csv # 1st data extraction
phenos_to_extract="3627-0.0,3894-0.0,4012-0.0,4056-0.0,2976-0.0,20161-0.0,22038-0.0,31-0.0,4079-0.0,4080-0.0,1960-0.0,1970-0.0,1980-0.0,21003-0.0"
sample_file=$data/retina/UKBiob/genotypes/ukb43805_imp_chr1_v3_s487297.sample
source /dcsrsoft/spack/bin/setup_dcsrsoft
module purge
module load gcc/8.3.0
module load python/3.7.7
module load py-biopython
python3.7 $PWD/helpers/ExtractCovariatePhenotypes/run.py $output $pheno_file $phenos_to_extract $sample_file
module purge
echo FINISHED: output has been written to: $output_dir
