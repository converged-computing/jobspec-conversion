#!/bin/bash
#FLUX: --job-name=stream_benchmark
#FLUX: --urgency=16

sudo apt update
sudo apt install -y gcc gfortran make libopenblas-dev
wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
gcc -O2 -fopenmp -DNTIMES=10 -DSTREAM_ARRAY_SIZE=50000000 stream.c -o stream -lm
mv stream ~/stream_benchmark
cat <<EOF > ~/stream_slurm_job.sh
~/stream_benchmark
EOF
