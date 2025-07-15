#!/bin/bash
#FLUX: --job-name=friendly-sweep
#FLUX: --queue=dept_gpu
#FLUX: -t=1209600
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate pytorch_conda_200307
module load cuda/10.1
mkdir -p /scr/jok120
cd /scr/jok120
if ! [[ -d protein-transformer ]]
then
    echo "Cloning repo."
    git clone git@github.com:jonathanking/protein-transformer.git
    rsync /net/pulsar/home/koes/jok120/protein-transformer/data/proteinnet/casp12_200218_30.pt protein-transformer/data/proteinnet
    cd protein-transformer/protein_transformer
else
    cd protein-transformer/protein_transformer
    git pull
fi
echo "Updated repo."
wandb agent --count 1 koes-group/protein-transformer/ji5vzfek
echo "Completed wandb agent."
rsync -avzh --exclude "*.gltf" --exclude "*.png" wandb /net/pulsar/home/koes/jok120/protein-transformer/protein_transformer/wandb
echo "Completed rsync."
exit 0
