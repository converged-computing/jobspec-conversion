#!/bin/bash
#FLUX: --job-name=lovable-toaster-8299
#FLUX: --queue=nextflow
#FLUX: --priority=16

echo $1
echo $2
echo $3
echo $4
echo $5
echo $6
echo $7
cd $1
if [ ! -d "data" ]; then
	mkdir data
fi
ln -s $3 ${1}/data/${6}_1.fastq.gz
ln -s $4 ${1}/data/${6}_2.fastq.gz
printf "\nincludeConfig 'platform.config'" >> nextflow.config
srun nextflow run $2 -profile $5 -resume > nextflow_log.txt 2>&1
