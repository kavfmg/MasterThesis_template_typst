#import "theme/template.typ":  *
#import "theme/state.typ"

#state.thesis(
  [
    #place(center, text(20pt)[20XX年度　修士論文])
    #place(center+horizon, dy: -100pt, text(25pt)[修論テンプレ])
    #place(center+horizon, dy: -50pt, text(20pt)[(Template for Master thesis)])
    #place(center+horizon, dy: +100pt, text(15pt)[
      東京大学理学系研究科\
      物理学専攻　XX研究室\
      学籍番号 xxxxxxxxx
    ])
    #place(center+horizon, dy: +160pt ,text(20pt, [おなまえ]))
    #place(center+bottom, dy: 0pt, [#datetime.today().display("[year]年[month padding:none]月[day padding:none]日")])
  ],
  [
    #align(center)[#text(1.2em)[*概要*]]
    #include "chapter/abst.typ"
  ],
  [
    #include "chapter/chapter1.typ"
    #include "chapter/chapter2.typ"
    #include "chapter/chapter3.typ"
  ],
  [
    #include "chapter/appendix1.typ"
    #include "chapter/appendix2.typ"
  ],
  [
    #include "chapter/ack.typ"
  ]
)
