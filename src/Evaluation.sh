#!/bin/bash
#
#declare -a DATASETS=("DS1" "DS2" "DS3");
declare -a DATASETS=("DS1");
declare -a VIRUSES=("SVA" "B19" "HPV" "VZV");
#
D_PATH="reconstructed";
#
for dataset in "${DATASETS[@]}" #analyse each virus
  do
  printf "$dataset\n";	  
  for virus in "${VIRUSES[@]}" #analyse each virus
    do
    for file in `cd ${D_PATH}/${dataset};ls -1 ${file}` #for each fasta file in curr dir
    do 	 
      printf "File: $file\nDataset: $dataset \nVirus: $virus\n\n"; #print file name, virus and dataset	  
      cp $D_PATH/$dataset/$file G_A.fa; #reference
      cp $dataset.fa G_B.fa #query
      #
      dnadiff G_A.fa G_B.fa ; #run dnadiff
      #
      IDEN=`cat out.report | grep "AvgIdentity " | head -n 1 | awk '{ print $2;}'`;  #retrieve results
      ALBA=`cat out.report | grep "AlignedBases " | head -n 1 | awk '{ print $2;}'`;
      SNPS=`cat out.report | grep TotalSNPs | awk '{ print $2;}'`;
      printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
      rm -f G_A.fa G_B.fa ; #remove tmp files
    done
  done
done
#
