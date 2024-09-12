#show math.equation: set text(blue)

#set text(font: "Archivo")

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
      $text("Wenn") phi, psi in AL text("dann")$ + definition((
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
  ),
  num: true,
)

=== Klammerbalancierung
+ Jedes echte nicht-leere Präfix $psi$ einer Formel hat mehr öffnende als schließende Klammern: $\#_(\() (psi)> \#_(\)) (psi)$.
+ Alle Formeln haben gleich viele öffnende wie schließende Klammern: $\#_(\() (psi)= \#_(\)) (psi)$.

Daraus folgt:
- Ein echtes Präfix einer Formel liegt nicht in $AL$.
- Jede Formel beginnt mit $($ und endet mit $)$.

=== Eindeutigkeitssatz
Jede Formel $phi$ ist atomar oder entsteht auf eindeutige Weise aus kürzeren Formeln.

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
Eine Belegung der Variablen bezeichnen wir mit $frak(I): V arrow.r BB$. \
Dadurch erhält $phi^frak(I)$ einen offensichtlichen Wahrheitswert in $BB$.

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
    - $frak(I)$ ist Modell von $phi$,
    - $phi$ ist wahr unter $frak(I)$.
  ],
)
=== Irrelevanz nicht vorkommender Variablen (Koinzidenzlemma)
Der Wahrheitswert einer Formel $phi$ hängt nur von der Belegung der in $phi$ vorkommenden Variablen ab.
- Wir schreiben $phi(p_1,dots,p_t)$, um anzudeuten, dass die Variablen ${p_1,dots,p_t}$ in der Formel $phi$ vorkommen.
=== Erfüllbarkeit, Tautologien und Widersprüchlichkeit
+ Eine Formel $phi$ heißt *Tautologie* (oder *allgemeingültig*), geschrieben $models phi$, falls $phi^frak(I) = 1$, falls $phi^frak(I) = 1$ für jede Belegung $frak(I)$.
+ $phi$ heißt *erfüllbar*, falls es eine Belegung $frak(I)$ gibt mit $phi^frak(I) = 1$.
+ $phi$ heißt *widerspruchsvoll* (oder *widersprüchlich*), falls $phi^frak(I) = 0$ für jede Belegung $frak(I)$.

Selbiges gilt für Mengen von Formeln $Phi$. \
Die *Menge der Tautologien TAUT* ist eine Teilmenge von *SAT, der Menge aller erfüllbaren Formeln*. TAUT $subset.eq$ SAT.

== Semantische Folgerung
Die Formel $phi$ ist *logische Folgerung* von $Phi$, falls für jede Interpretation
$frak(I)$, die $Phi$ erfüllt, $phi^frak(I) = 1$ gilt. Wir schreiben $Phi models phi$.

=== Entscheidbarkeit semantischer Fragen
+ Es ist entscheidbar, ob eine endliche Menge $Phi subset.eq AL$ erfüllbar ist.
+ Es ist entscheidbar, ob für eine gegebene endliche Menge $Phi subset.eq AL$ und ein $phi in AL$ gilt, dass $Phi models phi$.
+ Die Mengen $text("TAUT")$ und $text("SAT")$ sind entscheidbar.

=== Deduktionstheorem (semantische Version)
- $Phi union {phi} models psi$ genau dann, wenn $Phi models (phi arrow.r psi)$ gilt.
=== Modus Ponens (semantische Version)
- ${phi, phi arrow.r psi} models psi$

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
- *Literal*: Variable oder negierte Variable
- *Klausel*: Disjunktion von Literalen.
  - Hat eine Klausel höchstens höchstens $k$ Literale, heißt sie *k-Klausel*.
  - 1-Klauseln werden *Unit-Klauseln* genannt.
- Eine Formel $phi$ ist in *konjunktiver Normalform*, wenn $phi$ eine Konjunktion von Klauseln ist.

  - Analog: Eine Formel ist in *disjunktiver Normalform*, wenn sie eine Disjunktion von Konjunktionen ist.
