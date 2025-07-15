#!/bin/bash
#FLUX: --job-name=boopy-dog-7439
#FLUX: -c=32
#FLUX: --priority=16

sudo chmod ugo=rwx -R /scratch/
sudo chmod ugo=rwx -R /shared/
FullRunStart=`date +%s`
currentTime=`date`
echo "Timestamp. Starting analysis: $currentTime"
echo "In seconds: $FullRunStart"
shopt -s nullglob
pedfiles=(/shared/AnnotateVariants/Cloud/1kG_Data/*ped)
pedfile=${pedfiles[$SLURM_ARRAY_TASK_ID]}
echo $pedfile
fatherid=$( awk 'NR==2 {print $1}' $pedfile)
motherid=$( awk 'NR==3 {print $1}' $pedfile)
childid=$( awk 'NR==4 {print $1}' $pedfile)
echo $fatherid
echo $motherid
echo $childid
Working_Dir=/scratch/$childid
mkdir -p $Working_Dir
cd $Working_Dir
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step2-Start: Downloading data, $currentTime"
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
Final_Dir=/shared/SVOutput/
mkdir -p $Final_Dir
echo "GRCh38 genome"
Genome=GRCh38
Seq_Type=WGS
Fasta_Dir=/shared/AnnotateVariants/Cloud/Genomes/
Fasta_File=GRCh38_full_analysis_set_plus_decoy_hla.fa
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step2-End: Downloading data, $currentTime"
echo "In seconds: $End"
echo "Step2 Runtime: $runtime"
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step3-Start: Running Manta, $currentTime"
echo "In seconds: $Start"
source /shared/AnnotateVariants/Cloud/miniconda3/etc/profile.d/conda.sh
conda activate /shared/AnnotateVariants/Cloud/miniconda3/envs/Mamba/envs/SeqTools
configManta.py \
        --referenceFasta=$Fasta_Dir/$Fasta_File \
        --runDir=$Working_Dir \
        --bam $CRAM_Dir/$childid.cram \
        --bam $CRAM_Dir/$motherid.cram \
        --bam $CRAM_Dir/$fatherid.cram
cd $Working_Dir
./runWorkflow.py \
        -j 64 \
        -g 128
cp $Working_Dir/results/variants/diploidSV.vcf.gz $Final_Dir/${childid}_Manta_diploidSV.vcf.gz
cp $Working_Dir/results/variants/diploidSV.vcf.gz.tbi $Final_Dir/${childid}_Manta_diploidSV.vcf.gz.tbi
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step3-End: Running Manta,  $currentTime"
echo "In seconds: $End"
echo "Step3 Runtime: $runtime"
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step4-Start: Running smoove, $currentTime"
echo "In seconds: $Start"
sudo apt -y update
sudo apt-get -y install docker.io
sudo docker pull brentp/smoove
cp /shared/AnnotateVariants/Cloud/smoove.sh $Working_Dir
sudo docker run \
        -v "${CRAM_Dir}":"/cramdir" \
        -v "${Fasta_Dir}":"/genomedir" \
        -v "${Working_Dir}":"/output" \
        brentp/smoove \
        bash /cramdir/smoove.sh 64 $childid $Fasta_File 
cp $Working_Dir/results-smoove/${childid}-smoove.genotyped.vcf.gz* $Final_Dir
End=`date +%s`
currentTime=`date`
runtime=$((End-Start))
echo "Timestamp. Step4-End: Running smoove,  $currentTime"
echo "In seconds: $End"
echo "Step4 Runtime: $runtime"
FullRunEnd=$End
currentTime=`date`
FullRuntime=$((FullRunEnd-FullRunStart))
echo "Timestamp. Final. $currentTime"
echo "In seconds: $FullRunEnd"
echo "Full Runtime: $FullRuntime"
exit
Start=`date +%s`
currentTime=`date`
echo "Timestamp. Step5-Start: Excord,  $currentTime"
echo "In seconds: $Start"
wget -c -q -O excord https://github.com/brentp/excord/releases/download/v0.2.2/excord_linux64
chmod +x ./excord
source /shared/AnnotateVariants/Cloud/miniconda3/etc/profile.d/conda.sh
conda activate /shared/AnnotateVariants/Cloud/miniconda3/envs/Mamba/envs/SeqTools
Sample_ID=$childid
Sample_CRAM=$Sample_ID.cram
samtools view -@ 64 \
       	-b $CRAM_Dir/$Sample_CRAM \
	-T $Fasta_Dir/$Fasta_File \
	-o $CRAM_Dir/$Sample_ID.bam
samtools index -@ 64 $CRAM_Dir/$Sample_ID.bam
samtools view -b $CRAM_Dir/$Sample_ID.bam | \
        $CRAM_Dir/excord \
        --discordantdistance 500 \
        --fasta $Fasta_Dir/$Fasta_File \
        /dev/stdin \
        | LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
        | bgzip -c $CRAM_Dir/$Sample_ID.bed.gz
cp $Sample_ID.bed.gz $Final_Dir
End=`date +%s`
runtime=$((End-Start))
currentTime=`date`
echo "Timestamp. Step5-End: Running smoove,  $currentTime"
echo "In seconds: $End"
echo "Step5 Runtime: $runtime"
exit
