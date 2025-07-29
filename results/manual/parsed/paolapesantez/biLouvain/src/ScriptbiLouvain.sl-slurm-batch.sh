#!/bin/bash
#SBATCH --job-name=biLouvainMethod
#SBATCH --mail-user=p.pesantezcabrera@wsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=00:10:00
#SBATCH --partition=debug
#SBATCH --licenses=project

module load gcc/6.1.0
folder="/global/homes/p/ppesante/biLouvain/inputData/"
executable=biLouvain
numProcess=(1)
numThreads=(1)
order=3
cutoffPhases=0.0
cutoffIterations=0.01
datasets=(biSBM301 biSBM30)
for i in ${datasets[@];}
do
        fileName=$folder${i}"_bipartite.txt"
	initialCommunities=$folder${i}"_InitialCommunities.txt"
        srun -n $numProcess ./$executable -i $fileName -d "," -order $order -ci $cutoffIterations -cp $cutoffPhases -fuse 1
done
exit 0
