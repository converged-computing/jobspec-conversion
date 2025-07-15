#!/bin/bash
#FLUX: --job-name=carnivorous-punk-7229
#FLUX: -t=1800
#FLUX: --urgency=16

module load Java/1.8.0_121
module load GATK
module load SAMtools
usage()
{
echo "# A script to filter somatic variants called by gatk Mutect2, designed for the Phoenix supercomputer
"
}
InDir=/fast/users/a1742674/outputs/SomaticVcalling/Mutect2_2
vcfDir=$InDir/vcf
OutDir=$InDir/strictstrandbias
tmpDir=$InDir/tempdir
if [ -z $vcfDir ]; then # If no vcfDir name specified then do not proceed
        usage
        echo "#ERROR: You need to tell me where to find the vcf files."
        exit 1
fi
if [ ! -d $OutDir ]; then
        mkdir -p $OutDir
fi
if [ ! -d $tmpDir ]; then
        mkdir -p $tmpDir
fi
cd $vcfDir
QUERIES=($(ls *.vcf))
cd $vcfDir
gatk FilterMutectCalls \
-V $vcfDir/${QUERIES[$SLURM_ARRAY_TASK_ID]} \
--max-germline-posterior 0.1 \
--max-strand-artifact-probability 1.00 \
-O $OutDir/${QUERIES[$SLURM_ARRAY_TASK_ID]}.filtered.vcf >> $tmpDir/${QUERIES[$SLURM_ARRAY_TASK_ID]}.filter.pipeline.log 2>&1
module load BCFtools
bcftools view -O v -f PASS -i 'FORMAT/AF[0:0] < 0.4' $OutDir/${QUERIES[$SLURM_ARRAY_TASK_ID]}.filtered.vcf > $OutDir/${QUERIES[$SLURM_ARRAY_TASK_ID]}_PASS.vcf
