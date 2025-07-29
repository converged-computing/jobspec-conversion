#!/bin/bash
#SBATCH --job-name=vak
#SBATCH --account=PAA0202
#SBATCH --mail-user=provost.27@osu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
module load miniconda3
source activate vak-env
cd "/users/PYS1065/kprovost/bioacoustics/Sounds_and_Annotations/Aves/"
Rscript "/users/PYS1065/kprovost/bioacoustics/mp3towav.R"
python3 "/users/PYS1065/kprovost/bioacoustics/rename_xenocanto.py"
vak prep "/users/PYS1065/kprovost/bioacoustics/TOMLS/Aves_slurm.toml"
vak predict "/users/PYS1065/kprovost/bioacoustics/TOMLS/Aves_slurm.toml"
for i in /users/PYS1065/kprovost/bioacoustics/Sounds_and_Annotations/Aves/*/*/*/*annot.csv; do 
python3 "/users/PYS1065/kprovost/bioacoustics/tweetynet_output_to_raven.py" $i 10000 500 0; gzip $i; 
done;
for i in /users/PYS1065/kprovost/bioacoustics/Sounds_and_Annotations/Aves/*/*/*/*/*annot.csv; do 
python3 "/users/PYS1065/kprovost/bioacoustics/tweetynet_output_to_raven.py" $i 10000 500 0; gzip $i; 
done;
