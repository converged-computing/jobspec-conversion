#!/bin/bash
#SBATCH --job-name=SAAGmcs
#SBATCH --account=m1657
#SBATCH --output=log_mcs_saag_test.log
#SBATCH --mail-user=zhe.feng@pnnl.gov
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --exclusive
#SBATCH --constraint=cpu,ntasks-per-node=128

date
module load python
source activate /global/common/software/m1867/python/pyflex
cd /global/homes/f/feng045/program/PyFLEXTRKR-dev/runscripts
python run_mcs_tbpf_saag.py /global/homes/f/feng045/program/PyFLEXTRKR-dev/config/config_mcs_saag_example.yml
date
