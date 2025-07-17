#!/bin/bash
#FLUX: --job-name=demultiplexGraphs
#FLUX: --queue=long
#FLUX: -t=345600
#FLUX: --urgency=16

module purge
ml easybuild intel/2017a Python/3.6.1
fType1=read
fType2=index
file1=/projects/bgmp/shared/2017_sequencing/1294_S1_L008_R1_001.fastq.gz
name1=R1
file2=/projects/bgmp/shared/2017_sequencing/1294_S1_L008_R2_001.fastq.gz
name2=R2
file3=/projects/bgmp/shared/2017_sequencing/1294_S1_L008_R3_001.fastq.gz
name3=R3
file4=/projects/bgmp/shared/2017_sequencing/1294_S1_L008_R4_001.fastq.gz
name4=R4
python3 ./../python/demultiplex.py -f $file1 -t $fType1 -n $name1
python3 ./../python/demultiplex.py -f $file2 -t $fType2 -n $name2
python3 ./../python/demultiplex.py -f $file3 -t $fType2 -n $name3
python3 ./../python/demultiplex.py -f $file4 -t $fType1 -n $name4
