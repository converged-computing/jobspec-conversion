#!/bin/bash
#FLUX: --job-name=confused-soup-4127
#FLUX: -n=10
#FLUX: --queue=wrighton-hi
#FLUX: -t=784800
#FLUX: --urgency=16

cd /home/projects/Sporulation_AMG/hmp/VirHostMatcher/
gtdbtk classify_wf --extension fna --genome_dir /home/projects/Sporulation_AMG/hmp/VirHostMatcher/host --out_dir /home/projects/Sporulation_AMG/hmp/VirHostMatcher/GTDB_1.5.0_jrr
