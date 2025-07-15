#!/bin/bash
#FLUX: --job-name=stanky-pancake-3702
#FLUX: --urgency=16

source /home/davidr/scripts/nki_torch.sh
JOBSPERNODE=4
NODELIST=$(scontrol show hostname | paste -d, -s)
IFS=',' read -ra NODE_ARRAY <<< "$NODELIST"
HOSTS=""
for NODE in "${NODE_ARRAY[@]}"; do
    echo $NODE; 
    HOSTS="${HOSTS}$NODE:$JOBSPERNODE,"; 
done
HOSTS=${HOSTS::-1}
echo ${HOSTS}  
DATASET_DIR='/nfs/managed_datasets/LIDC-IDRI/pt/average_no_pad_/'
horovodrun -np $SLURM_NTASKS -H ${HOSTS} --start-timeout 120 --verbose python main.py $DATASET_DIR 512 128 --base_dim 256 --latent_dim 256 --mixing_epochs 128 --stabilizing_epochs 128 --starting_phase 6 --horovod --continue_path /home/davidr/projects/saraGAN/pgan_pytorch_new/runs/Oct21_10-08-46_r34n1.lisa.surfsara.nl/
