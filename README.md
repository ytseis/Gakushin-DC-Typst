# Gakushin-DC-Typst

2026年春に申請する日本学術振興会 特別研究員-DCの申請書を Typst で作成するためのテンプレート。

## 更新履歴
- 2026-05-01 参考文献を更新。

## ファイル構成

```
.
├── theme-dc.typ       # ページ設定・フォント・見出しなどの体裁
├── main-dc.typ        # 本文（こちらを編集する）
└── 2_03_dc_naiyo.pdf  # JSPSからダウンロードした様式PDF（各自用意）
```

## 使い方

### 1. 様式PDFの準備

https://www.jsps.go.jp/j-pd/pd_sin.html から申請書様式（docx）をダウンロードし、研究課題名・説明書きなどの記入例テキストを削除したうえでPDFとして保存する。ファイル名を `2_03_dc_naiyo.pdf` にして、`main-dc.typ` と同じディレクトリに置く。

### 2. `main-dc.typ` を編集する

`dc-theme` の引数に氏名・フォントなどを設定し、本文を書く。使用できるフォントは `typst fonts` で確認できる。

```typst
#show: dc-theme.with(
  me: [氏名],           // フッターに表示される申請者登録名
  font-main: "BIZ UDPMincho",
  font-caption: "BIZ UDPGothic",
)
```

ページの頭では `#section-start(ページ番号)` を呼んで様式の欄に合わせた余白を挿入する。

```typst
// p.1 研究の概要及び研究の位置づけ
#section-start(1)
#display-title([研究課題名])

== 当該分野の状況や課題等の背景
...

#pagebreak()
#section-start(2)
...
```

### 3. コンパイル

```sh
typst compile main-dc.typ
```

## 見出し・研究課題名のスタイル変更

見出し（`==`）と研究課題名のスタイルは `theme-dc.typ` を直接編集して変更する。それぞれコメントアウトで複数のスタイルを切り替えられるようにしてある。

**見出し**（`theme-dc.typ` の `show heading` 部分）:

```typst
// 【】で括る
[#h(-1em)【#it.body】]

// グレーでハイライト
// v(-.6em)+rect(it, fill: gray.transparentize(60%), inset: .2em)
```

**研究課題名**（`theme-dc.typ` の `display-title` 部分）:

```typst
// 下線（デフォルト）
#text(title)
#v(-1.6mm)
#line(length: measure(title).width)

// 【】で括る
// v(-.6em)+[#h(-1em)【#title】]
```

## 図の挿入

[wrap-it](https://github.com/ntjess/wrap-it) パッケージを使って本文中に図を回り込ませることができる（`grid` を使ってもよいが、おそらく面倒）。

```typst
#wrap-content(
  figure(image("fig.png", width: 150pt), caption: [キャプション。]),
  align: right + top,
  column-gutter: 1em,
)[
  本文テキスト...
]
```

## 参考文献

以下のようにすると、リスト形式ではなく横に並べて表示できる。`theme-dc.typ` へはまだ実装していないので、適宜 `main-dc.typ` へ追加してください。

```typst
#import "@preview/alexandria:0.2.2": *
#show: alexandria(prefix: "", read: path => read(path))

#let bib = {
  set text(size: 1em) // 入り切らない場合はフォントサイズを小さくする

  // bibliographyは2列のgridなので、要素を横に並べる
  show grid: g => {
    let cells = g.children.map(cell => cell.body)
    let pairs = range(0, cells.len(), step: 2).map(i =>
      cells.at(i) + h(0.5em) + cells.at(i + 1)
    )
    pairs.join(h(1em))
  }

  [文献]
  bibliographyx(
    "references.bib",
    prefix: "",
    title: "",
    style: "ieee.csl",
  )
}

// 本文中
#line(length: 100%)
#h(-1em)
#bib
```

## 免責事項
本テンプレートは非公式のものであり、作成者はその正確性・完全性を保証しません。申請書の体裁や提出要件については必ずJSPSの公式案内を確認してください。本テンプレートの使用によって生じたいかなる不利益についても、作成者は責任を負いません。

## 使えそうなパッケージ（未検証）
- Figureの挿入: https://typst.app/universe/package/meander
- リスト: https://typst.app/universe/package/efilrst/

## Typst 参考リンク

- [Typst 日本語ドキュメント](https://typst-jp.github.io/docs/)
- [Typst Example Book](https://sitandr.github.io/typst-examples-book/book/about.html)
