#!/bin/bash
#FLUX: --job-name=nerdy-rabbit-9956
#FLUX: -n=8
#FLUX: --queue=park
#FLUX: -t=720
#FLUX: --urgency=16

module load gcc  conda2/4.2.13 bedtools gatk python/3.7.4 R/4.0.1
module load perl/5.30.0
module load samtools
filepath=$1
stem=$2
echo $filepath
echo $stem
mkdir readpos/$stem/
mkdir temp/$stem/
mkdir bins/$stem/
config=cfg/$stem.cfg
temp=temp/$stem.tmp
echo "start of get_readpos"
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X; do
    echo $i
    samtools view -q 30  -F 1284 $filepath $i | perl -ane 'print $F[3], "\n";' > readpos/$stem/${i}.readpos.seq &
done
wait
echo "end of get_readpos"
echo "start of bicseq-norm"
/n/data1/hms/dbmi/park/yifan/tools/NBICseq-norm_v0.2.4/NBICseq-norm.pl  -b=500000  --gc_bin  -p=0.0002   $config $temp
echo "end of bicseq-norm"
