#!/bin/bash
#SBATCH --job-name=COVIRT-aws_microbe
#SBATCH --account=COVIRT19
#SBATCH --output=/scratch/06176/jochum00/COVIRT19/stdout/aws.microbe.o%j
#SBATCH --error=/scratch/06176/jochum00/COVIRT19/stderr/aws.microbe.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH --qos=vip

module load tacc-singularity
singularity run $SCRATCH/COVIRT19/singularity_cache/amazon.sif s3 sync s3://bucket_youwant/file $PWD --exclude "*human*" --endpoint-url=the_aws_region --profile your_profile
