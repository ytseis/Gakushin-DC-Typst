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

// 様式の分だけ上に余白を入れる（目分量で合わせた）
#let top-margins = (
  "1": 84pt,
  "2": 153pt,
  "4": 126pt,
  "5": 46pt,
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

// highlight
// cf: https://github.com/typst/typst/issues/2939; https://github.com/typst/typst/issues/5324
#let hl(body, font: "BIZ UDPGothic", fill: black, text-fill: white, outset: .2em) = {
  set text(fill: text-fill, font: font)

  box(
    fill: fill,
    outset: outset,
    body
  )
}

// 和文と欧文のフォントを別々に指定する→showするとheadingもmainに統一されてしまった。
// reference: https://zenn.dev/mkpoli/articles/6234c1d2a595bd

// ===== theme =====
#let dc-theme(
  me: [申請 太郎],
  font-main: "BIZ UDPMincho",
  font-heading: "BIZ UDPGothic",
  font-caption: "BIZ UDPGothic",
  font-math: "Noto Serif Math",
  font-size: 10.5pt,
  leading: .6em,
  spacing: .6em,
  body,
) = {
  // 見出しのしおりを作成しない
  set heading(bookmarked: false)

  // 見出しのスタイル
  show heading: it => {
    set text(font: font-heading, size: font-size, weight: "bold")

    if it.level == 2 {
      // 【】で囲む
      // [#h(-1em)【#it.body】]

      // 白文字、黒ハイライト
      v(.1em)
      h(-1em + .1em)
      hl(
        text(fill: white, size: 1em, weight: "semibold", font: font-heading, it.body),
        font: font-heading,
        fill: black,
        text-fill: white,
        outset: (x: .1em, y: .2em),
      )
      v(.1em)
    } else if it.level == 3 {
      // グレーハイライト
      v(.1em)
      h(-1em + .1em)
      hl(
        it.body,
        fill: gray.transparentize(50%),
        text-fill: black,
        font: font-heading,
        outset: (x: .1em, y: .2em),
      )
      v(.1em)
    }
  }

  // *強調*
  show strong: it => {
    set text(weight: "semibold", style: "normal", font: font-strong)
    underline(it.body)
  }

  // footer: 申請者登録名
  let footer = place(dx: 143mm, dy: 5mm)[
    #align(center)[#me]
  ]

  // background: 様式を貼り付ける
  let background = context {
    let n = counter(page).get().first() // 0始まり
    image("2_03_dc_naiyo.pdf", page: n)
  }

  // 句読点
  show "、": "，"
  show "。": "。"

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

  show math.equation: set text(font: font-math)

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
