// https://github.com/IDEDARY/FIT-Typst

#let university-name = "VYSOKÉ UČENÍ TECHNICKÉ V BRNĚ"
#let university-logo = "assets/vut_logo_cz.png"

#let faculty-name-fit = "Fakulta informačních technologií"
#let faculty-logo-fit = "assets/fit_logo_cz.png"

#let volts(term) = box[#term V]
#let ohms(term) = box[#term Ω]
#let siems(term) = box[#term S]
#let amps(term) = box[#term A]
#let henry(term) = box[#term H]
#let hertz(term) = box[#term Hz]
#let rad(term) = box[#term rad]

#let unit_volts(term) = box[#term [V]]
#let unit_ohms(term) = box[#term [Ω]]
#let unit_siems(term) = box[#term [S]]
#let unit_amps(term) = box[#term [A]]
#let unit_henry(term) = box[#term [H]]
#let unit_hertz(term) = box[#term [Hz]]
#let unit_rad(term) = box[#term [rad]]

#let unit_milihenry(term) = box[#term [mH]]
#let unit_pikofarad(term) = box[#term [#sym.mu#"F"]]

#let rnd(term) = calc.round(term, digits: 4);

#let FIT-Protocol(
  academic-subject: str,
  academic-year: str,
  protocol-title: str,
  protocol-subtitle: none,
  authors: (),
  date: str,
  document
) = [
  // Customize the page details
  #set page(margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 25mm))
  #set heading(numbering: "1.1")
  #set text(font: "Liberation Sans", size: 11pt)

  // Customize the outline formatting
  #show outline.entry: entry => {
    let number = numbering(
      entry.element.numbering, ..counter(heading).at(entry.element.location())
    )
    link(entry.element.location(), [
      #v(-0.1em)
      #h(0.8em * entry.level) #number #h(1em) #entry.element.body
      #h(1em)
      #box(width: 1fr, repeat(". "))
      #h(1em)
      #entry.page()
    ])
  }

  // Customize the outline formatting
  #show outline.entry.where(level: 1): entry => {
    let number = numbering(
      entry.element.numbering, ..counter(heading).at(entry.element.location())
    )
    link(entry.element.location(), strong[
      #v(0.7em) #number #h(1em) #entry.element.body
      #box(width: 1fr, entry.fill)
      #entry.page()
    ])
  }
  
  // Customize the outline heading
  #show heading: h => {
    block(below: 18pt)[
      #h.body
    ]
  }

  // Add image padding
  #show image: img => {
    block(above: 3em, below: 3em)[
      #img
    ]
  }

  // Customize figures
  #set figure(supplement: [Tab.])
  #show figure: f => {
    block(above: 2em, below: 2em)[
      #box(width: 100%)[
        #align(left)[
          #text(style: "oblique", weight: "bold")[#f.caption]
          #f.body
        ]
      ]
    ]
  }

  //#show math.equation.where(block: true): set block(spacing: 3em)
  #show math.equation.where(block: true): eq => {
    block(spacing: 2.65em)[
      #eq
    ]
  }

  // Customize matrix look
  #set math.mat(gap: 1.5em)
  //#show math.equation.where(block: true): set block(spacing: 3em)

  // University details
  #align(center)[
    #image(faculty-logo-fit, height: 10%) #v(16pt)

    #text(16pt, weight: "bold")[#university-name]

    #text(14pt)[#faculty-name-fit]
  ] #v(25mm)

  // Protocol subject
  #align(center)[
    #text(14pt)[#academic-subject]

    #text(14pt)[#academic-year]
  ] #v(30mm)

  // Protocol title
  #align(center)[
    #text(24pt, weight: "bold")[#protocol-title] #v(5mm)

    #text(18pt)[#protocol-subtitle]
  ] #v(1fr)

  // Protocol authors and date
  #grid(
    columns: (1fr, 1fr),
    // Authors
    align(left)[#for author in authors [
      #author.name (#author.login) #linebreak()
    ]],
    // Date
    align(right + bottom)[#date]
  )

  // Protocol outline
  #pagebreak()
  #outline(
    title: "Obsah",
    indent: auto,
    //entry.fill: repeat([]),
  )

  // Remaining document
  #pagebreak()
  #document
]