=== Konjunktive Normalform als Menge
- Da Konjunktionen und Disjunktionen assoziativ sind, ist die Reihenfolge der Literale in Klauseln und der Klauseln in einer Formel in KNF irrelevant.
  - Daher können wir Klauseln als *Mengen von Literalen* auffassen und KNF-Formeln als *Mengen von Klauseln*.
Beispiel: $(p or q) and (p or not q)$ wird zu ${{p,q}, {p,not q}}$.

= Der Kompaktheitssatz
Die Formelmenge $Phi$ ist genau dann erfüllbar, wenn jede *endliche* Teilemge von $Phi$ erfüllbar ist.

= Kalküle und Algorithmen für die Aussagenlogik
== Deduktive Systeme und Kalküle
Ein *deduktives System* (auch *Beweiskalkül*) besteht aus Axiomen und Regeln, mit denen wir wahre Aussagen/Formeln ableiten (formal beweisen). \ \
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
Die Formeln $phi_1,dots,phi_n$ heißen *Prämissen*, und die Formel $phi$ heißt *Konklusion* von $r$. \

Das System heißt *entscheidbar*, wenn die Mengen $F, A x$ und $R$ entscheidbar sind.

Ein deduktives System heißt
- *korrekt*, wenn alle herleitbaren Aussagen gültig sind, und
- *vollständig*, wenn alle gültigen Aussagen herleitbar sind.
Für eine Regel $r = (phi_1,dots,phi_n,phi) in R$ schreiben wir auch $frac(phi_1\,dots\,phi_n,phi)$.

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
MP: $frac(A\,(A arrow.r B), B)$ (modus ponens) \ \
Das System $cal(P)_2$ ist korrekt und vollständig.

=== Der Sequenzenkalkül
Sei $F$ eine Menge von Formeln. \
Eine *Sequenz* ist ein Paar $(Gamma, Delta)$, geschrieben $Gamma arrow.double\ _G Delta$, wobei $Gamma,Delta subset.eq F$ endliche Mengen sind. \
Die Sequenz ${phi_1,dots,phi_n} arrow.double\ _G {psi_1,dots,psi_m}$ entspricht semantisch $(phi_1 and dots and phi_n) arrow.r (psi_1 or dots or psi_m)$ \
Die Menge der *Sequenzen* bezeichnen wir mit $F_G$. \
*Axiome*
#grid(
  columns: (1fr, 1fr, 1fr),
  align: center,
  [
    $(A x) frac("",Gamma\, A arrow.double\ _G A\, Delta)$
  ],
  [
    $(0-A x)frac("",Gamma\,0 arrow.double\ _G Delta)$
  ],
  [
    $(1-A x)frac("",Gamma arrow.double\ _G 1\, Delta)$
  ],
)
*Regeln*
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
Kann die *leere Klausel* $union.sq$ abgeleitet werden, dann ist die ursprüngliche Klauselmenge nicht erfüllbar. \
Für zwei Klauseln $phi_1, phi_2$ und eine Variable $p_i in V$ heißt die Klausel $phi = (phi_1 \\ {p_i}) union (phi_2 \\ {not p_i})$ die *Resolvente* von $phi_1$ und $phi_2$ nach $p_i$.

Die einzige *Regel im Resolutionskalkül* ist wie folgt:
- Aus zwei Klauseln können wir deren Resolvente (nach einem beliebigen $p_i$) ableiten.

=== Horn-Klauseln
- Eine Klausel ist *positiv*, wenn sie eine Disjunktion von positiven Literalen ist.
- Eine Klausel ist *negativ*, wenn sie eine Disjunktion von negativen Literalen ist.
- Eine *Horn-Klausel* ist eine Klausel mit höchstens einem positiven Literal

=== Der DPLL-Algorithmus
*Substitution*: Einsetzen eines Wahrheitswertes in eine Formel \
*DPLL-Algorithmus*:
- rekursiver Algorithmus für SAT
- Erfüllbarkeit von $phi$ wird zurückgeführt auf Erfüllbarkeit von $phi[p arrow.r.bar 0]$ und $phi[p arrow.bar.r 1]$.

