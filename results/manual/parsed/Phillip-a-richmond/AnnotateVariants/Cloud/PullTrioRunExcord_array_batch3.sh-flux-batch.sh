#!/bin/bash
#FLUX: --job-name=outstanding-squidward-7951
#FLUX: --urgency=16

AnnotateVariantsDir=/shared/AnnotateVariants/
Final_Dir=/shared/SVOutput/
sudo chmod ugo=rwx -R /shared/SVOutput/
mkdir -p $Final_Dir
ScratchDir=/scratch/
FullRunStart=`date +%s`
currentTime=`date`
echo "Timestamp. Starting analysis: $currentTime"
echo "In seconds: $FullRunStart"
shopt -s nullglob
pedfiles=($AnnotateVariantsDir/Cloud/1kG_Data/*ped)
pedfile=${pedfiles[$SLURM_ARRAY_TASK_ID]}
echo $pedfile
fatherid=$( awk 'NR==2 {print $1}' $pedfile)
motherid=$( awk 'NR==3 {print $1}' $pedfile)
childid=$( awk 'NR==4 {print $1}' $pedfile)
echo $fatherid
echo $motherid
echo $childid
Working_Dir=$ScratchDir/$childid
sudo chmod ugo=rwx -R $ScratchDir
mkdir -p $Working_Dir
cd $Working_Dir
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step2-Start: Downloading data, $currentTime"
echo "In seconds: $Start"
aws s3 cp --dryrun --recursive --no-sign-request s3://1000genomes/data/$fatherid/alignment/ .
aws s3 cp --quiet --recursive --no-sign-request s3://1000genomes/data/$fatherid/alignment/ .
mv $fatherid*cram $fatherid.cram
mv $fatherid*cram.crai $fatherid.cram.crai
aws s3 cp --dryrun --recursive --no-sign-request s3://1000genomes/data/$motherid/alignment/ .
aws s3 cp --quiet --recursive --no-sign-request s3://1000genomes/data/$motherid/alignment/ .
mv $motherid*cram $motherid.cram
mv $motherid*cram.crai $motherid.cram.crai
aws s3 cp --recursive --no-sign-request --dryrun  s3://1000genomes/1000G_2504_high_coverage/additional_698_related/data/ ./ --exclude "*" --include "*$childid*"
aws s3 cp --quiet --recursive --no-sign-request  s3://1000genomes/1000G_2504_high_coverage/additional_698_related/data/ ./ --exclude "*" --include "*$childid*"
mv ./ERR*/$childid*cram $childid.cram
mv ./ERR*/$childid*cram.crai $childid.cram.crai
CRAM_Dir=$Working_Dir
echo "GRCh38 genome"
Genome=GRCh38
Seq_Type=WGS
Fasta_Dir=$AnnotateVariantsDir/Cloud/Genomes/
Fasta_File=GRCh38_full_analysis_set_plus_decoy_hla.fa
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step2-End: Downloading data, $currentTime"
echo "In seconds: $End"
echo "Step2 Runtime: $runtime"
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step3-Start child: Excord,  $currentTime"
echo "In seconds: $Start"
source $AnnotateVariantsDir/Cloud/miniconda3/etc/profile.d/conda.sh
conda activate $AnnotateVariantsDir/Cloud/miniconda3/envs/Mamba/envs/SeqTools
EXCORD=$AnnotateVariantsDir/Cloud/excord
Sample_ID=$childid
Sample_CRAM=$Sample_ID.cram
samtools view -b -u -T $Fasta_Dir/$Fasta_File $CRAM_Dir/$Sample_ID.cram | \
        $EXCORD \
        --discordantdistance 500 \
        --fasta $Fasta_Dir/$Fasta_File \
        /dev/stdin \
        | LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
        | bgzip -c > $CRAM_Dir/$Sample_ID.bed.gz
cp $CRAM_Dir/$Sample_ID.bed.gz $Final_Dir
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step3-End child: Running excord,  $currentTime"
echo "In seconds: $End"
echo "Step3 Runtime: $runtime"
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step3-Start mother: Excord,  $currentTime"
echo "In seconds: $Start"
Sample_ID=$motherid
Sample_CRAM=$Sample_ID.cram
samtools view -b -u -T $Fasta_Dir/$Fasta_File $CRAM_Dir/$Sample_ID.cram | \
        $EXCORD \
        --discordantdistance 500 \
        --fasta $Fasta_Dir/$Fasta_File \
        /dev/stdin \
        | LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
        | bgzip -c > $CRAM_Dir/$Sample_ID.bed.gz
cp $CRAM_Dir/$Sample_ID.bed.gz $Final_Dir
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step3-End mother: Running excord,  $currentTime"
echo "In seconds: $End"
echo "Step3 Runtime: $runtime"
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step3-Start father: Excord,  $currentTime"
echo "In seconds: $Start"
Sample_ID=$fatherid
Sample_CRAM=$Sample_ID.cram
samtools view -b -u -T $Fasta_Dir/$Fasta_File $CRAM_Dir/$Sample_ID.cram | \
        $EXCORD \
        --discordantdistance 500 \
        --fasta $Fasta_Dir/$Fasta_File \
        /dev/stdin \
        | LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
        | bgzip -c > $CRAM_Dir/$Sample_ID.bed.gz
cp $CRAM_Dir/$Sample_ID.bed.gz $Final_Dir
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step3-End father: Running excord,  $currentTime"
echo "In seconds: $End"
echo "Step3 Runtime: $runtime"
FullRunEnd=$End
currentTime=`date`
FullRuntime=$((FullRunEnd-FullRunStart))
echo "Timestamp. Final. $currentTime"
echo "In seconds: $FullRunEnd"
echo "Full Runtime: $FullRuntime"
exit
