#!/bin/bash
#FLUX: --job-name=trim-velvet
#FLUX: -c=16
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --priority=16

echo "SLURM_NODELIST: "$SLURM_NODELIST
username=$1
dir=$2
readsprefix=$3
mkdir $readsprefix
cp $dir/$readsprefix*_1*f*q* $readsprefix/
cp $dir/$readsprefix*_2*f*q* $readsprefix/
cd $readsprefix
if [ $4 == 'yes' ]
then
  singularity run --app trimmomatic039 /share/singularity/images/ccs/conda/amd-conda2-centos8.sinf trimmomatic PE \
  -threads 16 -phred33 -trimlog ${readsprefix}_errorlog.txt \
  $readsprefix*_1*.f*q* $readsprefix*_2*.f*q* \
  ${readsprefix}_R1_paired.fq ${readsprefix}_R1_unpaired.fq \
  ${readsprefix}_R2_paired.fq ${readsprefix}_R2_unpaired.fq \
  ILLUMINACLIP:/project/vaillan_uksr/adapters/NexteraPE-PE.fa:2:30:10 SLIDINGWINDOW:20:20 MINLEN:90;
fi
module load python-2.7.18-gcc-9.3.0-5efgwu4
python /project/vaillan_uksr/bash_scripts/interleave-fastq.py *1_paired.fq *2_paired.fq > interleaved.fq
module unload python-2.7.18-gcc-9.3.0-5efgwu4
singularity run --app perlvelvetoptimiser226 /share/singularity/images/ccs/conda/amd-conda2-centos8.sinf VelvetOptimiser.pl \
 -s $5 -e $6 -x 10 -d velvet_assembly -f ' -shortPaired -interleaved -fastq interleaved.fq'
mv velvet_assembly/contigs.fa velvet_assembly/${readsprefix}".fasta"
mkdir /scratch/$username/ASSEMBLIES
cp velvet_assembly/${readsprefix}".fasta" /scratch/$username/ASSEMBLIES/${readsprefix}".fasta"
prefix=`ls velvet_assembly/*logfile.txt'
mv $prefix /scratch/$username/ASSEMBLIES/${readsprefix}_${prefix/*\//}
