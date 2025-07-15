#!/bin/bash
#FLUX: --job-name=buttery-animal-8981
#FLUX: --queue=rra
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load apps/cuda/11.3.1
~/scripts/dorado-0.5.0-linux-x64/bin/dorado basecaller --batchsize 64 --trim adapters --verbose sup /shares/pi_mcmindsr/raw_data/20231212_1932_MN45077_FAX70185_835ac3e3/pod5/ > /shares/pi_mcmindsr/outputs/20231212_1932_MN45077_FAX70185_835ac3e3_bc20231216/20231216_basecalls.bam
