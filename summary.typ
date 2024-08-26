#show math.equation: set text(blue)

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
