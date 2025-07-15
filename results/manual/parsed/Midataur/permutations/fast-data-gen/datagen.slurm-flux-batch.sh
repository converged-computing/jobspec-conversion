#!/bin/bash
#FLUX: --job-name="fast-data-gen"
#FLUX: -c=10
#FLUX: --queue=cascade
#FLUX: -t=7200
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load GCC/11.3.0
module load Rust/1.65.0
cargo run --release -- -g 10 -m 45 -d 2000000 -t 10 -f ./data/forcegrok/train_data1.csv
my-job-stats -a -n -s
