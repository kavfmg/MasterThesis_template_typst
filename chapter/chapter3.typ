#import "../theme/template.typ": *

= tips

== 有用な関数
筆者が修論にて使用したカスタム関数のうち、ほかの人にも有用そうな奴らを紹介する。全部template.typの下の方にあるぞ。
=== mymemo, TBC
ただのブロック。mymemoは水色、TBCは橙でfillし、前者はただのメモとして使用し、後者は確認事項(要出典箇所とか、修正コメントもらった箇所とか)を視覚的にわかりやすくするのに使用。
#grid(
  columns: (50%, 50%),
  [
    ```typst
    #mymemo[mymemo]
    #TBC[要確認事項]
    ```
  ],
  [
    #mymemo[mymemo]
    #TBC[要確認事項]
  ],
)

=== todo, show_todo
todoで文書内の各位置にタスクを記載すると、`<todo>`というタグのついたテキストとして出力する。そいでもって文書内の適当な場所にて`#show_todo`することにより、`<todo>`タグをクエリして一覧表示してくれる。あとついでに文書内の各todoの箇所にリンクもつけてくれるよ。ラボで回覧してたくさんコメントをもらった時に対応し忘れることがなくなるのでとても便利。大抵概要を最後に書くと思うので、概要のページにてshowするのがいいと思われる。
#grid(
  columns: (50%, 50%),
  [
    ```typst
    #todo()[やることその1]\
    #todo()[やることその2]
    #show: show_todo
    ```
  ],
  [
    #todo()[やることその1]\
    #todo()[やることその2]
    #show: show_todo
  ],
)

筆者の普段の研究ノートではその発展系としてstatus引数を受け取るようにして、ステータスに応じて未着手/対応中/実行済の3段階に分けて表示するようにしている。

=== pbox
`#place`関数というのがあり、こいつは文書内の好きな場所にコンテンツを配置できる。position引数としてtop/horizon/bottom, left/center/rightなどが指定できるのだが、どうも内部的にはアラインメントも連動してしまうようで、例えば
```typst
#place(right)[
  #block(stroke: red, width: 50%)[
    Hello, World!
  ]
]
```
と書くと→このように表示されてしまう。
#place(right, dy: -2em)[
  #block(stroke: red, width: 50%)[
    Hello, World!
  ]
]
place(right)を使いたい時ってのは単に右側に置きたいだけであって文字は普通に左詰の方がいい(たまにcenterとかrightとかにしたいときもあるけどそれは別途指定するようにしたい)ので、こういうのを作った。といっても単にplaceの中で改めてset alignしているだけである。適宜オプションをつけてやることでblockのカスタムが可能になる#footnote[
  この挙動は、pboxの定義に引数として`..arg`を受け取れるようにしてそれをそのままblockのオプションに投げるようにすることで実現している。
  ```typst
    #let pbox(pos, width: auto, dx: 0pt, dy: 0pt, alignment: left, ..arg, body) = {
    place(pos, dx: dx, dy: dy)[
      #set align(alignment)
      #block(
        width: width,
        ..arg,
      )[#body]
    ]
  }
  ```
  ドット二つはその中身を展開することを表している。例えば`pbox(right, stroke: red, fill: blue)`と書くとargとしては"stroke: red, fill: blue"というそのままでは意味をなさない値が渡されるが、これをカンマ区切りで展開して"stroke: red", "fill: blue"という別々の引数としてblockのオプションに流してくれる、ということ。
]。

これを使えば、以下のように右配置でも左詰でテキストを書き込める。`alignment: right`と書けば右詰になるぞ。
#grid(
  columns: (auto, 50%),
  column-gutter: 10pt,
  [
    ```typst
      #pbox(right, width: 90%, stroke: red)[Hello, World!]
    ```
  ],
  [
    #pbox(right, width: 90%, stroke: red)[Hello, World!]
  ],
)



== 有用なパッケージ<chap_package>
main.typの冒頭にあるように、`#import`は自前のtypファイルのみならず他パッケージも導入することができる。ここでは自分が使用した有用パッケージを紹介する。

ちなみにパッケージの一覧が#link("https://typst.app/universe/search/?kind=packages", [typst universe])にある。面白いものが多数あるので暇な時に眺めてるといいだろう。ついでにいうと左のメニューからtemplatesを選べば文書テーマの一覧が出てくる。今更ながら最初から律儀にカスタムしなくとも公式にあるテンプレ一覧から適当に好みを見つけてimportして利用、慣れてきたらそれをカスタムしながら文法を覚えるという流れの方が多分よい。
=== unify, physica, flecher
unifyは単位、physicaは物理関係のなんやら、flecherはダイアグラム作成のためのパッケージ。
#link("https://qiita.com/key_271/items/8629980c4c1ff0e55f41")にいい感じにまとまった記事があるのでそちらを参照。

=== zero
#link("https://typst.app/universe/package/zero/")

数字のフォーマットをしてくれるパッケージ。numとformat-tableをよく使った。

numは(unifyにもあったが)誤差とか指数表記とかを書くための関数。unifyのより若干やこっちの方が使いやすい印象がある。さすがに個人の好みレベルだが
#import "@preview/zero:0.6.1": format-table, num
#figure(
  table(
    columns: 4,
    stroke: none,
    table.vline(x: 2),
    align: left,
    [Code], [Output], [Code], [Output],
    table.hline(),
    `num("1.2e4")`, num("1.2e4"), `num[1.2e4]`, num[1.2e4],
    `num("-5e-4")`, num("-5e-4"), `num(fixed: -2)[0.02]`, num(fixed: -2)[0.02],
    `num("9.81+-.01")`, num("9.81+-.01"), `num("9.81+0.02-.01")`, num("9.81+0.02-.01"),
    `num("9.81+-.01e2")`, num("9.81+-.01e2"), `num(base: 2)[3e4]`, num(base: 2)[3e4],
  ),
)
てかオプションめちゃあるんやね、知らんかった。num自体の設定はset-numを使うらしい。
```typst
#set-num(product: math.dot, tight: true)
```

format-tableは表内の数字位置を揃える。以下の例だと1列目は特に指定なく、2列目に関しては小数点位置で揃えるように、ということ。
#grid(
  columns: (50%, 50%),
  [
    ```typst
    #figure({
      show: format-table(none, auto)
      table(
        columns: 2,
        [1], [1.2],
        [2], [2],
        [3], [300]
      )
    })
    ```
  ],
  [
    #figure({
      show: format-table(none, auto)
      table(
        columns: 2,
        [1], [1.2],
        [2], [2],
        [3], [300],
      )
    })
  ],
)

=== cheq
#link("https://typst.app/universe/package/cheq/")

チェックリストを作れる。別になくても困らないものではあるが、たまに使ったので一応紹介。
#grid(
  columns: 2,
  column-gutter: 5pt,
  [
    ```typst
    #import "@preview/cheq:0.3.0": checklist
    #show: checklist.with(extras: true)
    - [x] タスク1
    - [ ] タスク2
    - [!] タスク3
    - [u] タスク4
    - [I] タスク5
    - [>] タスク6
    ```
  ],
  [
    #import "@preview/cheq:0.3.0": checklist
    #show: checklist.with(extras: true)
    - [x] タスク1
    - [ ] タスク2
    - [!] タスク3
    - [u] タスク4
    - [I] タスク5
    - [>] タスク6
  ]
)
