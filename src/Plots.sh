#!/bin/bash
#
cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaspades" "haploflow" "lazypipe" "metaspades" "metaviralspades" "pehaplo" "qure" "qvg" "spades" "ssake" "tracespipe" "tracespipelite" "virgena" "vispa")
#declare -a list
#declare -p list
#
for i in "${TOOLS[@]}" 
  do
  $(cat total_stats.tsv | grep "${i}-" | awk '$14 == "1" { print $0 }' > ${i}.snp1)
  echo "$(sort -t$'\t' -k13 -n ${i}.snp1)" > ${i}.snp1
  $(cat total_stats.tsv | grep "${i}-" | awk '$14 == "0" { print $0 }' > ${i}.snp0)
  echo "$(sort -t$'\t' -k13 -n ${i}.snp0)" > ${i}.snp0
done
#
list_snp1=($(ls *.snp1))  
list_snp0=($(ls *.snp0))
#  
#printf "${list[*]} \n\n"
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Histogram_Identity.pdf"
    set datafile separator "\t"
    set yrange [97:100]
    set xrange [0:45]
    set xtics auto
    set ytics auto
    set ylabel "Avg Identity"
    set multiplot
    count = 1
    do for [ file in "${list_snp1[@]}"]{   
      set xlabel file
      plot file u 13:5 with lines lt count
      count = count + 1
    }
EOF
#set multiplot
#
#rm -rf total_stats.tsv
#, "" u 13:5:5 with labels offset char 0,1
#plot "total_stats.tsv" using 13:6:(sprintf("(%d, %d)", $1, $2)) with labels notitle
