#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Kihansi95/ExplanationPairSentencesTasks/templates/oar.train_in_igrida.sh
