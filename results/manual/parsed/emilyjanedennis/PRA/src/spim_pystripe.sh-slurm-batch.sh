#!/bin/bash
#SBATCH --output=logs/spim_pystripe_%j.out
#SBATCH --error=logs/spim_pystripe_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=25000
#SBATCH --time=03:20:00

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
module load anacondapy/2020.11
. activate lightsheet
echo "Input directory (path to stitched images):" "$1"
echo "Path to flat.tiff file generated using 'Generate Flat' software:" "$2"
echo "Output directory (does not need to exist):" "$3"
pystripe -i "$1" -f "$2" -o "$3"
