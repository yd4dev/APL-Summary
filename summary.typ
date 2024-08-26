#show math.equation: set text(blue)

#set text(font: "Microsoft Sans Serif")

#show heading.where(level: 1): set text(orange)

#show heading.where(level: 2): set text(purple)

#show heading.where(level: 3): set text(rgb(10, 150, 10))


#let name(body) = {
  set text(red)
  set align(right)
  [*#body*]
}

#let definition(arr, num: false) = {
  let l = ()
  let r = ()

  for entry in arr [
    #l.push(entry.at(0)))
    #r.push(entry.at(1))
  ]

  let l_index = 1

  return grid(
    columns: (1fr, 1fr),
    rows: (auto),
    align(left)[
      #for entry in l [
        #if num [
          #enum(entry, start: l_index)
          #(l_index = l_index + 1)] else [
          #list(entry)
        ]

      ]
    ],
    align(right)[
      #for entry in r [
        #name(entry)
      ]
    ],
  )
}

= Logik
== Komponenten
- *Syntax*: Definiert die Form und Struktur logischer Ausdrücke. einschließlich der Regeln zum Bilden gültiger Aussagen.
- *Semantik*: Legt die Bedeutung der Aussagen fest und wie diese Ausdrücke interpretiert werden sollen.
- *Deduktives System/Beweiskalkül*: Beschreibt die Methoden und Regeln, mit denen aus wahren Aussagen weitere wahre Aussagen abgeleitet oder bewiesen werden können.

== Eigenschaften
- *Ausdrucksstärke*: Welche Aussagen lassen sich in der Logik ausdrücken?
- *Korrektheit*: Sind alle in einem deduktiven System der Logik beweisbaren Aussagen der Logik wahr?
- *Vollständigkeit*: Sind alle wahren Aussagen in einem deduktiven System der Logik beweisbar?
- *Entscheidbarkeit*: Können wir mit einem Algorithmus feststellen, ob eine Aussage wahr ist?
- *Automatisierbarkeit*: Was können wir automatisieren?

= Aussagenlogik
Ermöglicht Formalisierung von Argumenten. Grundlage für Boolesche Algebra und Schaltkreise. Mögliche Anwendung: Software-Verifikation, Datenbanken, KI.
== Syntax
#definition((
  (
    $V := {p_1, p_2, ...}$,
    "Aussagenvariablen",
  ),
  (
    $O := {not,and,or,arrow.r,arrow.l.r}$,
    "Junktoren",
  ),
  (
    $K := {(,)}$,
    "Klammern",
  ),
  (
    $Sigma := {0, 1} union V union O union K$,
    "Alphabet",
  ),
))


Die *Formeln* (Aussagen) sind folgendermaßen definiert:
#definition(
  (
    (
      $0, 1 in text("AL")$,
      "Konstanten",
    ),
    (
      $V subset.eq text("AL")$,
      "Variablen",
    ),
    (
      $text("Für alle") phi, psi in text("AL ist")$ + definition((
        (
          $(not psi) in text("AL")$,
          "Negation",
        ),
        (
          $(phi and psi) in text("AL")$,
          "Konjunktion",
        ),
        (
          $(phi or psi) in text("AL")$,
          "Disjunktion",
        ),
        (
          $(phi arrow.r psi) in text("AL")$,
          "Implikation",
        ),
        (
          $(phi arrow.l.r psi) in text("AL")$,
          "Äquivalenz",
        ),
      )),
      "",
    ),
    (
      $text("AL")$ + " ist die kleinste Menge, die die Eigenschaften 1., 2. und 3. erfüllt.",
      "",
    ),
  ),
  num: true,
)

#pagebreak()

=== Klammerbalancierung
$\#_a (w)$ ist die Anzahl $a$ in $w$.

+ Jedes echte nicht-leere Präfix $psi$ einer Formel hat mehr öffnende als schließende Klammern: $\#_(\() (psi)> \#_(\)) (psi)$.
+ Alle Formeln haben gleich viele öffnende wie schließende Klammern: $\#_(\() (psi)= \#_(\)) (psi)$.

Daraus folgt:
- Ein echtes Präfix einer Formel liegt nicht in $text("AL")$.
- Jede Formel beginnt mit $($ und endet mit $)$.

