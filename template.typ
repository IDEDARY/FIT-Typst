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

// Automatic academic year calculation
// Returns "YYYY/YYYY+1" based on September start
#let get-academic-year(date) = {
  let year = date.year()
  // If we are in Jan-Aug (month < 9), it's still the previous academic start year
  if date.month() < 9 {
    str(year - 1) + "/" + str(year)
  } else {
    str(year) + "/" + str(year + 1)
  }
}

#let FIT-Protocol(
  language: "CZ",
  academic-subject: str,
  academic-year: none,
  protocol-title: str,
  protocol-subtitle: none,
  team: none,
  authors: (),
  location: "Brno",
  date: none,
  document
) = [
  // Determine the academic year to display
  #let display-academic-year = if academic-year != none {
    academic-year
  } else {
    get-academic-year(datetime.today())
  }

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
    block(below: 1.2em, above: 2em)[
      #h.body
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

    #text(14pt)[#display-academic-year]
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
    title: if language == "CZ" {"Obsah"} else {"Outline"},
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

#let Alert(title, color, body) = {
  block(
    stroke: (left: 4pt + color),
    inset: (left: 12pt, top: 6pt, bottom: 6pt),
    width: 100%,
    breakable: true,
    [
      #text(fill: color, weight: "bold")[#title]
      
      #body
    ]
  )
}

#let Note(body) = Alert("Note", rgb("#1f7eeb"), body)
#let Tip(body) = Alert("Tip", rgb("#25a84a"), body)
#let Important(body) = Alert("Important", rgb("#925ef4"), body)
#let Warning(body) = Alert("Warning", rgb("#f1bf19"), body)
#let Caution(body) = Alert("Caution", rgb("#f24b56"), body)


// ===========================================================================
// FIT-Presentation
// ===========================================================================

#import "@preview/touying:0.7.4": *

// Official FIT template colors
#let fit-cyan = rgb("#00A9E0")
#let fit-red = rgb("#FE000C")
#let fit-white = rgb("#FFFFFF")
#let fit-black = rgb("#000000")
#let fit-black-10 = black.transparentize(90%)

// Logo assets bundled from the official potx
#let fit-logo-small = "assets/fit_logo_small.png"
#let fit-logo-wide = "assets/fit_logo_wide.png"

// Page layout constants (960x540pt canvas, 16:9)
#let fit-margin = (top: 55pt, bottom: 30pt, left: 34pt, right: 34pt)

// ---- Slide functions ------------------------------------------------------ 

// Title slide
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: fit-white, header: none, footer: none, margin: 0pt),
    config,
  )
  let info = self.info + args.named()
  let store = self.store

  let body = {
    // Cyan block covering
    place(top + left, block(width: 100%, height: 52%, fill: fit-cyan, spacing: 0pt, {

      // Title in white
      place(bottom + left, dx: 45pt, dy: -35pt, block(width: 90%, height: 200pt, spacing: 0pt)[
        #align(bottom)[
          #text(40pt, weight: "bold", fill: fit-white)[#info.title] \
          
          #if info.subtitle != none [
            #text(30pt, weight: "bold", fill: fit-white)[#info.subtitle]
          ]
        ]
      ])
    }))

    

    // Authors
    place(top + left, dx: 45pt, dy: 320pt, block(width: 500pt, spacing: 0pt)[
      #text(24pt, fill: luma(32.55%))[#store.authors-display]
    ])

    // Date
    if store.date-display != none {
      place(left + bottom, dx: 45pt, dy: -45pt, text(16pt, fill: fit-black)[
        #store.date-display
      ])
    }

    // Wide logo bottom-right
    place(right + bottom, dx: -45pt, dy: -45pt, image(store.logo-wide, width: 329pt))
  }
  touying-slide(self: self, body)
})

// Default content slide
#let slide(
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }

  // The rendered header does not respect this height field
  let header(self) = block(width: 100%, height: 100%, spacing: 0pt, {
    // Faint black band
    place(top + left, block(width: 100%, height: 100%, fill: fit-black-10, spacing: 0pt, {
      // Red accent bar (top-left)
      place(horizon + left, dx: 25pt, block(width: 5pt, height: 23pt, fill: fit-red, spacing: 0pt))
      // Title in cyan (vertically centered in header)
      place(horizon + left, dx: 45pt, block(width: 80%, spacing: 0pt)[
        #text(21pt, weight: "bold", fill: fit-cyan)[
          #if title != auto {
            title
          } else {
            utils.display-current-heading(depth: self.slide-level)
          }
        ]
      ])

      // Cyan accent bar (near top-right, before logo)
      place(horizon + right, dx: -100pt, block(width: 5pt, height: 23pt, fill: fit-cyan, spacing: 0pt))
      // Small FIT logo (top-right)
      place(horizon + right, dx: -25pt, image(self.store.logo-small, height: 25pt))
    }))
  })

  let footer(self) = block(width: 100%, height: 100%, fill: fit-cyan, spacing: 0pt, {
    // Work title (left) and slide number (right)
    std.align(horizon, pad(x: 11pt, components.left-and-right(
      text(14pt, fill: fit-white, self.store.work-title),
      text(14pt, fill: fit-white, context utils.slide-counter.display("1 / 1", both: true)),
    )))
  })

  let self = utils.merge-dicts(
    self,
    config-page(
      fill: fit-white,
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
    set text(fill: fit-black)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})


