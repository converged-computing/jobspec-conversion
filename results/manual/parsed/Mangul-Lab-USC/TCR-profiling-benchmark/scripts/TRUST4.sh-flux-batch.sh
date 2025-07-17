#!/bin/bash
#FLUX: --job-name=TRUST4.job
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

export LC_CTYPE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

module purge
module load gcc/9.2.0
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
cd samples 
ls *.bam | awk -F ".bam" '{print $1}' >sample_id.txt
mv sample_id.txt /project/mangul_341/keruipen/tools/TRUST4
cd ..
filename='sample_id.txt'
n=1 
while read sample_id
do
echo $sample_id
/project/mangul_341/keruipen/tools/TRUST4/run-trust4 -b samples/${sample_id}.bam -f hg38_bcrtcr.fa --ref human_IMGT+C.fa
done<sample_id.txt
