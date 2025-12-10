// https://github.com/IDEDARY/FIT-Typst

#let university-name-cz = "VYSOKÉ UČENÍ TECHNICKÉ V BRNĚ"
#let faculty-name-fit-cz = "Fakulta informačních technologií"
#let faculty-logo-fit-cz = "assets/fit_logo_cz.png"

#let university-name-en = "BRNO UNIVERSITY OF TECHNOLOGY"
#let faculty-name-fit-en = "Faculty of Information Technology"
#let faculty-logo-fit-en = "assets/fit_logo_en.png"

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

#let get-formatted-date(location, date, language) = {
  if date != none {
    // If a specific date string is provided, use it directly
    [#location, #date]
  } else {
    // Generate automatic date based on today
    let today = datetime.today()
    if language == "CZ" {
      // Czech formatting
      let cz-months = (
        "ledna", "února", "března", "dubna", "května", "června", 
        "července", "srpna", "září", "října", "listopadu", "prosince"
      )
      [#location, #today.day(). #cz-months.at(today.month() - 1) #today.year()]
    } else {
      // English formatting
      [#location, #today.display("[month repr:long] [day] [year]")]
    }
  }
}

#let FIT-Protocol(
  language: "CZ",
  academic-subject: str,
  academic-year: str,
  protocol-title: str,
  protocol-subtitle: none,
  team: none,
  authors: (),
  location: "Brno",
  date: none,
  document
) = [
  // Customize the page details
  #set page(margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 25mm))
  #set heading(numbering: "1.1")
  #set text(font: "Liberation Sans", size: 11pt)

  // Customize the outline formatting (General)
  #show outline.entry: entry => {
    // Only number if the element actually has a numbering scheme
    let number = if entry.element.numbering != none {
      numbering(
        entry.element.numbering,
        ..counter(heading).at(entry.element.location()),
      )
    } else {
      none
    }

    link(entry.element.location(), [
      #v(-0.1em)
      #h(0.8em * entry.level)
      // Only show number and spacer if number exists
      #if number != none {
        [#number #h(1em)]
      }
      #entry.element.body
      #h(1em)
      #box(width: 1fr, repeat(". "))
      #h(1em)
      #entry.page()
    ])
  }

  // Customize the outline formatting (Level 1 - Bold)
  #show outline.entry.where(level: 1): entry => {
    let number = if entry.element.numbering != none {
      numbering(
        entry.element.numbering,
        ..counter(heading).at(entry.element.location()),
      )
    } else {
      none
    }

    link(entry.element.location(), strong[
      #v(0.7em)
      #if number != none {
        [#number #h(1em)]
      }
      #entry.element.body
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
  #show figure.where(
    kind: table,
  ): set figure(supplement: [Tab.])
  #show figure.where(
    kind: image,
  ): set figure(supplement: [Img.])

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

  #show math.equation.where(block: true): eq => {
    block(spacing: 2.65em)[
      #eq
    ]
  }

  // Customize matrix look
  #set math.mat(gap: 1.5em)

  // University details
  #align(center)[
    #image(
      if language == "CZ" {
        faculty-logo-fit-cz
      } else {
        faculty-logo-fit-en
      },
      height: 10%
    ) #v(16pt)

    #text(16pt, weight: "bold")[
      #if language == "CZ" {
        university-name-cz
      } else {
        university-name-en
      }
    ]

    #text(14pt)[
      #if language == "CZ" {
        faculty-name-fit-cz
      } else {
        faculty-name-fit-en
      }
    ]
  ] #v(15mm)

  // Protocol subject
  #align(center)[
    #text(14pt)[#academic-subject]

    #text(14pt)[#academic-year]
  ] #v(15mm)

  // Protocol title
  #align(center)[
    #text(24pt, weight: "bold")[#protocol-title]

    #text(18pt)[#protocol-subtitle]

    #if team != none {
      [#v(30mm) #text(14pt)[#team]]
    }
  ] #v(1fr)

  // Protocol authors and date
  #grid(
    columns: (2fr, 1fr),
    // Authors
    align(left)[#for author in authors [
      #if "credits" in author {
        [#strong[#author.credits %] - ]
      }
      #if "leader" in author {
        [#strong[#author.name (#author.login)] - #if language == "CZ" { [vedoucí] } else { [leader] }]
      } else {
        [#author.name (#author.login)]
      }
      #linebreak()
    ]],
    // Date
    align(right + bottom)[#get-formatted-date(location, date, language)]
  )

  // Protocol outline
  #pagebreak()

  // Add numbering to the page
  #set page(numbering: "1") 

  #outline(
    title: "Outline",
    indent: auto,
  )

  // Remaining document
  #pagebreak()

  // Rest of the document
  #document

  // Bibliography
  #pagebreak()
  #bibliography(
    "sources.yaml",
    style: "ieee",
    full: true,
    title: if language == "CZ" {"Použitá literatura"} else {"Bibliography"},
  )
]



#let ApiEndpoint(method, path, description) = {
  // Define colors for different HTTP methods
  let method-colors = (
    "GET": rgb("#61AFFE"),
    "POST": rgb("#49CC90"),
    "PUT": rgb("#FCA130"),
    "DELETE": rgb("#F93E3E"),
    "PATCH": rgb("#50E3C2"),
    "HEAD": rgb("#663399"),
    "OPTIONS": rgb("#0D5AA7"),
  )

  // Get the color for the current method, defaulting to gray
  let method-color = method-colors.at(upper(method), default: rgb("#888888"))

  // Main container for the endpoint
  rect(
    fill: luma(96.08%), // Light gray background
    stroke: luma(220),
    radius: 4pt,
    width: 100%,
    inset: 4pt,
  )[
    #grid(
      columns: (auto, auto, 1fr),
      column-gutter: 8pt,
      align: center + horizon,
      // HTTP Method Pill
      rect(
        fill: method-color,
        stroke: none,
        radius: 3pt,
        inset: (x: 6pt, y: 4pt),
      )[
        #text(weight: "bold", fill: white, size: 12pt)[#upper(method)]
      ],
      // Endpoint Path
      text(weight: 500, size: 10pt, style: "italic", font: "Noto Sans Mono")[#path],
      // Endpoint Description
      align(right)[#text(luma(35.29%), size: 10pt)[#description #h(4pt)]]
    )
  ]
}