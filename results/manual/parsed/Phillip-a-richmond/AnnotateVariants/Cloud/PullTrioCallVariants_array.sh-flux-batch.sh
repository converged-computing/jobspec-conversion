#!/bin/bash
#FLUX: --job-name=faux-cupcake-0727
#FLUX: -c=8
#FLUX: --urgency=16

sudo chmod ugo=rwx -R /scratch/
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
Final_Dir=/shared/DeepVariantOutput/
echo "GRCh38 genome"
Genome=GRCh38
Seq_Type=WGS
Fasta_Dir=/shared/AnnotateVariants/Cloud/Genomes/
Fasta_File=GRCh38_full_analysis_set_plus_decoy_hla.fa
BIN_VERSION="1.3.0"
sudo apt -y update
sudo apt-get -y install docker.io
sudo docker pull google/deepvariant:"${BIN_VERSION}"
sudo docker run \
	-v "${CRAM_Dir}":"/cramdir" \
	-v "${Fasta_Dir}":"/genomedir" \
	-v "${Output_Dir}":"/output" \
	google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=${Seq_Type} \
  --ref="/genomedir/$Fasta_File" \
  --intermediate_results_dir="/output/intermediate_results_dir" \
  --reads="/cramdir/$fatherid.cram" \
  --output_vcf="/output/$fatherid.deepvariant.$BIN_VERSION.vcf.gz" \
  --output_gvcf="/output/$fatherid.deepvariant.$BIN_VERSION.gvcf.gz" \
  --num_shards=16 
sudo docker run \
        -v "${CRAM_Dir}":"/cramdir" \
        -v "${Fasta_Dir}":"/genomedir" \
        -v "${Output_Dir}":"/output" \
        google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=${Seq_Type} \
  --ref="/genomedir/$Fasta_File" \
  --intermediate_results_dir="/output/intermediate_results_dir" \
  --reads="/cramdir/$motherid.cram" \
  --output_vcf="/output/$motherid.deepvariant.$BIN_VERSION.vcf.gz" \
  --output_gvcf="/output/$motherid.deepvariant.$BIN_VERSION.gvcf.gz" \
  --num_shards=16    
sudo docker run \
        -v "${CRAM_Dir}":"/cramdir" \
        -v "${Fasta_Dir}":"/genomedir" \
        -v "${Output_Dir}":"/output" \
        google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=${Seq_Type} \
  --ref="/genomedir/$Fasta_File" \
  --intermediate_results_dir="/output/intermediate_results_dir" \
  --reads="/cramdir/$childid.cram" \
  --output_vcf="/output/$childid.deepvariant.$BIN_VERSION.vcf.gz" \
  --output_gvcf="/output/$childid.deepvariant.$BIN_VERSION.gvcf.gz" \
  --num_shards=16
sudo docker pull google/deepvariant:deeptrio-"${BIN_VERSION}"
sudo docker run \
  -v "${CRAM_Dir}":"/cramdir" \
  -v "${Fasta_Dir}":"/genomedir" \
  -v "${Output_Dir}":"/output" \
  google/deepvariant:deeptrio-"${BIN_VERSION}" \
  /opt/deepvariant/bin/deeptrio/run_deeptrio \
  --model_type=WGS \
  --intermediate_results_dir="/output/intermediate_results_dir" \
  --ref="/genomedir/$Fasta_File" \
  --sample_name_child "$childid" \
  --sample_name_parent1 "$fatherid" \
  --sample_name_parent2 "$motherid" \
  --reads_child=/cramdir/$childid.cram \
  --reads_parent1=/cramdir/$fatherid.cram \
  --reads_parent2=/cramdir/$motherid.cram \
  --output_vcf_child /output/$childid.deeptrio.$BIN_VERSION.vcf.gz \
  --output_vcf_parent1 /output/$fatherid.deeptrio.$BIN_VERSION.vcf.gz \
  --output_vcf_parent2 /output/$motherid.deeptrio.$BIN_VERSION.vcf.gz \
  --output_gvcf_child /output/$childid.deeptrio.$BIN_VERSION.gvcf.gz \
  --output_gvcf_parent1 /output/$fatherid.deeptrio.$BIN_VERSION.gvcf.gz \
  --output_gvcf_parent2 /output/$motherid.deeptrio.$BIN_VERSION.gvcf.gz \
  --num_shards 16  
cp $Output_Dir/*vcf.gz $Final_Dir
cp $Output_Dir/*gvcf.gz $Final_Dir
cp $Output_Dir/*tbi $Final_Dir
cp $Output_Dir/*html $Final_Dir
exit
wget -O excord https://github.com/brentp/excord/releases/download/v0.2.2/excord_linux64
chmod +x ./excord
source /shared/miniconda3/etc/profile.d/conda.sh 
conda activate /shared/miniconda3/envs/Mamba/envs/SeqTools
samtools view -@ 8 -b $CRAM_Dir/$Sample_CRAM -o $CRAM_Dir/$Sample_ID.bam
samtools view -b $CRAM_Dir/$Sample_ID.bam |
	./excord \
	--discordantdistance 500 \
	--fasta $Fasta_Dir/$Fasta_File \
	/dev/stdin \
	| LC_ALL=C sort --buffer-size 2G -k1,1 -k2,2n -k3,3n \
	| bgzip -c $Output_Dir/$Sample_ID.bed.gz
cp $Sample_ID.bed.gz $Final_Dir
exit
