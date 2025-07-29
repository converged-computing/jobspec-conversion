#!/bin/bash
#SBATCH --job-name=fast-data-gen
#SBATCH --account=punim2163
#SBATCH --mail-user=mpetschack@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=4096
#SBATCH --time=02:00:00

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load GCC/11.3.0
module load Rust/1.65.0
cargo run --release -- -g 10 -m 45 -d 2000000 -t 10 -f ./data/forcegrok/train_data1.csv
my-job-stats -a -n -s
