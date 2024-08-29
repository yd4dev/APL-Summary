#show math.equation: set text(blue)

#set text(font: "Arial")

#set page(footer: context [
  #align(center)[
    #counter(page).display(
      " - 1 / 1 -",
      both: true,
    )]
])

#show heading.where(level: 1): set text(orange)

#show heading.where(level: 2): set text(purple)

#show par: set block(spacing: 0.65em)
#set par(
  first-line-indent: 1em,
  justify: true,
)

#show heading.where(level: 3): set text(rgb(10, 150, 10))

#let AL = text("AL")

#let ar = text("ar")

#let FO = text("FO")


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
    columns: (1fr, auto),
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

#set heading(numbering: "1.")

#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline(depth: 2, indent: auto, title: "Inhalt")

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

= Kalküle und Algorithmen für die Aussagenlogik
== Deduktive Systeme und Kalküle
Ein *deduktives System* (auch *Beweiskalkül*) besteht aus Axiomen und Regeln, mit denen wir wahre Aussagen/Formeln ableiten (formal beweisen). \
Wir haben also zwei Möglichkeiten die Gültigkeit von Formeln zu prüfen:
- Durch Anwendung der Semantik.
- Durch Ableiten in einem deduktiven System.

Ein *deduktives System* $cal(F)$ besteht aus
#definition(
  (
    (
      $text("einem endlichen Alphabet ") Sigma text(",")$,
      " ",
    ),
    (
      $text("einer Formelmenge") F subset.eq Sigma^* text(",")$,
      "(wohlgeformte Formeln)",
    ),
    (
      $text("einer Menge von Axiomen") A x subset.eq F text("und")$,
      "(Axiome)",
    ),
    (
      $text("einer Menge") R subset.eq F^* text("von Regeln.")$,
      "(Regeln)",
    ),
  ),
  num: true,
)
Für eine Regel $r = (phi_1,dots,phi_n,phi) in R$ schreiben wir auch $frac(phi_1\,dots\,phi_n,phi)$. \
Die Formeln $phi_1,dots,phi_n$ heißen *Prämissen*, und die Formel $phi$ heißt *Konklusion* von $r$. \

Das System heißt *entscheidbar*, wenn die Mengen $F, A x$ und $R$ entscheidbar sind.

Ein deduktives System heißt
- *korrekt*, wenn alle herleitbaren Aussagen gültig sind, und
- *vollständig*, wenn alle gültigen Aussagen herleitbar sind.

=== Herleitbarkeit in Deduktiven Systemen
Die Menge $T(cal(F))$ der *Theoreme* des deduktiven Systems $cal(F)$ ist induktiv definiert durch:
#definition((
  (
    $A x subset.eq T(cal(F)).$,
    "(alle Axiome sind Theoreme)",
  ),
  (
    "Sind " + $phi_1,dots,phi_n in T(
        cal(F)
      )$ + " und ist " + $frac(phi_1\,dots\,phi_n,phi)$ + " in " + $R$ + ", dann ist " + $phi in T(cal(F))$ + ".",
    " ",
  ),
  (
    $T$ + " ist die kleinste Menge von Formeln, die 1 und 2 erfüllt.",
    " ",
  ),
))
Wir schreiben $tack.r \ _cal(F) phi$, falls $phi in T(cal(F))$, und sagen, $phi$ ist in $cal(F)$ herleitbar. \

=== Deduktiver Folgerungsbegriff
Sei $Phi subset.eq F, phi in F$.
Dann ist $phi$ in $cal(F)$ aus $Phi$ herleitbar, geschrieben $Phi tack.r\ _cal(F)phi$, falls $tack.r\ _((Sigma,F,A x union Phi, R)) phi$ gilt. \
Geht $cal(F)$ aus dem Kontext hervor, schreiben wir auch $tack.r\ _phi$ bzw. $Phi tack phi$.

=== Das deduktive System $cal(P)_2$
*Axiome*: \
Ax1: $A arrow.r (B arrow.r A)$ \
Ax2: $(A arrow.r (B arrow.r C)) arrow.r ((A arrow.r B) arrow.r (A arrow.r C))$ \
Ax3: $(not A arrow.r not B) arrow.r (B arrow.r A)$ \
*Regeln*: \
MP: $frac(A\,(A arrow.r B), B)$ (modus ponens)

Das System $cal(P)_2$ ist korrekt und vollständig.

=== Der Sequenzenkalkül
Sei $F$ eine Menge von Formeln. \
Eine *Sequenz* ist ein Paar $(Gamma, Delta)$, geschrieben $Gamma arrow.double\ _G Delta$, wobei $Gamma,Delta subset.eq F$ endliche Mengen sind. \

Die Sequenz ${phi_1,dots,phi_n} arrow.double\ _G {psi_1,dots,psi_m}$ entspricht semantisch $(phi_1 and dots and phi_n) arrow.r (psi_1 or dots or psi_m)$

