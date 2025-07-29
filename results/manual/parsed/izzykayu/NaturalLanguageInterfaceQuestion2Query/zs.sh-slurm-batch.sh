#!/bin/bash
#SBATCH --job-name=Python_job
#SBATCH --mail-user=metzgi01@phoenix.nyumc.org
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --time=01:40:00

module purge
module load pytorch/python2.7/0.3.0_4
module load pytorch/python2.7/0.3.0_4
module load gcc/6.3.0
pip install torchwordemb --user
file_path="/ifs/home/metzgi01/NaturalLanguageInterface/CliNER/data/jun22_train_neg"
for filename in data/jun22_train_neg/*.txt
do
    ./cliner predict --txt $filename --out data/con_neg_val_jun26 --format i2b2 --model models/2012_i2b2_test.model
done
