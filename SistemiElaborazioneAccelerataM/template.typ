// --- COLORI E VARIABILI GLOBALI ---
#let primary-cyan = rgb("#008b8b")
#let light-cyan = rgb("#8fd7d7ff")
#let dark-bg = rgb("#1e1e1e")

// Keyword in ciano (grassetto colorato)
#let kw(it, color: primary-cyan) = strong(text(fill: color, it))

// Evidenziazione arrotondata
#let hl(it, color: rgb("#ccffff")) = box(
  fill: color,
  radius: 3pt,
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  it
)

// --- FUNZIONI DI CALLOUT ---
#let callout(title: "", icon: "", color: rgb("#597c7cff"), body) = {
  block(
    width: 100%,
    fill: color.lighten(95%),
    stroke: (left: 4pt + color),
    inset: (x: 12pt, y: 10pt),
    radius: 4pt,
    breakable: true,
    stack(
      spacing: 0.6em,
      grid(
        columns: (10pt, 1fr),
        gutter: 8pt,
        align: (center + horizon, left + horizon),
        text(fill: color, size: 1.2em)[#icon],
        underline(strong(text(fill: color, size: 1.1em, title)))
      ),
      text(fill: black)[ 
      #v(0.5em)
      #body
    ]
    )
  )
}

#let crop(img, top: 0pt, bottom: 0pt, left: 0pt, right: 0pt) = {
  block(clip: true)[
    #box(inset: (top: -top, bottom: -bottom, left: -left, right: -right))[
      #img
    ]
  ]
}

#let nota(corpo) = [
  #hl(color:yellow.lighten(75%))[#v(-3pt)👉 _#underline[*Nota*]_]: #corpo \
]

#let tip(corpo) = [
  #hl(color:green.lighten(70%))[✅ _#underline[*Tip*]_]: #corpo \
]

#let problema(corpo) = [
  #hl(color: red.lighten(80%))[#v(-3pt)❗️ _#underline[*Problema*]_]: #corpo \
]

#let why(titolo: "", corpo) = [
  #hl(color: fuchsia.lighten(85%))[🤔_#underline[*Why#titolo?*]_]: #corpo \
]

#let how(titolo: "", corpo) = [
  #hl(color: blue.lighten(75%))[👨🏻‍🏫_#underline[*How#titolo?*]_]: #corpo \
]

#let extra(corpo) = [
  #v(-6pt)
  #set par(leading: 4pt) // Imposta l'interlinea per questo bloccot
  #text(style: "italic", fill: gray.darken(43%), size: 0.8em)[#corpo]
]

#let quindi = $=>$

#let arrow = $->$

#let definizione(title, body) = callout(title: title, icon: "📖", color: rgb("#008b8b").darken(50%), body)
#let importante(title, body) = callout(title: title, icon: "⚠️", color: rgb("#e19b19"), body)
#let esempio(title, body) = callout(title: title, icon: "📝", color: rgb("#777777").darken(10%), body)

#let note(it) = block(
  fill: rgb("#e1f5fe"),
  stroke: (left: 3pt + rgb("#00b0ff")),
  inset: 10pt,
  width: 100%,
  it
)
// --- FUNZIONE PRINCIPALE ---
#let project(
  title: "",
  subject: "",
  author: "",
  logo_subject: none,
  logo_personal: none,
  year: { let y = datetime.today().year(); str(y - 1) + "/" + str(y) },
  bento_url: "",
  paypal_url: "",
  contact_url: "",
  body
) = {
  // Configurazione PDF e Font
  set document(author: author, title: title)
  set text(font: "New Computer Modern", lang: "it", size: 10pt, hyphenate: true)
  set heading(numbering: "1.1.")

  set par(justify: true)
  
  // --- REGOLE DI STILE (Applicate a tutto il body) ---
  show link: set text(fill: primary-cyan)
  
  // Stile Codice Blocchi (DARK)
  show raw.where(block: true): it => {
    block(
      fill: dark-bg,
      inset: 10pt,
      radius: 6pt,
      width: 100%,
      stroke: 0.5pt + gray.darken(50%),
      {
        set raw() // Palette
        set text(fill: rgb("#f8f8f2"), size: 9pt, font: "DejaVu Sans Mono")
        it
      }
    )
  }

  // Stile Codice Inline
  show raw.where(block: false): it => box(
    fill: rgb("#f0f0f0"),
    inset: (x: 3pt),
    radius: 2pt,
    text(font: "DejaVu Sans Mono", size: 9pt, it)
  )

  // Stile Immagini e Figure
  show figure: set block(spacing: 1.5em)
  show figure.caption: set text(size: 0.9em, style: "italic")

  // --- PAGINA TITOLO ---
  page(align(center + horizon)[
    #v(7cm)
    #if logo_subject != none { image(logo_subject, width: 40pt) } else { box() }
    #v(3em)
    #text(weight: 700, size: 2.5em, title) \
    #v(1em)
    #text(size: 1.5em, fill: dark-bg, subject) \
    #v(2cm)
    #text(size: 1.2em, author)
    #if logo_personal != none { image(logo_personal, width: 20pt) } else { box() }
    #v(1fr)
    #text(year)
  ])

  pagebreak(to: "even")

  // --- PAGINA DISCLAIMER / WARNING ---
  page(align(center + horizon)[
    #block(width: 80%)[
      #text(weight: "bold", size: 1.4em, fill: red.darken(20%))[Disclaimer & Info]
      #v(1em)
      #set align(left)
      #set text(size: 10pt)
      
      Questo documento é una raccolta *personale* basata sulle lezioni e/o sui materiali didattici forniti dai docenti e/o raccolti negli anni dagli studenti. 

      #callout(title: "Disclaimer", color: red.darken(20%), icon: "❗️")[
        #text(style: "italic", fill: gray.darken(70%))[
        L'autore non si assume alcuna responsabilità per eventuali errori, omissioni o inesattezze contenuti in questo documento. Il materiale è fornito "così com'è" a solo scopo di supporto allo studio.
      ]]
      
      
      #v(1em)

      
      Se vuoi *aggiungere* materiale utile o *segnalarmi* errori o correzioni, fallo #link(contact_url)[#underline[qui]].
      
      #v(2em)
      #line(length: 100%, stroke: 0.5pt + gray.lighten(50%))
      #v(1em)
      
      #align(center)[
        Spero che queste risorse ti siano utili.\ Buono studio e in bocca al lupo! 🤞
        
        #v(1em)
        Se ti va di offrirmi una cioccolata🍫 puoi farlo #link(paypal_url)[#underline[qui]]. \
        #v(1em)
        #link(bento_url)[#box(fill: primary-cyan.lighten(80%), radius: 4pt, inset: 6pt)[*Bento*]]
      ]
    ]
  ])

  pagebreak(to: "odd")

  // --- INDICE ---
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  outline(indent: auto, depth: 3)
  
  pagebreak(to: "odd")

  // --- HEADER E FOOTER ---
  set page(
    header: context {
      if counter(page).get().first() > 2 {
        grid(
          columns: (0.1fr, 1fr, 1fr),
          align(left + bottom)[
            #if logo_subject != none { image(logo_subject, width: 12pt) } else { box() }
          ],
          align(left + horizon)[
            #set text(size: 9pt, fill: dark-bg)
            #title
          ],
          align(right + bottom)[
             #if logo_personal != none { image(logo_personal, width: 12pt) }
          ]
        )
        v(-5pt)
        line(length: 100%, stroke: 0.5pt + gray)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        align(center, counter(page).display())
      }
    }
  )

  set list(marker: ([•], [◦],[--]))

  body
}