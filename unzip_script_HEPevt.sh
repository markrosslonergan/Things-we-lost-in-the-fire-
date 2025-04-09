## This script is intended for use when grid job to add overlays to the simulated event in HEPevt format
## It needs to be passed to grid node, and run on grid node before the start of any job.
## What it does stepwise: 
## 	1. Unzip the tarball provided (variable TARname)
##      2. Read the HEPevt file list  (variable FileListName)
##      3. Based on Process number assigned to given node, read the path of HEPevt file from the file list
##      4. Replace the placeholder in template fhicl by the HEPevt file name and save it as the fhicl that will be run
## 	   to turn HEPevt into artroot and add overlays
## 
## Configurable parameters:
##   1. TARname     2. Directory Name after unzip
##   3. FileListName  4. TemplateFhicl   
##   5. FinalFhicl
##
## writen by Guanqun, in Oct 2021
#!/bin/bash

## configurable parameter
TARname="SplittingHEP_40evts.tar"
DirName="SplittingHEP/"
##DirName=$(basename -s .tar $TARname)'
FileListName="HEPevt_Isotropic_EpEm_fixed_Pos_Oct2024_v1.1_splited_file_40evts.list"   # name of the list of HEPevt files

TemplateFhicl="HEPevt_AddOverlay_batch_TEMPLATE.fcl"
FinalFhicl="HEPevt_AddOverlay_batch_LOCAL.fcl"



## unzip the tarball with HEPevt files
## unzip command isn't found on grid node, use tar instead
## which will give you a folder which has list of HEPevt file list, and a subfolder containing all HEPevt files
## by default, assume the folder after unzipping has the same name as the tarball
echo "untaring "$TARname"..."
tar -xvf $TARname


## use $PROCESS number of grid node to tell it which hepevt file to use
## if LINECNT > 1000, then read the next HEPevt file list
#declare -i LINECNT=10189
LINECNT=$((PROCESS+1))

## the HEPevt file list that will be used
FileList=$DirName"/"$FileListName
hepevtfile=$(sed "${LINECNT}q;d" $FileList) #getting the file name to run on from HEP file list 
echo "Process: "$PROCESS
echo "HEPevt file list: "$FileList
echo "Line: "$LINECNT
echo "HEPevt file used is: "$hepevtfile


## replace the PlaceHolder in template fcl by the hepevt file
sed -e "s:TEMPTEMPTEMP:$hepevtfile:g" $TemplateFhicl > $FinalFhicl 
