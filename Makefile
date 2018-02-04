# Makefile
#
# Apache License 2.0 (C) 2018 Tiryoh <tiryoh@gmail.com>
# http://www.apache.org/licenses/LICENSE-2.0
#

PREFIX:=
SOURCE:=receipt_list.csv
GNUPLOT_SCRIPT:=receipt_generator.plt
EXECUTABLE:=output$(PREFIX).pdf

RECEIPT_DATE:=2018年1月30日
RECEIPT_PURPOSE:=謝恩会参加費
RECEIPT_ADDRESS:=東京都千代田区1-1-1
RECEIPT_ORG:=謝恩会実行委員
RECEIPT_AUTHOR:=田中太郎

GNUPLOT:=gnuplot
GNUPLOT_FLAGS:=-e "file='$(SOURCE)'; set out '$(EXECUTABLE)'; receipt_date='$(RECEIPT_DATE)'; receipt_purpose='$(RECEIPT_PURPOSE)'; receipt_address='$(RECEIPT_ADDRESS)'; receipt_org='$(RECEIPT_ORG)'; receipt_author='$(RECEIPT_AUTHOR)'; set datafile separator ','"

all: $(EXECUTABLE)

$(EXECUTABLE): $(SOURCE) $(GNUPLOT_SCRIPT)
	$(GNUPLOT) $(GNUPLOT_FLAGS) $(GNUPLOT_SCRIPT)

clean:
	rm -f $(EXECUTABLE)
