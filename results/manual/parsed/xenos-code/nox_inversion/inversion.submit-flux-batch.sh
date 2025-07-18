#!/bin/bash
#FLUX: --job-name=inversion
#FLUX: --queue=singlepe
#FLUX: -t=14400
#FLUX: --urgency=16

myiter=antbe6 #name (APPL) of this iteration
previter=antbe5 #name of previous iteration
previter2=antbe4 #name of 2 iterations ago
base=std7 # name of non-GSI run in this iteration
concdir=std6 # name of non-GSI run in previous iteration
toplev=20 # top level used to calc beta
month=7 # number of the month of this iteration
calcbeta=True # True or false, case insensitivie
basedir=/work/ROMO/users/bhenders/HAQAST/NO2ASSIM/CMAQ/ # base project CMAQ directory
betafile=../antbe0_inversion_analysis.nc #doesn't change, ignored if calcbeta=True
mydir=/work/ROMO/users/bhenders/HAQAST/NO2ASSIM/CMAQ/scripts/hemi/${myiter}/
datadir=${basedir}/scripts/hemi/
scriptdir=${datadir}/nox_inversion/
. ~/.bashrc
conda activate py38
padmonth=$(printf "%02d\n" $month)
outname=${datadir}/vcd_partial_${toplev}L_${myiter}_2018${padmonth}.nc
outnamestd=${datadir}/vcd_partial_${toplev}L_${base}_2018${padmonth}.nc
echo 'Making intermediate VCD files'
python ${scriptdir}/make_intermediate_files.py ${myiter} ${toplev} ${outname}
python ${scriptdir}/make_intermediate_files.py ${base} ${toplev} ${outnamestd}
echo 'Done make intermediate VCD files'
emisdir1=${previter}_posterior # name of emissions created by previous iteration
emisdir2=${previter2}_posterior # name of emissions used as input to previous iteration
emisdirnew=${myiter}_posterior # name of emissions to be created by this inversion
echo 'Making emissions files'
python ${scriptdir}/make_emissions_files.py $emisdir1 $datadir
echo 'Done making emissions files'
cutfracfile=${mydir}/${previter}_inversion_analysis.nc # analysis file of previous iteration
python ${scriptdir}/do_inversion_cli.py $mydir $datadir $emisdir1 $myiter $base $betafile $month $toplev $calcbeta $cutfracfile $emisdir2 $concdir
conda deactivate
. /etc/profile.d/modules.sh
module purge
module load intel/18.0.2
module load nco-4.9.3/intel-19.0
module load netcdf-4.4.1/intel-18.0
arg1=${basedir}/input_2018_hemi/emis/ # emissions base directory
arg2=${emisdir1}/ # name of emissions used as inputs to this iteration
arg3=${emisdirnew}/ # name of emissinos to be created by this inversion
arg4=${mydir}/${myiter}_inversion_analysis.nc # analysis file of this iteration
mkdir -p ${basedir}/input_2018_hemi/emis/${emisdirnew}
${scriptdir}/scale_emis_iter.sh $arg1 $arg2 $arg3 $arg4
cp -i ${basedir}/input_2018_hemi/emis/${emisdir1}/link.sh ${basedir}/input_2018_hemi/emis/${emisdirnew}/.
cp -i ${basedir}/input_2018_hemi/emis/${emisdir1}/link2.sh ${basedir}/input_2018_hemi/emis/${emisdirnew}/.
cd ${basedir}/input_2018_hemi/emis/${emisdirnew}
./link.sh
./link2.sh
