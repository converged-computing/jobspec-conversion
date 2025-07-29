#!/bin/bash
#SBATCH --job-name=example-hpc-alpine-python
#SBATCH --output=example-hpc-alpine-python.out
#SBATCH --mail-user=your-email-address-here@cuanschutz.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal

module purge
module load anaconda/2022.10
conda env remove --name example_env -y
conda env create -f environment.yml
conda activate example_env
python code/example.py --CSV_FILENAME=$CSV_FILEPATH
echo "run_script.sh work finished!"
