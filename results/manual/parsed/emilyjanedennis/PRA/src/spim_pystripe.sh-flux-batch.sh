#!/bin/bash
#FLUX: --job-name=astute-sundae-5562
#FLUX: -c=12
#FLUX: -t=12000
#FLUX: --urgency=16

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
