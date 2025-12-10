#import "template.typ": FIT-Protocol, ohms, rnd, volts, ApiEndpoint

#show: FIT-Protocol.with(
  // Change language to english, default is czech
  language: "EN",
  academic-subject: "SUBJECT NAME",
  academic-year: "2024/2025",
  protocol-title: "SEMESTRAL PROJECT",
  protocol-subtitle: "Project subtitle",
  // This field is optional
  team: [
    Team #strong[10xEngineers]
    #v(5mm)
    - Variant 1
    - Option B
  ],
  authors: (
    // You can optionaly set a person to be leader
    (name: "Honza Novák", login: "xlogin00", leader: true),
    (name: "Honza Novák", login: "xlogin00"),
    // You can specify optional credits per person
    (name: "Tomáš Navrátil", login: "xlogin01", credits: 50),
  ),
  // You can optionally override the automatic date and location
  //location: "Praha",
  //date: "19. dubna 2025",
)

= Primary title

#lorem(64)

#align(center)[
  #image("assets/fit_logo_en.png", width: 100%)
]

You can make nice swagger-like endpoints!

#ApiEndpoint(
  "POST",
  "/api/data/{UUID}",
  "Creates a new data record"
)
#ApiEndpoint(
  "GET",
  "/api/data/{UUID}",
  "Returns a JSON with the data"
)
#ApiEndpoint(
  "PUT",
  "/api/data/{UUID}",
  "Updates the existing data"
)
#ApiEndpoint(
  "DELETE",
  "/api/data/{UUID}",
  "Deletes a data record"
)

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
    Source: Own work
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

