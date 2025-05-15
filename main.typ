#import "template.typ": FIT-Protocol, ohms, rnd, volts

#show: FIT-Protocol.with(
  academic-subject: "SUBJECT NAME",
  academic-year: "2024/2025",
  protocol-title: "SEMESTRÁLNÍ PROJEKT",
  protocol-subtitle: "Project subtitle",
  authors: (
    (name: "Honza Novák", login: "xlogin00"),
    (name: "Tomáš Navrátil", login: "xlogin01"),
  ),
  date: "Brno, 19. dubna 2025",
)

= Primary title

#lorem(64)

#align(center)[
  #image("assets/fit_logo_en.png", width: 100%)
]

#pagebreak()

== Secondary title

#lorem(64)

== Secondary title

#lorem(64)

#let U1 = 95;
#let U2 = 115;
#let R5 = 410;
#let R6 = 830;

#let U12 = U1 + U2;
#let R56 = (R5 * R6)/(R5 + R6);

$
  R_56 = (R_5 dot R_6) / (R_5 + R_6) = (R5 dot R6) / (R5 + R6) = ohms(rnd(R56)) \ \
  U_12 = U_1 + U_2 = U1 + U2 = volts(U12)
$

== Secondary title

#lorem(64)

=== Tertiary title

#lorem(32)

#figure(caption: [The figure caption])[
  #text(size: 10pt)[
    Zdroj: Vlastní zpracování
  ]

  #table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, center),
    inset: 8pt,
    stroke: 0.5pt + black,
    strong[XXX], strong[AAA], strong[BBB], strong[CCC],
    [Solution1], [---], [---], [ 123],
    [Solution2], [\$ 39.99 / month], [10], [ 456],
    [Solution3], [ --- ], [2], [ 789 ],
  )

  #emph[\* A special note about the table]
]

#pagebreak()

= Použitá literatura

#v(16pt)

[1] Google. Online. Dostupné z: https://www.google.com. [cit. #datetime.today().display()]

[2] Typst. Online. Dostupné z: https://typst.app. [cit. #datetime.today().display()]


