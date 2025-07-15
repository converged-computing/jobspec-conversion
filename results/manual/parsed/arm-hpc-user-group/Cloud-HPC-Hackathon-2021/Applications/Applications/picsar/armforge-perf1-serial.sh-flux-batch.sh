#!/bin/bash
#FLUX: --job-name=PICSAR.ARMFORGE-SERIAL
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
spack load picsar%gcc@10.3.0
spack load arm-forge@21.0
input_file="INPUT_FILE_PATH"
cp "$input_file" "input_file.pixr"
mkdir "RESULTS"
map --profile srun picsar
