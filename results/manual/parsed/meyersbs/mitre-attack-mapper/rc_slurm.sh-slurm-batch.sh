#!/bin/bash
#SBATCH --job-name=mitre_attack8
#SBATCH --account=csec
#SBATCH --output=mitre_attack8.output
#SBATCH --error=mitre_attack8.output
#SBATCH --mail-user=bsm9339@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00

spack unload python
spack load py-scikit-learn@0.22 arch=linux-rhel7-x86_64
spack load py-setuptools@41.4.0 arch=linux-rhel7-x86_64
time ./main.py info ./data/CPTC2018.csv --target=tactics >> trial08_info.out
time ./main.py test ./data/CPTC2018.csv --model_type=nb --target=tactics --append_states=False --append_hosts=True --trial_prefix=trial08 --ignore_singles=True >> trial08_nb_tactics.out
time ./main.py test ./data/CPTC2018.csv --model_type=nb --target=techniques --append_states=False --append_hosts=True --trial_prefix=trial08 --ignore_singles=True >> trial08_nb_techniques.out
time ./main.py test ./data/CPTC2018.csv --model_type=lsvc --target=tactics --append_states=False --append_hosts=True --trial_prefix=trial08 --ignore_singles=True >> trial08_lsvc_tactics.out
time ./main.py test ./data/CPTC2018.csv --model_type=lsvc --target=techniques --append_states=False --append_hosts=True --trial_prefix=trial08 --ignore_singles=True >> trial08_lsvc_techniques.out
