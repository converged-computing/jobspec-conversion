#!/bin/bash
#FLUX: --job-name=chocolate-fork-0909
#FLUX: -c=4
#FLUX: --priority=16

module load X11
module load Python
GSWORKDIR='/g/scb/mahamid/fung/Deformation'
GSSITE=$(cat $GSWORKDIR/sitelist.inp | head -${SLURM_ARRAY_TASK_ID} | tail -1)
GSROOT=$GSWORKDIR/$GSSITE
/struct/cmueller/fung/bin/Fiji.app/java/linux-amd64/jdk1.8.0_172/jre/bin/java -Dplugins.dir=/struct/cmueller/fung/bin/Fiji.app/plugins -cp /struct/cmueller/fung/bin/Fiji.app/jars/ij-1.53c.jar:/struct/cmueller/fung/bin/Fiji.app/plugins/bUnwarpJ_-2.6.13.jar bunwarpj.bUnwarpJ_ -align ${GSROOT}_after.tif ${GSROOT}_after_mask.tif ${GSROOT}_before.tif NULL 2 5 0 0.1 0.1 1 30 ${GSROOT}_before_registered.tif ${GSROOT}_after_registered.tif -save_transformation
/struct/cmueller/fung/bin/Fiji.app/java/linux-amd64/jdk1.8.0_172/jre/bin/java -Dplugins.dir=/struct/cmueller/fung/bin/Fiji.app/plugins -cp /struct/cmueller/fung/bin/Fiji.app/jars/ij-1.53c.jar:/struct/cmueller/fung/bin/Fiji.app/plugins/bUnwarpJ_-2.6.13.jar bunwarpj.bUnwarpJ_ -convert_to_raw ${GSROOT}_before.tif ${GSROOT}_after.tif ${GSROOT}_after_registered_transf.txt ${GSROOT}_rawtransf.txt
python $GSWORKDIR/process_raw_transf.py --input $GSROOT
rm ${GSROOT}_rawtransf.txt
