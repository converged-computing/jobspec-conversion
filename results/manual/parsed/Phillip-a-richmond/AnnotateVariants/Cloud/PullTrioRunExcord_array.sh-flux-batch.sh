#!/bin/bash
#FLUX: --job-name=adorable-carrot-1826
#FLUX: -c=32
#FLUX: --priority=16

FullRunStart=`date +%s`
echo "Timestamp. Starting analysis: $date"
echo "In seconds: $FullRunStart"
SLURM_ARRAY_TASK_ID=2
shopt -s nullglob
pedfiles=(/mnt/common/WASSERMAN_SOFTWARE/AnnotateVariants/Cloud/1kG_Data/*ped)
pedfile=${pedfiles[$SLURM_ARRAY_TASK_ID]}
echo $pedfile
fatherid=$( awk 'NR==2 {print $1}' $pedfile)
motherid=$( awk 'NR==3 {print $1}' $pedfile)
childid=$( awk 'NR==4 {print $1}' $pedfile)
echo $fatherid
echo $motherid
echo $childid
Working_Dir=/mnt/scratch/Public/RICHMOND/SV/$childid
mkdir -p $Working_Dir
cd $Working_Dir
Final_Dir=/mnt/scratch/Public/RICHMOND/SV/Output/
mkdir -p $Final_Dir
Start=`date +%s`
echo "Timestamp. Step2-Start: Downloading data, $date"
echo "In seconds: $Start"
aws s3 cp --dryrun --recursive --no-sign-request s3://1000genomes/data/$fatherid/alignment/ .
aws s3 cp --recursive --no-sign-request s3://1000genomes/data/$fatherid/alignment/ .
mv $fatherid*cram $fatherid.cram
mv $fatherid*cram.crai $fatherid.cram.crai
aws s3 cp --dryrun --recursive --no-sign-request s3://1000genomes/data/$motherid/alignment/ .
aws s3 cp --recursive --no-sign-request s3://1000genomes/data/$motherid/alignment/ .
mv $motherid*cram $motherid.cram
mv $motherid*cram.crai $motherid.cram.crai
aws s3 cp --recursive --no-sign-request --dryrun  s3://1000genomes/1000G_2504_high_coverage/additional_698_related/data/ ./ --exclude "*" --include "*$childid*"
aws s3 cp --recursive --no-sign-request  s3://1000genomes/1000G_2504_high_coverage/additional_698_related/data/ ./ --exclude "*" --include "*$childid*"
mv ./ERR*/$childid*cram $childid.cram
mv ./ERR*/$childid*cram.crai $childid.cram.crai
CRAM_Dir=$Working_Dir
Output_Dir=$Working_Dir/Variants/
mkdir -p $Output_Dir
echo "GRCh38 genome"
Genome=GRCh38
Seq_Type=WGS
Fasta_Dir=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/1000G/
Fasta_File=GRCh38_full_analysis_set_plus_decoy_hla.fa
End=`date +%s`
runtime=$((End-Start))
echo "Timestamp. Step2-End: Downloading data, $date"
echo "In seconds: $End"
echo "Step2 Runtime: $runtime"
Start=`date +%s`
echo "Timestamp. Step5-Start: Excord,  $date"
echo "In seconds: $Start"
source /shared/AnnotateVariants/Cloud/miniconda3/etc/profile.d/conda.sh
conda activate /shared/AnnotateVariants/Cloud/miniconda3/envs/Mamba/envs/SeqTools
Sample_ID=$childid
Sample_CRAM=$Sample_ID.cram
samtools view -b $CRAM_Dir/$Sample_ID.cram | \
        /mnt/common/Precision/Excord/excord \
        --discordantdistance 500 \
        --fasta $Fasta_Dir/$Fasta_File \
        /dev/stdin \
        | LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
        | bgzip -c > $CRAM_Dir/$Sample_ID.bed.gz
cp $Sample_ID.bed.gz $Final_Dir
End=`date +%s`
runtime=$((End-Start))
echo "Timestamp. Step5-End: Running smoove,  $date"
echo "In seconds: $End"
echo "Step5 Runtime: $runtime"
FullRunEnd=$End
FullRuntime=$((FullRunEnd-FullRunStart))
echo "Timestamp. Final. $date"
echo "In seconds: $FullRunEnd"
echo "Full Runtime: $FullRuntime"
exit
