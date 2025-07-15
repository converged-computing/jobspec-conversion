#!/bin/bash
#FLUX: --job-name=dinosaur-kerfuffle-3505
#FLUX: --queue=cstest
#FLUX: --urgency=16

PACKAGENAME=octeract-engine
PACKAGEVER=3.1.0
FILENAME=$PACKAGENAME-$PACKAGEVER-Linux-Centos7.tar.gz
URL="https://download.octeract.com/$FILENAME"
echo "Running install script to make Package: "  $PACKAGENAME " Version: "  $PACKAGEVER 
INSTALLDIR=/usr/local/packages/live/noeb/$PACKAGENAME/$PACKAGEVER/binary/
SOURCEDIR=$INSTALLDIR/src
MODULEDIR=/usr/local/modulefiles/live/noeb/$PACKAGENAME/$PACKAGEVER/
MODULEFILENAME=binary
FULLPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")
echo "Loaded Modules: " $LOADEDMODULES
mkdir -p $INSTALLDIR
mkdir -p $SOURCEDIR
echo "Install Directory: "  $INSTALLDIR
echo "Source Directory: "  $SOURCEDIR
cd $SOURCEDIR
echo "Download Source"
if test -f "$FILENAME"; then
    rm -r $PACKAGENAME-$PACKAGEVER-Linux
    tar -xzvf  $FILENAME
else
    wget $URL
    tar -xzvf  $FILENAME
fi
echo "Installing:"
mv $SOURCEDIR/$PACKAGENAME-$PACKAGEVER-Linux/* $INSTALLDIR
echo $LOADEDMODULES | awk 'BEGIN{RS=":"}{$1=$1}1' >> $INSTALLDIR/compiler_loaded_modules_list
cp $FULLPATH $INSTALLDIR/install_script.sge
mkdir -p $MODULEDIR
if test -f "$MODULEDIR$MODULEFILENAME"; then
    rm $MODULEDIR$MODULEFILENAME #Remove it if it already exists due to prior failure to install.
    touch $MODULEDIR$MODULEFILENAME
else
    touch $MODULEDIR$MODULEFILENAME
fi
PACKAGENAME=${PACKAGENAME//-/_}
cat <<EOF >>$MODULEDIR$MODULEFILENAME
source /usr/local/etc/module_logging.tcl
proc ModulesHelp { } {
        puts stderr "Makes $PACKAGENAME $PACKAGEVER available"
}
module-whatis   "Makes $PACKAGENAME $PACKAGEVER available"
EOF
sed 's/.*/module load &/' $INSTALLDIR/compiler_loaded_modules_list >> $MODULEDIR$MODULEFILENAME
cat <<EOF >>$MODULEDIR$MODULEFILENAME
set ROOT_DIR_$PACKAGENAME  $INSTALLDIR
EOF
NESTEDROOTDIRVAR=\$ROOT_DIR_$PACKAGENAME
if [ -d $INSTALLDIR/bin ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path PATH        		 $NESTEDROOTDIRVAR/bin
EOF
fi
if [ -d $INSTALLDIR/lib ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path LD_LIBRARY_PATH 	 $NESTEDROOTDIRVAR/lib
prepend-path LIBRARY_PATH 	     $NESTEDROOTDIRVAR/lib
EOF
fi
if [ -d $INSTALLDIR/lib64 ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path LD_LIBRARY_PATH 	 $NESTEDROOTDIRVAR/lib64
prepend-path LIBRARY_PATH 	     $NESTEDROOTDIRVAR/lib64
EOF
fi
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path CMAKE_PREFIX_PATH 	 $NESTEDROOTDIRVAR
EOF
if [ -d $INSTALLDIR/include ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path CPLUS_INCLUDE_PATH  $NESTEDROOTDIRVAR/include
prepend-path CPATH 		         $NESTEDROOTDIRVAR/include
EOF
fi
if [ -d $INSTALLDIR/lib/pkgconfig ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path PKG_CONFIG_PATH     $NESTEDROOTDIRVAR/lib/pkgconfig
EOF
fi
if [ -d $INSTALLDIR/lib64/pkgconfig ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path PKG_CONFIG_PATH     $NESTEDROOTDIRVAR/lib64/pkgconfig
EOF
fi
if [ -d $INSTALLDIR/share/pkgconfig ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path PKG_CONFIG_PATH     $NESTEDROOTDIRVAR/share/pkgconfig
EOF
fi
if [ -d $INSTALLDIR/share/aclocal ]
then
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path ACLOCAL_PATH     $NESTEDROOTDIRVAR/share/aclocal
EOF
fi
cat <<EOF >>$MODULEDIR$MODULEFILENAME
prepend-path PYTHONPATH     $NESTEDROOTDIRVAR/lib
EOF
chown $USER:hpc_app-admins $INSTALLDIR
chmod 775 -R $INSTALLDIR
chown $USER:hpc_app-admins $MODULEDIR$MODULEFILENAME
chmod 775 $MODULEDIR$MODULEFILENAME
OLOG=$SLURM_SUBMIT_DIR/$SLURM_JOB_ID.out
if test -f "$OLOG"; then
    echo "$OLOG exists. Copying to install dir."
    cp $OLOG $INSTALLDIR
fi
