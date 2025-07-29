#!/bin/bash
#SBATCH --job-name=MySerialJob
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:05:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

EXAMPLE_VARIABLE="Hello!"
echo $EXAMPLE_VARIABLE
