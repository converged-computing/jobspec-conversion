#!/bin/bash
#FLUX: --job-name=GTDB
#FLUX: --queue=omicsbio
#FLUX: -t=720000
#FLUX: --priority=16

module load Python/3.6.3-intel-2016a
module load HMMER/3.2.1-foss-2018b
module load pplacer/1.1.alpha19
gtdbtk classify_wf --batch TEDDY_MAGs --out_dir TEDDY_GTDB --cpus 40 
