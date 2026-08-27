#import "template.typ": FIT-Presentation, title-slide, slide, focus-slide, centered-slide, pause

#show: FIT-Presentation.with(
  language: "EN",
  presentation-title: "Presentation title",
  presentation-subtitle: "Some longer presentation subtitle",
  work-title: "HTML Signature Form Classifier",
  authors: (
    (name: "John Doe"),
    (name: "Johnny Moe"),
    (name: "Janice Foe"),
  )
)

#title-slide()

== Goal of the Work

Algorithms and implementation to solve this and that.

*Dataset:* PQR-100, BAC-23 \
*Required reliability:* 99 %

$
  bold(a)_t = sum_(i=1)^(L^*) alpha_(t,i) bold(f)_(t,i)
$

where $alpha_(t,i)$ computes the softmax:

$
  alpha_(t,i) = (exp(r_(t,i))) / (sum_(k=1)^L exp(r_(t,k))) \ \
  r_(t,i) = W_a tanh(W_h bold(h)_(t-1) + W_f bold(f)_(t,i) + b)
$

== Results

- Created dataset: 105k records
- Success rate: 103 %
  - 120 % when it goes well

#grid(columns: (1fr, 1fr))[
  *Left column*
  - Point one
  - Point two
][
  *Right column*
  - Point A
  - Point B
]

#centered-slide[Thank you for your attention!]

#bibliography(
  "sources.yaml",
  style: "ieee",
  full: true,
  title: [References],
)
