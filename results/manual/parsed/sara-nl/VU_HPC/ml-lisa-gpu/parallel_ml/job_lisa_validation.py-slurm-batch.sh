#!/bin/bash
#SBATCH --job-name=hvd_test
#SBATCH --output=hvd_test_out.txt
#SBATCH --error=hvd_test_err.txt
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2

time horovodrun -np 2 -H localhost:2  python mnist_hvd_2.py