Die Menge der *Sequenzen* bezeichnen wir mit $F_G$.



Axiome
#grid(
  columns: (1fr, 1fr, 1fr),
  align: center,
  [
    (Ax)$frac("",Gamma\, A arrow.double\ _G A\, Delta)$
  ],
  [
    (0-Ax)$frac("",Gamma\,0 arrow.double\ _G Delta)$
  ],
  [
    (1-Ax)$frac("",Gamma arrow.double\ _G 1\, Delta)$
  ],
)
Regeln
#grid(
  columns: (1fr, 1fr),
  align: center,
  [
    $
      &(L_not) &&frac(Gamma arrow.double\ _G A\, Delta,Gamma\, not A arrow.double\ _G Delta) \
      &(L_and) &&frac(Gamma\, A\, B arrow.double\ _G Delta, Gamma\, A and B arrow.double\ _G Delta) \
      &(
        L_or
      ) &&frac(Gamma\, A arrow.double\ _G Delta\;space.quad Gamma\, B arrow.double\ _G Delta, Gamma\,A or B arrow.double\ _G Delta) \
      &(
        L_arrow.r
      ) &&frac(Gamma arrow.double\ _G A\,Delta\; space.quad Gamma\, B arrow.double\ _G Delta, Gamma\, A arrow.r B arrow.double\ _G Delta)
    $

  ],
  [
    $
      &(R_not) &&frac(Gamma\, A arrow.double\ _G Delta,Gamma arrow.double\ _G not A\,  Delta) \
      &(
        R_and
      ) &&frac(Gamma arrow.double\ _G A\, Delta\; space.quad Gamma arrow.double\ _G B\, Delta, Gamma arrow.double\ _G A and B\, Delta) \
      &(R_or) &&frac(Gamma arrow.double\ _G A\, B\, Delta, Gamma arrow.double\ _G A or B\, Delta) \
      &(R_arrow.r) &&frac(Gamma\, A arrow.double\ _G Delta\,B, Gamma arrow.double\ _G A arrow.r B\, Delta)
    $
  ],
)

=== Die Schnittregel im Sequenzenkalkül
#align(center)[
  $
    frac(Gamma arrow.double\ _G A\,Delta\; space.quad Gamma'\, A arrow.double\ _G Delta', Gamma\,Gamma' arrow.double\ _G Delta\, Delta') text(" (Cut)")
  $
]
Da der Kalkül vollständig ist und die Schnittregel gültig, sind alle Sequenzen, die mit
Schnittregel herleitbar sind, auch ohne Schnittregel herleitbar (wenn möglicherweise auch nur
deutlich umständlicher).

=== Resolution
Resolution ist ein Beweiskalkül, mit dem wir die Unerfüllbarkeit von Formeln in konjunktiver Normalform nachweisen können. \
Kann die *leere Klausel* $union.sq$ abgeleitet werden, dann ist die ursprüngliche Klauselmenge nicht erfüllbar.

Für zwei Klauseln $phi_1, phi_2$ und eine Variable $p_i in V$ heißt die Klausel $phi = (phi_1 \\ {p_i}) union (phi_2 \\ {not p_i})$ die *Resolvente* von $phi_1$ und $phi_2$ nach $p_i$.

Die einzige *Regel im Resolutionskalkül* ist wie folgt:
- Aus zwei Klauseln können wir deren Resolvente (nach einem beliebigen $p_i$) ableiten.

=== Horn-Klauseln
- Eine Klausel ist *positiv*, wenn sie eine Disjunktion von positiven Literalen ist.
- Eine Klausel ist *negativ*, wenn sie eine Disjunktion von negativen Literalen ist.
- Eine *Horn-Klausel* ist eine Klausel mit höchstens einem positiven Literal

=== Der DPLL-Algorithmus
*Substitution*: Einsetzen eines Wahrheitswertes in eine Formel

*DPLL-Algorithmus*:
- rekursiver Algorithmus für SAT
- Erfüllbarkeit von $phi$ wird zurückgeführt auf Erfüllbarkeit von $phi[p arrow.r.bar 0]$ und $phi[p arrow.bar.r 1]$.

= Prädikatenlogik
Erweitert die Aussagenlogik durch
- Funktionen und Konstanten
- Prädikate und Relationen
- Quantoren

=== Terme
Terme beschreiben *Elemente des Datenbereichs* und bestehen aus
- Konstanten,
- Variablen und
- Funktionen.

=== Formeln
Formeln treffen *Aussagen über Elemente des Datenbereichs* und werden gebildet aus
- Termen,
- Prädikaten / Relationen,
- logischen Junktoren und
- Quantoren.

== Signaturen und Strukturen
- Eine *Struktur* beschreibt:\ eine Menge zusammen mit Operationen oder Beziehungen auf der Menge.
- Eine *Signatur* legt fest, welche Art von Konstanten, Funktionen und Relationen bei den Strukturen von Interesse vorkommen sollen.

