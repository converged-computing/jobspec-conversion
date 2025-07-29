#!/bin/bash
#SBATCH --job-name=pad1
#SBATCH --output=job-revision-ens-PNE1-%j.out
#SBATCH --error=job-revision-ens-PNE1-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --partition=v100-16gb-hiprio

module load cuda/11.1
module load python3/anaconda/ai-lab
echo '>>> Preparing environment'
echo '>>> Generating AEs (genAE-cifar100-wb-pgd-nonEOT.sh), it may take a while...'
ATTACK_CONFIG="../configs/experiment/cifar100/revision-attack-pgd-nonEot.json"
ATTACK="group3"
EOT="False"
echo $ATTACK_CONFIG
echo $ATTACK $EOT
declare -a TARGET_MODELS=("revisionES1-ens1"
                          "revisionES4-ens2" "revisionES8-ens2" "revisionES16-ens2"
                          )
for t in "${TARGET_MODELS[@]}"
do
  bash genAE-cifar100-wb-pgd-nonEOT.sh $ATTACK_CONFIG $ATTACK $EOT $t
  echo "----------------------"
done
echo '>>> DONE! <<<'
source deactivate
