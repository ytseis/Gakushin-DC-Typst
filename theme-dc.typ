/*
日本学術振興会 特別研究員-DCの申請書をTypstで作成するためのTypstの設定ファイル。
作成者: ytseis (https://github.com/ytseis)
作成日: 2026-04-06
*/

// コードで改行してもスペースを入れないようにする
// https://zenn.dev/akamimi/articles/04d28e2f4fd602
#import "@preview/cjk-spacer:0.2.0": cjk-spacer

// 図表をうまく挿入するパッケージ
// documentation: https://github.com/ntjess/wrap-it/blob/main/docs/manual.pdf
// example: https://sitandr.github.io/typst-examples-book/book/packages/wrapping.html
#import "@preview/wrap-it:0.1.1": wrap-content

// 様式の分だけ上に余白を入れる
#let top-margins = (
  "1": 8em,
  "2": 14.6em,
  "4": 12em,
  "5": 4.4em,
)
#let section-start(page-n) = {
  v(top-margins.at(str(page-n)))
}

// 研究課題名
#let display-title(body) = context {
  let title = [研究課題名：#body]

  // 下線
  [
    #v(-.3mm)
    #h(-1em)
    #text(title)
    #v(-1.6mm)
    #line(length: measure(title).width)
  ]

  // 【研究課題名：タイトル】
  // v(-.6em)+[#h(-1em)【#title】]
}

// ===== theme =====
#let dc-theme(
  me: [申請 太郎],
  font-main: "BIZ UDPMincho",
  font-caption: "BIZ UDPGothic",
  font-size: 10.5pt,
  leading: .6em,
  spacing: .6em,
  body,
) = {
  // 見出し
  set heading(bookmarked: false)
  show heading: it => {
    set text(font: font-main, size: font-size, weight: "bold")

    // 【】で括る
    [#h(-1em)【#it.body】]

    // グレーでハイライト
    // v(-.6em)+rect(it, fill: gray.transparentize(60%), inset: .2em)
  }

  // footer: 申請者登録名
  let footer = place(dx: 143mm, dy: 5mm)[
    #align(center)[#me]
  ]

  // background: 様式を貼り付ける
  let background = context {
    let n = counter(page).get().first()  // 0始まり
    image("2_03_dc_naiyo.pdf", page: n)
  }

  // page
  set page(
    paper: "a4",
    margin: (x: 15mm, y: 20mm),
    background: background,
    footer: footer,
  )

  // text
  set text(
    font: font-main,
    size: font-size,
    lang: "ja",
  )

  // par
  set par(
    first-line-indent: (all: true, amount: 1em),
    justify: true,
    leading: leading,
    spacing: spacing,
  )

  // figure
  set figure(supplement: [図])
  show figure.caption: it => {
    set text(font: font-caption)
    it.supplement
    it.counter.display(it.numbering)
    [：] // separatorを全角に
    it.body
  }

  show: cjk-spacer


  body
}
