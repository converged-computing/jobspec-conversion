#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/andreyboytsov/lion-tsne-emnist-test/mnist-experiments/collectedForHPCLargeDataset/single_gaia_job_script.sh
