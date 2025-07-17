#!/bin/bash
#FLUX: --job-name=prokka
#FLUX: -c=36
#FLUX: --queue=compute
#FLUX: -t=475200
#FLUX: --urgency=16

prokka FLK2019_assembly2/final.contigs.1000plus.fa --outdir output/prokka3 --prefix BacteriaMG --norrna --notrna --metagenome --cpus 36
