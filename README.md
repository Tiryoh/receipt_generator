# receipt_generator

領収書を連番で発行するためのスクリプトです。

## 使い方

まず、`receipt_list.csv`を編集します。
`領収書管理番号`、`名前`、`金額`の順に並んでいます。

次に`Makefile`の以下の欄を修正してください。

```
RECEIPT_DATE:=2018年1月30日
RECEIPT_PURPOSE:=謝恩会参加費
RECEIPT_ADDRESS:=東京都千代田区1-1-1
RECEIPT_ORG:=謝恩会実行委員
RECEIPT_AUTHOR:=田中太郎
```

最後に、`make`してください。
`output.pdf`が作成されます。
出力サンプルは[`output_sample.pdf`](./output_sample.pdf)です。

## インストール方法

以下のソフトウェアが必要です。

* gnuplot
* make

macOS
```
brew install make
brew install gnuplot --with-aquaterm --with-cairo --with-qt --with-wxmac --with-x11
```

## リスト更新方法

全員同じ金額でリストを作成する場合、次の方法で簡単にリストを作成できます。

* `name_list.csv`に名前だけリストアップ
* 以下のコマンドを実行

```
cat name_list.csv | nl | awk '{print "2017-000"$1","$2",10000"}' > receipt_list.csv
```

## ライセンス

Apache License Version 2.0にて公開しています。

(C) 2018 Tiryoh <tiryoh@gmail.com>
