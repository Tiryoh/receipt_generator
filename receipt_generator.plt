set encoding utf8

# 参照:http://www.ss.scphys.kyoto-u.ac.jp/person/yonezawa/contents/program/gnuplot/reciept.html

number = 1 # データファイル中の領収書IDの入っているコラムの指定
name  = 2  # データファイル中の宛名の入っているコラムの指定
money = 3  # データファイル中の金額の入っているコラムの指定

hsize = 91.0 #mm 
vsize = 55.0 #mm

Hsize = 210.0 # mm (A4 size)
Vsize = 297.0 # mm (A4 size)

bm = 11.0 # mm;  bottom margin
tm = 11.0 # mm;  top margin
lm = 14.0 # mm;  left margin
rm = 14.0 # mm;  right margin


# 数字に3桁ごとにカンマを入れる関数
addcomma(x) = (x >= 1000000 ? sprintf("%d,%03d,%03d", int(x)/1000000, (int(x-int(x)/1000000*1e6)/1000), int(x)%1000) : \
     (x >= 1000 ? sprintf("%d,%03d", int(x)/1000, int(x)%1000) : sprintf("%d", int(x))))

# データ数の取得
stats file u 0 nooutput 
N = STATS_records


# set terminal pdfcairo size 21.0cm,29.7cm font "Meiryo,10" enhanced
set term pdfcairo size 21.0cm,29.7cm enhanced
# set out "output.pdf"

set size hsize/Hsize, vsize/Vsize

# 枠線が要らない場合は次行のコメントを外す
#set border 0

unset xtics
unset ytics
set format xy ""
set xrange [0:1]
set yrange [0:1]
set tmargin 0
set bmargin 0
set rmargin 0
set lmargin 0
set label 1 at graph 0.05,0.92 left "領収書" font ",22"
set label 2 at graph 0.95,0.9 right receipt_date
set label 3 at graph 0.5,0.42 center ("但 " . receipt_purpose . "として")
set label 4 at graph 0.5,0.34 center "上記正に領収いたしました。" font ",12"
set label 5 at graph 0.95,0.25  right receipt_address
set label 6 at graph 0.95,0.19 right receipt_org
set label 7 at graph 0.95,0.10 right (receipt_author . "　印  ") font ",12"


i = 0

do for [i=0:N-1]{
	if (i%10 == 0){
		set multiplot
	}
	if (i%10 < 5) {
		set origin lm/Hsize, (bm+(4-i%10)*vsize)/Vsize
	}
	else {
		set origin (lm+hsize)/Hsize, (bm+(9-i%10)*vsize)/Vsize
	}
	plot file using (0.5):(0.72):("{/:Bold ". stringcolumn(name) . " 様}") every ::i::i with labels font ",25" notitle,\
		file using (0.5):(0.56):("\¥" . addcomma(column(money)) . "-") every ::i::i with labels font ",30" notitle
	plot file using (0.95):(0.85):("領収書番号 : " . stringcolumn(number) ) every ::i::i with labels right font ",12" notitle
	if (i%10 == 9){
		unset multiplot
	}
}


unset multiplot
set term pop
set out
# replot
