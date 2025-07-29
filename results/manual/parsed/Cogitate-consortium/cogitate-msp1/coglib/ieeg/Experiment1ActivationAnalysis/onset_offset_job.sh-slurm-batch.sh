#!/bin/bash
#SBATCH --job-name=onset_offset
#SBATCH --output=/mnt/beegfs/XNAT/COGITATE/ECoG/phase_2/processed/bids/derivatives/activation_analysis/slurm-onset_offset-%A_%a.out
#SBATCH --mail-user=alex.lepauvre@ae.mpg.de
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=1-00:00:00
#SBATCH --partition=octopus

export PYTHONPATH='$PYTHONPATH:/hpc/users/alexander.lepauvre/sw/github/ECoG'

config=""
while [ $# -gt 0 ]; do
  case "$1" in
    --config=*)
      config="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument: ${1}*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
  echo ${participant_id}
  echo ${config}
done
cd /hpc/users/alexander.lepauvre/sw/github/ECoG
module purge; module load Anaconda3/2020.11; source /hpc/shared/EasyBuild/apps/Anaconda3/2020.11/bin/activate; conda activate /hpc/users/$USER/.conda/envs/mne_ecog02
export PYTHONPATH=$PYTHONPATH:/hpc/users/alexander.lepauvre/sw/github/ECoG
python ./Experiment1ActivationAnalysis/onset_offset_master.py --config "${config}"
