#!/bin/bash
#FLUX: --job-name=moolicious-hippo-5330
#FLUX: -c=18
#FLUX: --queue=bigmem
#FLUX: --urgency=16

PATH=/home/users/jbadura/udocker:$PATH
/usr/bin/time -v -o times/cel_musket.1.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/data/CEL:/data \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga preprocess --pe-mode 1 \
  -o /res/tmp.fastq \
  /data/cel_musket_1.fastq \
  /data/cel_musket_2.fastq
/usr/bin/time -v -o times/cel_musket.2.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga index \
  -a ropebwt -t 16 --no-reverse \
  -p /res/tmp \
  /res/tmp.fastq
/usr/bin/time -v -o times/cel_musket.3.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga correct -k 41 --discard --learn -t 16 \
  -o /res/reads.ec.k41.fastq \
  -p /res/tmp \
  /res/tmp.fastq
/usr/bin/time -v -o times/cel_musket.4.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga index \
  -a ropebwt -t 16 \
  -p /res/reads.ec.k41 \
  /res/reads.ec.k41.fastq
/usr/bin/time -v -o times/cel_musket.5.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga filter \
  -x 2 -t 16 \
  --homopolymer-check \
  --low-complexity-check \
  -p /res/reads.ec.k41 \
  -o /res/reads.ec.k41.fastq.filter.pass.fa \
  /res/reads.ec.k41.fastq
/usr/bin/time -v -o times/cel_musket.6.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga fm-merge -m 55 -t 16 \
  -o /res/merged.k41.fa \
  -p /res/reads.ec.k41.fastq.filter.pass \
  /res/reads.ec.k41.fastq.filter.pass.fa
/usr/bin/time -v -o times/cel_musket.7.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga index \
  -d 1000000 -t 16 \
  -p /res/merged.k41 \
  /res/merged.k41.fa
/usr/bin/time -v -o times/cel_musket.8.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga rmdup \
  -t 16 \
  -p /res/merged.k41 \
  -o /res/merged.k41.fa.rmdup.fa \
  /res/merged.k41.fa
/usr/bin/time -v -o times/cel_musket.9.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 -w /res \
 sga overlap \
  -m 55 \
  -t 16 -v \
  -p /res/merged.k41.fa.rmdup \
  /res/merged.k41.fa.rmdup.fa
/usr/bin/time -v -o times/cel_musket.10.log \
udocker run \
 -v /home/users-groups/grant_452/plg/alga_tests/algos/SGA/results/cel_musket:/res \
 sga assemble \
  -m 75 -g 0 -r 10 \
  -o /res/assemble.m75 \
  /res/merged.k41.fa.rmdup.asqg.gz