= Prädikatenlogik
Erweitert die Aussagenlogik durch
- Funktionen und Konstanten
- Prädikate und Relationen
- Quantoren

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
Für eine Signatur $S = (cal(C), cal(F), cal(R), ar)$ existiert die Menge der $S"-Terme"$, geschrieben $T(S)$. \
Ein Term wird gebildet aus *Variablen*, *Konstanten* und *Funktionen*. \ \
*Beispiele* für die Signatur $S = ({e}, {circle.small},{},ar)$ mit $ar(circle.small) = 2$:
#grid(
  columns: (1fr, 1fr, 1fr),
  [- $e$], [- $x_1$], [- $circle.small(x_1, circle.small(e, x_1))$],
)


=== Formeln
Für eine Signatur $S = (cal(C), cal(F), cal(R), ar)$ existiert die Menge der *S-Formeln der Logik erster Stufe*, geschrieben $FO(S)$. \
Eine *atomare Formel* wird gebildet aus *Termen* mit *Relationen und Gleichheit*:
#grid(
  columns: (1fr, 1fr, 1fr),
  [- $x tilde y$], [- $R(x_1,x_2,x_3)$], [- $x = y$],
)
Eine *Formel* beinhaltet zusätzlich *logische Junktoren* und *Quantoren*:
#grid(
  columns: (1fr, 3fr),
  [- $forall x. exists y. x > y$],
  [- $forall epsilon. exists delta. (epsilon > 0 and delta > 0) arrow.r (
          forall x. |x - x_0| lt.eq delta arrow.r |f(x) - f(x_0)| lt.eq epsilon
        )$],
)

=== Vorkommende, freie und gebundene Variablen
Die Menge der *vorkommenden Variablen $"var"(t)$* ($"var"(phi)$) für einen Term $t$ (Formel $phi$) ist die Menge der $p in V$, die in $t$ ($phi$) vorkommen.\
Die Menge $"free"(phi)$ einer Formel $phi$ beinhaltet alle freien Variablen, also jene vor denen kein Quantor steht.\
Die Menge $"bound"(phi)$ einer Formel $phi$ beinhaltet alle Variablen, vor denen ein Quantor steht.\
Es gilt: $"var"(phi) = "free"(phi) union "bound"(phi)$.\
Formeln die keine freien Variablen haben, heißen *abgeschlossen*.

=== Eindeutigkeitssatz
- Jeder Term und jede atomare Formel lässt sich *eindeutig* aus Teiltermen bilden.
- Jede nicht-atomare Formel lässt sich *eindeutig* aus Teilformeln bilden.

=== Notationen
#grid(
  columns: (1fr, 1fr),
  [
    *Präfixnotation* \
    Beispiele:
    - $f x y z$ steht für $f(x, y, z)$, wobei $ar(f) = 3$.
    - $+a+b c$ steht für $(a+(b+c))$.
    - $++a b c$ steht für $((a+b) +c)$.
    - $R a b$ steht für $(a,b) in R$.
  ],
  [
    *Infix-Notation* \
    Beispiele:
    - $a f b$ steht für $f(a,b)$ (falls $ar(f) = 2$).
    - $a R b$ steht für $(a,b) in R$.
  ],
)

*Weitere Konventionen*:
Wir legen fest, dass die aussagenlogischen Operatoren stärker binden als $exists$ und $forall$. \
Direkt aufeinanderfolgende gleiche Quantoren können wir ausfallen lassen.
- Die Zeichenfolge $forall x_1x_2x_3.phi$ steht für die Formel $forall x_1.forall x_2.forall x_3.phi$.

=== Quantorenrang
Misst die Schachtelungstiefe der Quantoren der Formel.\
- $"qr"((exists x.(not x = y arrow.r forall z.x > z)) or (exists x.x > y)) = 2$.