=== Eindeutigkeitssatz
Für jede Formel $phi$ gilt genau eine der folgenden Eigenschaften:
+ $phi$ ist atomar,
+ $phi = (not phi_1)$ für ein $phi_1 in text("AL")$ oder
+ $phi = (phi_1 circle.small phi_2)$ für ein $circle.small in {and, or, arrow.r, arrow.l.r}$ und $phi_1, phi_2 in text("AL")$.

=== Klammern weglassen
Um Formeln wie $((not phi) or ((not psi) and (not phi)))$ zu vermeiden, lassen wir Klammern weg. \
Dabei gilt folgende Operatorenpräzedenz in absteigender Reihenfolge:
+ $not$
+ $and$
+ $or$
+ $arrow.r$
+ $arrow.r.l$
Bei aufeinander folgenden $and$ oder $or$ von links nach rechts.

== Semantik
Die Semantik einer Logik ordnet den Formeln eine Bedeutung zu. \
Um den Wahrheitswert von Formeln zu bestimmen, definieren wir unsere Aussagenvariablen $BB := {0, 1}$ als die Menge der *Booleschen Konstanten*.

=== Interpretationen (Belegungen)
Eine Belegung der Variablen bezeichnen wir mit $frak("I")$.

Mit dieser Belegung definieren wir die Semantik der Aussagenlogik wie folgt:

#align(center)[
  $
    &0^J &&:= 0\
    &1^J &&:= 1\
    &p_i^frak(I) &&:= J(p_i) \
    &(not phi)^frak(I) &&:= 1 - phi^frak(I) \
    &(phi or psi)^frak(I) &&:= max(phi^frak(I), psi^frak(I)) \
    &(phi and psi)^frak(I) &&:= min(phi^frak(I), psi^frak(I)) \
    &(phi arrow.r psi)^frak(I) &&:= (not phi or psi)^frak(I) \
    &(phi arrow.r.l psi)^frak(I) &&:= ((phi and psi) or (not phi and not psi))^frak(I)
  $
]
#pagebreak()
=== Modell
Eine Interpretation $frak(I)$ einer Formel $phi$ mit $phi^frak(I) = 1$.

#grid(
  columns: (1fr, 1fr, 1fr),
  [
    Schreibweisen: \
    #definition((
      (
        $frak(I) models phi$,
        "Modell",
      ),
      (
        $frak(I) cancel(models) phi$,
        "Kein Modell",
      ),
    ))
  ],
  [],
  [
    Sprechweisen: \
    Gilt $frak(I) models phi$ so sagen wir:
    - $frak(I)$ erfüllt $phi$,
    - $frak(I)$ erfüllt $phi$,
    - $phi$ ist wahr unter $frak(I)$.
  ],
)
=== Irrelevanz nicht vorkommender Variablen (Koinzidenzlemma)
Der Wahrheitswert einer Formel $phi$ hängt nur von der Belegung der in $phi$ vorkommenden Variablen ab.
- Wir müssen daher nur endlich viele Belegungen prüfen, um die möglichen Wahrheitswerte zu bestimmen.
- Zum Beispiel alle Belegungen, bei denen nicht vorkommende Variablen = 0 sind.

Notation:
- Wir schreiben $phi(p_1,dots,p_t)$, um anzudeuten, dass die Variablen ${p_1,dots,p_t}$ in der Formel $phi$ vorkommen.
=== Erfüllbarkeit, Tautologien und Widersprüchlichkeit
+ Eine Formel $phi$ heißt *Tautologie* (oder *allgemeingültig*), geschrieben $models phi$, falls $phi^frak(I) = 1$, falls $phi^frak(I) = 1$ für jede Belegung $frak(I)$.
+ $phi$ heißt *erfüllbar*, falls es eine Belegung $frak(I)$ gibt mit $phi^frak(I) = 1$.
+ $phi$ heißt *widerspruchsvoll* (oder *widersprüchlich*), falls $phi^frak(I) = 0$ für jede Belegung $frak(I)$.

Selbiges gilt für Mengen von Formeln $Phi$. \
Die *Menge der Tautologien TAUT* ist eine Teilmenge von *SAT, der Menge aller erfüllbaren Formeln*. TAUT $subset.eq$ SAT.
