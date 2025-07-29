#!/bin/bash
#SBATCH --job-name=cluster-editing
#SBATCH --mail-user=sebastian.paarmann@tuhh.de
#SBATCH --mail-type=END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=7-00:00:00
#SBATCH --partition=ether
#SBATCH --exclude=d[001-016]

set -e
set -u
INSTANCE=$1
RUST_LOG=info RUST_BACKTRACE=1 ./cluster-editing $INSTANCE 2>&1 | tee $INSTANCE.out
exit