== Semantik
=== Belegung
Eine *Belegung* in einer Struktur $cal(A) = (A, frak(a))$ ist eine Abbildung $beta: V arrow.r A$. \
Die *Menge aller Belegungen* wird mit $A^V$ bezeichnet.
=== Interpretation
Für eine Signatur $S$ ist eine *$S$-Interpretation* ein Paar $frak(I) = (cal(A), beta)$ bestehend aus einer $S$-Struktur $cal(A)$ und einer Belegung $beta$ in $cal(A)$.
=== Semantik von Termen
Sei $S = (cal(C), cal(F), cal(R), ar)$ eine Signatur und $frak(I) = (cal(A), beta)$ eine *$S$-Interpretation* (bestehend aus einer $S$-Struktur $cal(A) = (A, frak(a))$ und einer Belegung $beta$). \
Die *Semantik* $t^frak(I) in A$ eines Terms $t in T(S)$ ist folgendermaßen definiert:
$
  c^frak(I) &:= c^cal(A) &&"für " t = c in cal(C)\
  x^frak(I) &:= beta(x) &&"für " t = x in V\
  f(t_1,dots,t_(ar(f)))^frak(I) &:= f^cal(A)(t_1^frak(I),dots,t_(ar(f))^frak(I)) &&"für " t = f(
    t_1,dots,t_(ar(f))
  ) "mit" f in cal(F).
$
=== Semantik von Formeln
*Modifikation*:
$
  beta[x arrow.bar a](y) := brace &a, &&"falls" y = x \
  &beta(y), space.quad &&"sonst".
$

*Semantik von Formeln*:\
Die Semantik $phi^frak(I) in BB$ einer Formel $phi in FO(S)$ für eine Signatur $S = (cal(C), cal(F), cal(R), ar)$ und eine $S$-Interpretation $frak(I) = (cal(A), beta)$ ist intuitiv gibt $phi$ intuitiv einen Wahrheitswert.\
Beispiel:\
Wir betrachten die Formel $ forall a. exists b. 2 dot b = a. $
- Die Formel ist mit einer Interpretation der natürlichen Zahlen und der üblichen Multiplikation nicht erfüllt.
- Über den rationalen Zahlen ist sie mit der üblichen Multiplikation erfüllt.

=== Irrelevanz nicht-freier Variablen
*Koinzidenzlemma*

=== Notation für relevante Variablen
- Wir schreiben $t(x_1,dots,x_n)$, um anzudeuten, dass ${x_1,dots,x_n} supset.eq "var"(t)$ für einen Term $t in T(S)$.
- Wir schreiben $phi(x_1,dots,x_n)$, um anzudeuten, dass ${x_1,dots,x_n} supset.eq "free"(phi)$ für eine Formel $phi in FO(S)$.

=== Die Modellbeziehung
Ein *Modell* einer Formel $phi in FO(S)$ ist eine $S$-Interpretation $frak(I)$ mit $phi^frak(I) = 1$.\
$frak(I) models phi$

== Semantische Folgerung und Äquivalenz
=== Semantischer Folgerungsbegriff
Die Formel $phi$ ist *logische Folgerung* der Formelmenge $Phi$, falls für jede $S$-Interpretation $frak(I)$, die $Phi$ erfüllt, $phi^frak(I) = 1$ gilt.
Wir schreiben $Phi models phi$.
=== Logische Äquivalenz
Formeln $phi, psi in FO(S)$ heißen *logisch äquivalent*, geschrieben $phi equiv psi$, wenn $phi models psi$ und $psi models phi$ gelten.

=== Vertauschung von Quantoren
$
  &"Für jede Formel gilt" &&exists x forall y phi models forall y exists x phi.\
  &"Es gibt Formeln für die gilt" space.quad space.quad &&forall x exists y phi cancel(models) exists y forall x phi.
$

