#!/bin/bash
#FLUX: --job-name=bt-$site
#FLUX: -n=12
#FLUX: --queue=shared
#FLUX: -t=21600
#FLUX: --urgency=16

prefix=$1
sites=(BAL MIN SAN NYC SAC DEN)
for site in ${sites[*]}; do
mkdir hmp_all_$site
cd hmp_all_$site
find /data/camda2023/trimmed/ -name "*${site}*" -exec ln -s {} . ';'
cd ../
mkdir bt_mapped_${prefix}_$site
mkdir batches_$site
ls --color=none hmp_all_$site/*1.fastq.gz | split -l 8 -d -a 3 - batches_$site/$site-
hiBatch=$(ls batches_$site/$site-* | tail -1 | sed 's/^.*-0*\([1-9]*\)\(.$\)/\1\2/')
numBatches=$(($hiBatch + 1))
echo 'hiBatch' $hiBatch >> vie ## delete
echo 'numBatches' $numBatches >> vie ## delete
echo "#!/bin/bash
taskNum=\$(printf %03d \$SLURM_ARRAY_TASK_ID)
batch=\"batches_$site/$site-\$taskNum\"
for FQ in \$(cat \$batch); do 
r2=\$(echo \"\$FQ\" | sed 's/_1.fastq.gz/_2.fastq.gz/')
bowtie2 -x $prefix -1 \$FQ -2 \$r2 --no-unal --threads 18 | samtools view -b - | samtools sort -@ 12 - > \$(echo \"\$FQ\" | sed 's/hmp_all_$site/bt_mapped_${prefix}_$site/; s/\_1.fastq.*$/.bam/')
samtools index \$(echo \"\$FQ\" | sed 's/hmp_all_$site/bt_mapped_${prefix}_$site/; s/\_1.fastq.*$/.bam/')
done
" > bt-$site-array.sh #&& bash bt-$site-array.sh && rm bt-$site-array.sh # save this file and submit it then delete for housekeeping
done
