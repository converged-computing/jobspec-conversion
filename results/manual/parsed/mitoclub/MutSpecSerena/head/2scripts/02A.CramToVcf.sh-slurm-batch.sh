#!/bin/bash
#SBATCH --job-name=Cram2Vcf
#SBATCH --output=CramToVcf.%J.out
#SBATCH --error=CramToVcf.%J.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10gb
#SBATCH --time=2-02:00:00
#SBATCH --constraint=ntasks-per-node=1

export PATH='$PATH:/work/gr-fe/kostya/Serena/body/bcftools-1.9 # export bcftools'

module load gcc/7.4.0
module load samtools/1.9
OutputDir=/work/gr-fe/kostya/Serena/body/2derived/MtCramMpileupVcf
CramDir=/work/gr-fe/kostya/Serena/body/1raw/Crams2439
export PATH=$PATH:/work/gr-fe/kostya/Serena/body/bcftools-1.9 # export bcftools
RefSeq=/work/gr-fe/kostya/Serena/body/1raw/Hg19MtDna/hs37d5.fa
myfilenames=`ls $CramDir/*/*.cram`  #extansion is  .bam but do not contain 'samtools.' as in /work/gr-fe/archive/sample_repository/BroadNeut/BAMS/Columbia/samtools.586.5433.tmp.0000.bam
for eachfile in $myfilenames
 do
  NameOfFile=$(echo $eachfile | awk '{gsub(/.*\//, "", $0)} 1')  # This should set NameOfFile to the output of awk (filename without the path).
  samtools index $eachfile # .cram.crai files are created in each folder
  samtools idxstats $eachfile  > $OutputDir/$NameOfFile.idxstats
  samtools flagstat $eachfile  > $OutputDir/$NameOfFile.flagstat
  samtools view -M -f 0x40 -F 0x4 $eachfile MT -o $OutputDir/$NameOfFile.MT1.cram
  samtools view -M -f 0x80 -F 0x4 $eachfile MT -o $OutputDir/$NameOfFile.MT2.cram
  samtools view -M -F 0x4 $eachfile MT -o $OutputDir/$NameOfFile.MT.cram
  samtools mpileup -f $RefSeq $OutputDir/$NameOfFile.MT1.cram -o $OutputDir/$NameOfFile.MT1.cram.mpileup
  samtools mpileup -f $RefSeq $OutputDir/$NameOfFile.MT2.cram -o $OutputDir/$NameOfFile.MT2.cram.mpileup
  samtools mpileup -f $RefSeq $OutputDir/$NameOfFile.MT.cram -o $OutputDir/$NameOfFile.MT.cram.mpileup
  bcftools mpileup -f $RefSeq $OutputDir/$NameOfFile.MT.cram | bcftools view -o $OutputDir/$NameOfFile.MT.cram.vcf
done
