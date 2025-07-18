#!/bin/bash
#FLUX: --job-name=gassy-malarkey-3710
#FLUX: -n=64
#FLUX: --queue=amd_256
#FLUX: --urgency=16

b=$SAMPLE
wd=${READ_DIR}
db=${TARGET_DIR} ;
b_n=$(basename $b .fastq)
t_n=${TARGET_NAME}
mkdir -p results_ublast_${t_n}
mkdir -p temp_ublast_${t_n}
/public4/home/sc53141/software/usearch/usearch -ublast ./${b} -db $db/${t_n}.fa -evalue 1e-10 -accel 0.8 -strand both -threads 64 -query_cov 0.7 -maxaccepts 1 -blast6out temp_ublast_${t_n}/${b_n}_${t_n}_ublast_out
cut -f2,4 temp_ublast_${t_n}/${b_n}_${t_n}_ublast_out | awk -F ' ' '{s[$1]+=$2} END{for(i in s) print(i,s[i])}' OFS='\t' | sort -k1,1 > temp_ublast_${t_n}/summed_alignment_length_${b_n}_${t_n}
join -o 1.1,1.2,2.2 temp_ublast_${t_n}/summed_alignment_length_${b_n}_${t_n} $db/${t_n}_length_sort | awk -F ' ' '{$4=$2/$3; print $0}' OFS='\t' | sed "1i ${t_n}\tsummed_alignment_length\tgene_length\t${b_n}_coverage" > temp_ublast_${t_n}/coverage_${b_n}_${t_n}
cut -f4 temp_ublast_${t_n}/coverage_${b_n}_${t_n} > results_ublast_${t_n}/4_coverage_${b_n}_${t_n}
