#!/bin/bash
#FLUX: --job-name=psycho-chip-7969
#FLUX: -c=18
#FLUX: --queue=bigmem
#FLUX: --urgency=16

PATH=/home/users/jbadura/udocker:$PATH
/usr/bin/time -v -o times/ara_racer.1.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/data/ARA:/data \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga preprocess --pe-mode 1 \
  -o /res/tmp.fastq \
  /data/ara_racer_1.fastq \
  /data/ara_racer_2.fastq
/usr/bin/time -v -o times/ara_racer.2.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga index \
  -a ropebwt -t 16 --no-reverse \
  -p /res/tmp \
  /res/tmp.fastq
/usr/bin/time -v -o times/ara_racer.3.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga correct -k 41 --discard --learn -t 16 \
  -o /res/reads.ec.k41.fastq \
  -p /res/tmp \
  /res/tmp.fastq
/usr/bin/time -v -o times/ara_racer.4.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga index \
  -a ropebwt -t 16 \
  -p /res/reads.ec.k41 \
  /res/reads.ec.k41.fastq
/usr/bin/time -v -o times/ara_racer.5.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga filter \
  -x 2 -t 16 \
  --homopolymer-check \
  --low-complexity-check \
  -p /res/reads.ec.k41 \
  -o /res/reads.ec.k41.fastq.filter.pass.fa \
  /res/reads.ec.k41.fastq
/usr/bin/time -v -o times/ara_racer.6.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga fm-merge -m 55 -t 16 \
  -o /res/merged.k41.fa \
  -p /res/reads.ec.k41.fastq.filter.pass \
  /res/reads.ec.k41.fastq.filter.pass.fa
/usr/bin/time -v -o times/ara_racer.7.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga index \
  -d 1000000 -t 16 \
  -p /res/merged.k41 \
  /res/merged.k41.fa
/usr/bin/time -v -o times/ara_racer.8.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga rmdup \
  -t 16 \
  -p /res/merged.k41 \
  -o /res/merged.k41.fa.rmdup.fa \
  /res/merged.k41.fa
/usr/bin/time -v -o times/ara_racer.9.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 -w /res \
 sga overlap \
  -m 55 \
  -t 16 -v \
  -p /res/merged.k41.fa.rmdup \
  /res/merged.k41.fa.rmdup.fa
/usr/bin/time -v -o times/ara_racer.10.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/ara_racer:/res \
 sga assemble \
  -m 75 -g 0 -r 10 \
  -o /res/assemble.m75 \
  /res/merged.k41.fa.rmdup.asqg.gz
