#!/bin/bash
#SBATCH --job-name=COVIRT-aws_microbe
#SBATCH --account=COVIRT19
#SBATCH --output=/scratch/06176/jochum00/COVIRT19/stdout/aws.microbe.o%j
#SBATCH --error=/scratch/06176/jochum00/COVIRT19/stderr/aws.microbe.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --qos=vip

module load tacc-singularity
singularity run ../../singularity_cache/amazon.sif s3 sync s3://nasa-covid $PWD --exclude "*human*" --endpoint-url=https://s3.wasabisys.com --profile wasabi
