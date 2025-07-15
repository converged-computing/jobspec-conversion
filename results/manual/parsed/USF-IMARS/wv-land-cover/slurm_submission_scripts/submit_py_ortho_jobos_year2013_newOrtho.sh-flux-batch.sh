#!/bin/bash
#FLUX: --job-name==Jobos-per-year
#FLUX: --queue=circe
#FLUX: -t=144000
#FLUX: --urgency=16

module purge
module add apps/python/2.7.5
module add apps/proj/6.2.0_el7_gcc
module add apps/gdal/3.0.1_el7_gcc
images1=`ls /work/d/druedaro/img/Jobos_perYear/Jobos_2013b/*.[nN][tT][fF]`
met=`ls /work/d/druedaro/img/Jobos_perYear/Jobos_2013b/*.[xX][mM][lL]`
ortho_out=/work/d/druedaro/output/Ortho/Jobos_perYear/Jobos_2013b/
rrs_out=/work/d/druedaro/output/Rrs/Jobos_perYear/Jobos_2013b/
crd_sys=EPSG:4326
areaName='Jobos'
images1a=($images1)
image=${images1a[$SLURM_ARRAY_TASK_ID]}
echo "orthorectifying $image to $ortho_out"
python /work/d/druedaro/wv2_scripts/pgc_imagery_utils2/pgc_ortho.py -p 4326 -c ns -t UInt16 -f GTiff --no-pyramids $image $ortho_out
module add apps/matlab/r2018a
input_img_basename=$(basename "${image%.[nN][tT][fF]}")
echo $input_img_basename
image2="$ortho_out${input_img_basename}_u16ns4326.tif"
echo $image2
met=($met)
met=${met[$SLURM_ARRAY_TASK_ID]}
matlab -nodisplay -nodesktop -r "WV_Clasific_cleaner_v5_Jobos_v2019.m('$image2','$met','crd_sys','$areaName','$rrs_out','$SLURM_ARRAY_TASK_ID')"
    #### Calculate Total Time
 #   endtime = datetime.today()
 #   td = (endtime-starttime)
 #   LogMsg("Total Processing Time: %s\n" %(td))