// Section divider slide: centered cyan heading, footer bar retained.
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon + center)
    set text(size: 1.8em, fill: fit-cyan, weight: "bold")
    utils.display-current-heading(level: level, numbered: numbered, style: auto)
  }
  // Keep footer bar, remove header decorations
  self = utils.merge-dicts(self, config-page(header: none, fill: fit-white))
  touying-slide(self: self, config: config, slide-body)
})


// Full-bleed cyan emphasis slide.
#let focus-slide(
  config: (:),
  align: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: fit-cyan, header: none, footer: none, margin: 2em),
  )
  set text(fill: fit-white, size: 1.5em, weight: "bold")
  touying-slide(self: self, config: config, std.align(align, body))
})


// Centered content slide (no header, footer bar retained).
#let centered-slide(
  config: (:),
  align: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(fill: fit-white, header: none),
  )
  set std.align(align)
  touying-slide(self: self, config: config, body)
})


// ---- Theme ---------------------------------------------------------------

#let FIT-Presentation(
  language: "CZ",
  presentation-title: str,
  presentation-subtitle: none,
  work-title: none,
  advisor: none,
  authors: (),
  team: none,
  location: "Brno",
  date: none,
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  // work-title defaults to presentation-title (shown in footer of every slide)
  let work-title-display = if work-title != none { work-title } else { presentation-title }

  let authors-display = if authors.len() == 0 { none } else {
    for author in authors [
      #if "leader" in author {
        [#author.name]
      } else {
        [#author.name]
      }
      #linebreak()
    ]
  }

  let date-display = get-formatted-date(location, date, language)

  // Compute page dimensions: 960pt base width (matches official FIT template)
  let parts = aspect-ratio.split("-")
  let page-width = 960pt
  let page-height = page-width * float(parts.at(1)) / float(parts.at(0))

  show: touying-slides.with(
    config-page(
      width: page-width,
      height: page-height,
      margin: fit-margin,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      slide-level: 2,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 22pt, font: "Liberation Sans")
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: fit-cyan,
      primary-light: fit-cyan.lighten(70%),
      primary-lighter: fit-cyan.lighten(80%),
      primary-lightest: fit-cyan.lighten(90%),
      primary-dark: fit-cyan.darken(10%),
      primary-darker: fit-cyan.darken(20%),
      primary-darkest: fit-cyan.darken(30%),
      secondary: fit-black,
      secondary-light: luma(25%),
      secondary-lighter: luma(40%),
      secondary-lightest: luma(55%),
      secondary-dark: fit-black,
      secondary-darker: fit-black,
      secondary-darkest: fit-black,
      tertiary: fit-cyan,
      tertiary-light: fit-cyan.lighten(70%),
      tertiary-lighter: fit-cyan.lighten(80%),
      tertiary-lightest: fit-cyan.lighten(90%),
      tertiary-dark: fit-cyan.darken(10%),
      tertiary-darker: fit-cyan.darken(20%),
      tertiary-darkest: fit-cyan.darken(30%),
      neutral: luma(50%),
      neutral-light: luma(70%),
      neutral-lighter: luma(85%),
      neutral-lightest: fit-white,
      neutral-dark: luma(30%),
      neutral-darker: luma(15%),
      neutral-darkest: fit-black,
    ),
    config-info(
      title: presentation-title,
      subtitle: presentation-subtitle,
      author: authors-display,
      date: datetime.today(),
      institution: if language == "CZ" {
        [#university-name-cz \\ #faculty-name-fit-cz]
      } else {
        [#university-name-en \\ #faculty-name-fit-en]
      },
      logo: image(fit-logo-small, height: 1.2em),
    ),
    config-store(
      language: language,
      logo-small: fit-logo-small,
      logo-wide: fit-logo-wide,
      work-title: work-title-display,
      advisor: advisor,
      authors-display: authors-display,
      date-display: date-display,
      align: left,
    ),
    ..args,
  )

  body
}
