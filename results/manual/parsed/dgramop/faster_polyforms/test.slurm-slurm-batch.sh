#!/bin/bash
#SBATCH --job-name=test1
#SBATCH --output=/scratch/%u/%x-%N-%A-%a.out
#SBATCH --mail-user=ktran44@gmu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=normal
#SBATCH --array=1-12%3

PROBABILITY=0.9
LENGTH=1000
SHUFFLES=`expr "$LENGTH" \* "$LENGTH" \* "$LENGTH" `
module load gnu10
mkdir -p /scratch/ktran44/bernoulli/results/$LENGTH/$PROBABILITY
cd /scratch/ktran44/bernoulli/faster_polyforms/
./target/release/main --length $LENGTH --export analysis --shuffles $SHUFFLES  --norender --bernoulli $PROBABILITY > /scratch/ktran44/bernoulli/results/$LENGTH/$PROBABILITY/polyform_$(uuidgen).txt
