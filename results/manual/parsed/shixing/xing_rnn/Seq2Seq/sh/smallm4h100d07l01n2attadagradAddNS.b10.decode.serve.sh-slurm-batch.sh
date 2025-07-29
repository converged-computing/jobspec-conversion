#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/shixing/xing_rnn/Seq2Seq/sh/smallm4h100d07l01n2attadagradAddNS.b10.decode.serve.sh
