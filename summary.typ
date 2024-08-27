#show math.equation: set text(blue)

#set text(font: "Microsoft Sans Serif")

#show heading.where(level: 1): set text(orange)

#show heading.where(level: 2): set text(purple)

#show heading.where(level: 3): set text(rgb(10, 150, 10))

#let AL = text("AL")


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
      $0, 1 in AL$,
      "Konstanten",
    ),
    (
      $V subset.eq AL$,
      "Variablen",
    ),
    (
      $text("Für alle") phi, psi in text("AL ist")$ + definition((
        (
          $(not psi) in AL$,
          "Negation",
        ),
        (
          $(phi and psi) in AL$,
          "Konjunktion",
        ),
        (
          $(phi or psi) in AL$,
          "Disjunktion",
        ),
        (
          $(phi arrow.r psi) in AL$,
          "Implikation",
        ),
        (
          $(phi arrow.l.r psi) in AL$,
          "Äquivalenz",
        ),
      )),
      "",
    ),
    (
      $AL$ + " ist die kleinste Menge, die die Eigenschaften 1., 2. und 3. erfüllt.",
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
- Ein echtes Präfix einer Formel liegt nicht in $AL$.
- Jede Formel beginnt mit $($ und endet mit $)$.

=== Eindeutigkeitssatz
Für jede Formel $phi$ ist atomar oder entsteht auf eindeutige Weise aus kürzeren Formeln.

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

== Semantische Folgerung
Die Formel $phi$ ist *logische Folgerung* von $Phi$, falls für jede Interpretation
$frak(I)$, die $Phi$ erfüllt, $phi^frak(I) = 1$ gilt.

=== Grundlegende semantische Folgerungen
+ $phi$ ist allgemeingültig genau dann, wenn $not phi$ widerspruchsvoll ist.
+ Es gilt $emptyset models phi$ genau dann, wenn $phi$ Tautologie ist, also $models phi$.
+ Ist $Phi$ nicht erfüllbar, dann gilt $Phi models phi$ für alle $phi in AL$.
+ Sei $Phi' subset.eq Phi$. Ist $Phi$ erfüllbar, dann ist auch $Phi'$ erfüllbar.
+ Es gilt $Phi models psi$ für alle $psi in Phi$.
+ Falls $Phi' subset.eq Phi$, dann impliziert $Psi' models phi$ auch $Psi models phi$.
+ Es gilt $Phi models phi$ genau dann, wenn $Phi union {not phi}$ nichr erfüllbar ist.
=== Entscheidbarkeit semantischer Fragen
+ Es ist entscheidbar, ob eine endliche Menge $Phi subset.eq AL$ erfüllbar ist.
+ Es ist entscheidbar, ob für eine gegebene endliche Menge $Phi subset.eq AL$ und ein $phi in AL$ gilt, dass $Phi models phi$.
+ Die Mengen $text("TAUT")$ und $text("SAT")$ sind entscheidbar.

=== Deduktionstheorem (semantische Version)
$Phi union {phi} models psi$ genau dann, wenn $Phi models (phi arrow.r psi)$ gilt.
=== Modus Ponens (semantische Version)
- Es gilt ${phi, phi models psi} models psi$

== Logische Äquivalenz
Formeln heißen *logisch äquivalent*, geschrieben $phi equiv psi$, falls für jede Belegung $frak(I)$ gilt: $phi^frak(I) = psi^frak(I)$.

=== Gesetze von De Morgan
- $not(phi and psi) equiv not phi or not psi$ und
- $(phi or psi) equiv not phi and not psi$.

=== Operatorenvermeidung
- $phi arrow.r psi equiv not phi or psi$,
- $phi arrow.l.r psi equiv (phi arrow.r psi) and (psi arrow.r phi)$,
- $phi or psi equiv not phi arrow.r psi$ und
- $phi and psi equiv not(phi arrow.r not psi)$.
Zu jeder Formel $phi$ gibt es äquivalente Formeln, die nur
+ $arrow.r$ und $not$ als Verknüpfungen enthält,
+ $and$ und $not$ als Verknüpfungen enthält und
+ $or$ und $not$ als Verknüpfungen enthält.

== Normalformen
Eine Normalform einer Formel $phi$ ist eine äquivalente Formel $T(phi)$, die gewissen Einschränkungen unterliegt.
- *Einschränkungen* können strukturell sein oder Eindeutigkeit erfordern.
- *Äquivalenz* kann bedeuten
  - logisch äquivalent: $phi equiv T(phi)$
  - erfüllbarkeitsäquivalent: $phi$ ist erfüllbar genau dann, wenn $T(phi)$ erfüllbar ist
- Für jede Formel existiert eine Formel in Normalform.
- Jede Formel in Normalform gehört zur Logik selbst.

=== Negationsnormalform
- Für $p in V$ sind $p$ und $not p$ in Negationsnormalform.
- Sind $phi, psi$ in Negationsnormalform, dann sind auch $(phi or psi)$ und $(phi and psi)$ in Negationsnormalform.
=== Konjunktive und Disjunktive Normalformen
- Eine Formel $phi$ heißt *Literal*, wenn $phi in V$ oder $phi = (not phi')$ mit $phi' in V$.
- Eine Formel $phi$ heißt *Klausel*, wenn $phi$ eine Disjunktion (Veroderung) von Literalen.
  - Hat eine Klausel höchstens höchstens $k$ Literale, heißt sie *k-Klausel*.
  - 1-Klauseln werden *Unit-Klauseln* genannt.
- Eine Formel $phi$ ist in *konjunktiver Normalform*, wenn $phi$ eine Konjunktion (Verundung) von Klauseln ist.

  - Analog: Eine Formel ist in *disjunktiver Normalform*, wenn sie eine Disjunktion (Veroderung) von Konjunktionen (Verundungen) ist.

Zu jeder Booleschen Funktion $f$ gibt es eine KNF-Formel mit $l$ Variablen der Länge $O(l 2^l)$
=== Konjunktive Normalform als Menge
- Da Konjunktionen und Disjunktionen assoziativ sind, ist die Reihenfolge der Literale in Klauseln und der Klauseln in einer Formel in KNF irrelevant.
  - Daher können wir Klauseln als *Mengen von Literalen* auffassen und KNF-Formeln als *Mengen von Klauseln*.
Beispiel: $(p or q) and (p or not q)$ wird zu ${{p,q}, {p,not q}}$.

= Der Kompaktheitssatz
Die Formelmenge $Phi$ ist genau dann erfüllbar, wenn jede *endliche* Teilemge von $Phi$ erfüllbar ist.