== Substitution
Mit einer simultanen Substitution $[x_1 arrow.r.bar t_1, dots, x_r arrow.r.bar t_r]$ ersetzen wir freie Vorkommnisse von Variablen $x_1,dots,x_r$ jeweils durch Terme $t_1, dots, t_r$. \
Wir betrachten zuerst die Substitution in Termen.\
*Beispiel*:
$
  &"Es ist" f(x_1,x_2)[x_2 arrow.bar x_3] &&"gleich" f(x_1,x_3)\
  &"Es ist" (x+y)\/c [x arrow.bar y, y arrow.bar c dot x] space.quad &&"gleich" (y+c dot x)\/c
$

=== Substitution in Formeln
Um innerhalb des Geltungsbereichs eines Quantors zu substituieren, benennen wir (falls nötig) erst die gebundene Variable $x$ zu einer Variable $u$ um, die nicht vorkommt, und substituieren dann.

= Normalformen
== Pränexnormalform
Eine Formel ist *bereinigt*, wenn
- keine Variable sowohl frei als auch gebunden vorkommt und
- jede Variable höchstens einmal gebunden wird.\
In der *Pränexnormalform* stehen Quantoren am Anfang der Formel (also möglichst weit außen).\
Eine Formel ist in *bereinigter Pränexnormalform (BPF)*, wenn sie in Pränexnormalform und bereinigt ist.

== Skolemnormalform
Für unsere nächste Normalform werden wir keine logische Äquivalenz verlangen, sondern nur Erfüllbarkeitsäquivalenz.

Zwei Formeln heißen *erfüllbarkeitsäquivalent*, wenn beide erfüllbar sind oder keine der Formeln
erfüllbar ist.\
\
=== Skolemisierung
Ziel: existenzielle Quantoren in einer Formel eliminieren
- Wir werden von der neuen Formel nur *Erfüllbarkeitsäquivalenz* verlangen.
- Wir werden die Signatur erweitern.
Die Ersetzung existenzieller Quantoren durch neue Funktionssymbole heißt *Skolemisierung*.
\ \
=== Skolemform
Folgender Algorithmus berechnet eine Skolemform einer Formel in Pränexnormalform, indem
die Existenzquantoren von vorne nach hinten ersetzt werden.\
*Input*: Eine Formel $phi$ in bereinigter Pränexnormalform.\
*Output*: Eine erfüllbarkeitsäquivalente Formel in Skolemform.\ \
1: *while* $phi$ enthält Existenzquantoren *do*\
2: $space.quad$ Zerlege $phi = forall y_1 dots forall y_n exists z.psi$. \// möglicherweise n = 0\
3: $space.quad$ Sei $f in "Sko"$ ein Skolemsymbol, das nicht in $psi$ vorkommt.\
4: $space.quad$ Setze $ar(f) = n$.\
5: $space.quad$ Ersetze $phi$ durch $forall y_1 dots forall y_n (psi[z arrow.bar f(y_1, dots , y_n)])$.\
6: *end while*\
7: *return* $phi$ in Skolem-Normalform.\ \
=== Existenzieller und universeller Abschluss
Sei $phi in FO(S)$ eine Formel mit $"free"(phi) = {x_1,dots,x_n}$.
- Die Formel $forall x_1 , dots forall x_n . phi$ heißt *universeller Abschluss* von $phi$.
- Die Formel $exists x_1 , dots exists x_n . phi$ heißt *existenzieller Abschluss* von $phi$.

Der universelle Abschluss von $phi$ ist genau dann *allgemeingültig*, wenn $phi$ *allgemeingültig* ist.\
Der existentielle Abschluss von $phi$ ist genau dann *erfüllbar*, wenn $phi$ *erfüllbar* ist.
\ \

= Berechnungsprobleme in der Prädikatenlogik
Gibt es einen Algorithmus, der entscheidet, ob eine gegebene Formel erfüllbar (allgemeingültig) ist?
== Herbrand-Strukturen
- Um zu entscheiden, ob eine Formel $phi in FO(S)$ allgemeingültig (oder unerfüllbar) ist, müssen wir a priori alle $S$-Strukturen $cal(A) = (D, frak(I))$ in Betracht ziehen.

