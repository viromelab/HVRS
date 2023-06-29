#!/bin/bash
#
cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaSPAdes" "Haploflow" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA" "V-pipe")
#declare -a list
#declare -p list
#
rm -rf cnt*
rm -rf cvg*
#rm -rf Graphs
mkdir cnt3
mkdir cnt0
mkdir cvg2
mkdir cvg5
mkdir cvg10
mkdir cvg20
mkdir cvg40
mkdir Graphs
i=""
declare ans
check_condition() {
  is_fst_set=$(printf '%s\n' "${FIRST_SET[@]}" | grep -w -- $dataset)
  
  if [ ! -z "$cov_2" ]
    then
    ans=1 
  else
    ans=0
  fi
}

for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd cnt3  
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS9" || $1=="DS10" || $1=="DS11" || $1=="DS12" || $1=="DS13" || $1=="DS14" || $1=="DS15" || $1=="DS16") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k13 -n ${tool})" > ${tool}
  cd ..
  
  cd cnt0 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS1" || $1=="DS2" || $1=="DS3" || $1=="DS4" || $1=="DS5" || $1=="DS6" || $1=="DS7" || $1=="DS8") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k13 -n ${tool})" > ${tool}
  cd ..
  
  cd cvg2 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS9" || $1=="DS17" || $1=="DS18" || $1=="DS19" || $1=="DS20" || $1=="DS21" || $1=="DS22" || $1=="DS23" || $1=="DS24") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg5 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS10" || $1=="DS25" || $1=="DS26" || $1=="DS27" || $1=="DS28" || $1=="DS29" || $1=="DS30" || $1=="DS31" || $1=="DS32") {print $0}}' > "${tool}")
   echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg10
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS11" || $1=="DS33" || $1=="DS34" || $1=="DS35" || $1=="DS36" || $1=="DS37" || $1=="DS38" || $1=="DS39" || $1=="DS40") {print $0}}' > "${tool}")
   echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg20 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS13" || $1=="DS41" || $1=="DS42" || $1=="DS43" || $1=="DS44" || $1=="DS45" || $1=="DS46" || $1=="DS47" || $1=="DS48") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  cd cvg40 
  $(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk '{if ($1=="DS16" || $1=="DS49" || $1=="DS50" || $1=="DS51" || $1=="DS52" || $1=="DS53" || $1=="DS54" || $1=="DS55" || $1=="DS56") {print $0}}' > "${tool}")
  echo "$(sort -t$'\t' -k 14 ${tool})" > ${tool}
  cd ..
  
  
done
#
list_cnt3=($(ls cnt3))  
list_cnt0=($(ls cnt0))
list_cvg2=($(ls cvg2))
list_cvg5=($(ls cvg5))
list_cvg10=($(ls cvg10))
list_cvg20=($(ls cvg20))
list_cvg40=($(ls cvg40))
#  
#printf "${list[*]} \n\n"
#
cd cnt0
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 94
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:5 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cnt0.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cnt0[@]}"]{  
      set key at 61, ymax
      plot file u 13:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cnt3
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 94
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:5 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cnt3.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cnt3.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:42]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "Coverage"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cnt3[@]}"]{  
      set key at 61, ymax
      plot file u 13:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
cd cvg2
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg2.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linetype count 
      count = count + 1
      if(count == 9){
        count = count + 1
      }
     

      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg2.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg2.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg2[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg5
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg5.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 85
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg5.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg5.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg5[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg10
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg10.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 85
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg10.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg10.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg10[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg20
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg20.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 88
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg20.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg20.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg20[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
cd cvg40
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cvg40.pdf"
    set datafile separator "\t"
    ymax = 100.5
    ymin = 91
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:5 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cvg40.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NCSD"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:6 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cvg40.pdf"
    set datafile separator "\t"
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [0:0.16]
    set key outside right top
    set xtics auto
    set ytics auto
    set ylabel "NRC"
    set xlabel "SNPs"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_cvg40[@]}"]{  
      set key at 0.23, ymax
      plot file u 14:7 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ..
#
#
#
#
#
#set multiplot
#plot file u 13:5 title file with linespoints linestyle count
#rm -rf total_stats.tsv
#, "" u 13:5:5 with labels offset char 0,1
#plot "total_stats.tsv" using 13:6:(sprintf("(%d, %d)", $1, $2)) with labels notitle
#set key at 100., 100.
