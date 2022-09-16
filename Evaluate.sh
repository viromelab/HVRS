#!/bin/bash
#
declare -a DATASETS=("DS1" "DS2" "DS3");
declare -a VIRUSES=("SVA" "B19" "HPV" "HV4");
#
D_PATH="../output_data/TRACES_hybrid_R5_consensus";
#
for dataset in "${DATASETS[@]}"
  do
  printf "$dataset\n";	  
  for virus in "${VIRUSES[@]}"
    do	  
    if [ -f B-$virus-$dataset.fa ];
      then
      #
      printf "$virus\t";	  
      cp $D_PATH/$virus-consensus-$dataset.fa G_A.fa;
      cp B-$virus-$dataset.fa G_B.fa
      #
      dnadiff G_A.fa G_B.fa ;
      #
      IDEN=`cat out.report | grep "AvgIdentity " | head -n 1 | awk '{ print $2;}'`; 
      ALBA=`cat out.report | grep "AlignedBases " | head -n 1 | awk '{ print $2;}'`;
      SNPS=`cat out.report | grep TotalSNPs | awk '{ print $2;}'`;
      printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
      rm -f G_A.fa G_B.fa ;
      fi
    done
  done
#
