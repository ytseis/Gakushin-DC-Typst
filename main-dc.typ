#import "theme-dc.typ": *
#show: dc-theme.with(
  me: [申請 太郎],
  font-main: "BIZ UDPMincho",
  font-caption: "BIZ UDPGothic",
  font-size: 10.5pt,
  leading: .6em,
  spacing: .6em,
)

#import "@preview/roremu:0.1.0": roremu

// p.1 研究の概要及び研究の位置づけ
#section-start(1)

// 研究課題名
#display-title([ああああああああああ])

// 研究の概要
ああああああああああ

== 当該分野の状況や課題等の背景

ああああああああああ

#let fig = figure(
  rect(fill: gray, radius: 10pt, width: 200pt),
  caption: [キャプション],
)

#lorem(30)

#wrap-content(
  fig,
  align: right+top,
  column-gutter: 1em,
)[
  #lorem(100)
]

== 本研究計画の着想に至った経緯

ああああああああああ

// p.2 研究計画（続き）
#pagebreak()
#section-start(2)

== 研究目的

ああああああ

== 研究計画

ああああああああああ

// p.3 【２】研究計画（２）研究目的・内容等の続き
#pagebreak()

#wrap-content(
  fig,
  align: right+top,
  column-gutter: 1em,
)[
  #h(1em) // 字下げしてくれないので、とりあえず。
  #lorem(40)

  #lorem(40)

  #lorem(40)

]

// p.4 人権の保護及び法令等の遵守への対応
#pagebreak()
#section-start(4)

ああああああああああ

// p.5 研究遂行力の自己分析
#pagebreak()
#section-start(5)

ああああああああああ

// 参考文献は通常の #bibliography 以外に、alexandria (https://typst.app/universe/package/alexandria/) が使えるかもしれない。
