#!/bin/bash
#FLUX: --job-name=extract      ### job name
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --priority=16

module load intel/19
module load gromacs/2019.4
USAGE="extract-traj.sh base_name starting_gro dest_directory [split_interval_ps]"
base_name=${1}
starting_gro=${2}
dest_dir=${3}
if [ ! "${base_name}" ] || [ ! "${starting_gro}" ] || [ ! "${dest_dir}" ]; then
    echo $USAGE
    exit
fi
split_interval=${4}
xtc_file="${base_name}.xtc"
tpr_file="${base_name}.tpr"
out_root="traj"
rm -rf ${dest_dir}
mkdir ${dest_dir}
cp ${starting_gro} ${dest_dir}/${out_root}.gro
cp ${tpr_file} ${dest_dir}/${out_root}.tpr
mkdir extract-tmp
cd extract-tmp
echo "Make whole."
echo "0" > junk.command
cat junk.command | gmx trjconv -f ../${xtc_file} -pbc whole -o ${out_root}.xtc -s ../${tpr_file}
echo "Remove jumps."
echo "0" > junk.command
cat junk.command | gmx trjconv -f ${out_root}.xtc -pbc nojump -o ${out_root}.xtc -s ../${tpr_file}
echo "Center on protein."
echo "1" > junk.command
echo "0" >> junk.command
cat junk.command | gmx trjconv -f ${out_root}.xtc -center -pbc mol -o ${out_root}.xtc -s ../${tpr_file}
echo "3" > junk.command
echo "0" >> junk.command
cat junk.command | gmx trjconv -f ${out_root}.xtc -s ../${tpr_file} -fit rot+trans -o ${out_root}.xtc
if [ ${split_interval} ]; then
    echo "Split file."
    echo "0" > junk.command
    cat junk.command | gmx trjconv -f ${out_root}.xtc -split ${split_interval} -s ../${tpr_file} -o ${out_root}-split.xtc 
    cp *split* ../${dest_dir}
else
    cp ${out_root}.xtc ../${dest_dir}
fi
cd ..
rm -rf extract-tmp
