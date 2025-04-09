#!/bin/bash

#First run the pyton jupter notebook manually, sorry :)
#should produce 
#" HEPevt_Isotropic_EpEm_fixed_Pos_Oct2024_v1.1.dat"


#split the HEpevt file into equal 40 events files and TAR
./splitHEPevt.sh

#copy over the tarm unzip, script and 
cp SplittingHEP_40evts.tar /pnfs/uboone/resilient/users/markross/tars/
cp unzip_script_HEPevt.sh /pnfs/uboone/resilient/users/markross/scripts/
cp HEPevt_AddOverlay_batch_TEMPLATE.fcl /pnfs/uboone/resilient/users/markross/fcls/

#and then submit as you want
project.py --xml fromHEPevt_withOverlays_v1.0.xml --stage genartroot --submit