=== Signaturen
Eine Signatur ist ein 4-Tupel $S = (cal(C), cal(F), cal(R), ar)$, wobei
#definition((
  ($cal(C)$ + " eine Menge ist,", "Konstanten"),
  ($cal(F)$ + " eine Menge ist,", "Funktionssymbole"),
  ($cal(R)$ + " eine Menge ist und", "Relationssymbole/Prädikatssymbole"),
  ($ar: cal(F) union cal(R) arrow.r NN_(gt 0)$ + " eine Abbildung ist", "Arität / Stelligkeit"),
))
Hierbei verlangen wir, dass die Mengen $cal(C), cal(F) text("und") cal(R)$ disjunkt sind.
- Eine Funktion $f$ ist *$n$-stellig* und hat *Arität* $n$, wenn $ar(f) = n$ gilt.
- Eine Funktion $R$ ist *$n$-stellig* und hat *Arität* $n$, wenn $ar(R) = n$ gilt.
*Zusatzvoraussetzungen für die Prädikatenlogik*:
- Es gibt eine Variablenmenge $V$.
- Die Symbole $cal(C), cal(F)$ und $cal(R)$ kommen nicht in der Variablenmenge $V$ und nicht in der Menge ${not, and, or, arrow.r, arrow.l.r, exists, forall, =, (,)}$ vor.

=== Strukturen zu Signaturen
Sei $S = (cal(C), cal(F), cal(R), ar)$ eine Signatur. Eine *Struktur der Signatur $S$* auch ($S$-Struktur) ist ein Paar $cal(A) = (A,frak(a))$ bestehend aus
- einer nicht-leeren Menge $A$, dem *Träger* (auch *Trägermenge* oder *Datenbereich*), und
- einer Funktion $frak(a)$, genannt *Interpretation der Symbole*, die
  - jedem Konstantensymbol $c in cal(C)$ ein Element $frak(a)(c) in A$ zuordnet,
  - jedem Funktionssymbol $f in cal(F)$ eine Funktion $frak(a)(f): A^(ar(f)) arrow.r A$ zuorndet und
  - jedem Relationssymbol $R in cal(R)$ eine Relation $frak(a)(R) subset.eq A^(ar(R))$ zuordnet.
Wir schreiben auch jeweils $c^cal(A), f^cal(A), R^cal(A)$ statt $frak(a)(c), frak(a)(f), frak(a)(R)$.

=== Vereinfachte Sprech- und Schreibweisen
- Wir werden auch einfach von Strukturen sprechen, wenn aus dem Kontext klar wird, dass es sich um $S$-Strukturen für eine bestimmte Signatur $S$ handelt.
  - Wir schreiben für eine Signatur $ S = ({c_1,dots,c_(|cal(C)|)},{f_1,dots,f_(|cal(F)|)},{r_1,dots,r_(|cal(R)|)}, ar)$ auch einfach
  - $S = (c_1,dots,c_(|cal(C)|), f_1,dots,f_(|cal(F)|),r_1,dots,r_(|cal(R)|)$,
  wenn die Aufteilung auf Konstanten, Funktionen und Relationen sowie die Aritäten aus dem Kontext klar werden.
- Ebenso schreiben wir eine Struktur
  - $cal(A) = (A, frak(a))$ auch vereinfacht als
  - $cal(A) = (A, c_1^cal(A),dots,c_(|cal(C)|)^cal(A), f_1^cal(A),dots,f_(|cal(F)|)^cal(A),R_1^cal(A),dots,R_(|cal(R)|)^cal(A)$,
  wenn dadurch keine Verwechselungen entstehen können.

== Syntax
=== Terme
Für eine Signatur $S = (cal(C), cal(F), cal(R), a r)$ ist die Menge der $S"-Terme"$, geschrieben $T(S)$, induktiv definiert:
#definition(
  (
    ($c in T(S)$ + " für alle Konstanten " + $c in cal(C)$ + ",", "Konstanten"),
    ($v in T(S)$ + " für alle Variablen " + $v in V$ + " und", "Variablen"),
    (
      $f(t_1,dots,t_(ar(f))) in T(S)$ + " für alle " + $f in cal(F)$ + " und Terme " + $t_1,dots,t_(ar(f)) in T(
          S
        )$ + ".",
      "Funktionen",
    ),
    ($T(S)$ + " ist die kleinste Menge, die die Eigenschaften 1., 2. und 3. erfüllt.", ""),
  ),
  num: true,
)
=== Vorkommende Variablen
Die Menge der *vorkommenden Variablen $"var"(t)$* für einen Term $t in T(S)$ ist folgendermaßen induktiv definiert:
+ $"var"(t) = {}$, falls $t = c$ für ein $c in cal(C)$,
+ $"var"(t) = {p}$, falls $t = p$ für ein $p in V$, und
+ $"var"(t) = "var"(t_1) union dots union "var"(t_(a r(f)))$, falls $t = f(t_1, dots, t_(a r(f)))$.