Wir werden nun argumentieren, dass es ausreicht, sich auf bestimmte, algorithmisch
handhabbare Strukturen, die sogenannten *Herbrand-Strukturen*, einzuschränken.

=== Variablenfreie Terme und Formeln
Wir bezeichnen mit $FO_"abg" (S)$ die Menge der abgeschlossenen Formeln (also Formeln ohne freie Variablen) in $FO(S)$. \
Für eine abgeschlossene Formel $phi$ ist $phi^frak(I)$ mit $frak(I) = (cal(A), beta)$ unabhängig von der Belegung $beta$.\
*Schreibweisen*: Sei $cal(A)$ eine $S$-Struktur.
- Für eine abgeschlossene Formel bezeichne $phi^cal(A)$ den Wahrheitswert von $phi^frak(I)$ für eine (und damit alle) Interpretationen der Form $frak(I) = (cal(A), beta)$.
- Wir schreiben auch $cal(A) models phi$, wenn $phi^cal(A) = 1$.

=== Einschränkung auf gleichheitsfreie Skolemform
Für Fragen der Erfüllbarkeit können wir uns auf Formeln in Skolemform beschränken.\
Der Einfachheit halber werden wir uns im Folgenden auf Formeln in $FO^eq.not (S)$ beschränken, also
Formeln ohne Gleichheitszeichen.

=== Herbrand-Struktur
Für eine Signatur $S$ definieren wir den Datenbereich $D_cal(H)$, das *Herband-Universum*, als die kleinste Menge, für die gilt:
$
  &c in D_cal(H) &&"für alle Konstanten" c "von" S "und"\
  &f(
    t_1,dots,t_ar(f)
  ) in D_cal(H), space.quad space.quad &&"falls" t_1,dots,t_ar(f) in D_cal(H) "und" f "eine Funktion von" S "ist."
$
\
Eine $S$-Struktur der Form $cal(H) = (D_cal(H), frak(a))$ heißt *Herbrand-Struktur*, wenn für die Interpretation $frak(a)$ der Symbole gilt:
- Für jede Konstante $c$ in $S$ ist $frak(a)(c)$ das Element $frak(a)(c) := c$ des Datenbereichs.
- Für jede Funktion $f$ in $S$ ist $frak(a)(f)$ die Funktion $frak(a)(f): D_cal(H)^ar(f) arrow D_cal(H)$, für die gilt $frak(a)(f)(t_1,dots,t_ar(f)) := f(t_1,dots,t_ar(f))$.
Falls $cal(H) models phi$ gilt, so heißt $cal(H)$ *Herbrand-Modell* von $phi$.\ \
*Theorem* (Herbrand)\
Sei $S$ eine Signatur mit mindestens einem Konstantensymbol. Eine abgeschlossene
Formel $phi in FO^eq.not (S)$ in Skolemform ist genau dann erfüllbar, wenn sie ein Herbrand-Modell hat.
\
Wenn $phi in FO^eq.not (S)$ erfüllbar ist, dann besitzt $phi$ ein Modell mit abzählbarem (möglicherweise
endlichem) Datenbereich.

== Semi-Entscheidbarkeit der Allgemeingültigkeit
=== Herbrand-Expansion
Sei $phi equiv forall y_1 dots forall y_n.psi in FO^eq.not (S)$ eine abgeschlossene Formel in Skolemform, so dass $psi$ quantorenfrei ist. Die *Herbrand-Expansion* $E(phi)$ von $phi$ ist definiert als die Menge der Formeln
$ E(phi) := {psi[y_1 arrow.bar t_1, dots, y_n arrow.bar t_n] | t_1,dots,t_n in D_cal(H)}, $
die aus $psi$ durch Substitution der Variablen $psi$ durch Terme in $D_cal(H)$ entstehen.
=== Die Expansionsformeln als Aussagen
