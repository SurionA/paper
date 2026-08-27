$$
\begin{array} { r l } & { \underbrace { \theta _ { n } = \mathsf { R e l o a d i n g } ( i , g , \omega ) \quad \mathrm { t a r g e t } _ { n } ( \gamma ) \neq \omega \quad ( \delta , h ) = ( \gamma , \mathrm { i d } _ { \Gamma } ) \vee i ( \gamma ) = ( \delta , h , - ) } _ { \displaystyle \gamma \longrightarrow \delta [ \theta _ { n } \mapsto \mathsf { U n l o a d i n g } ( g \circ h , \omega ) ] } \mathrm { L } \mathrm { \lrcorner D i v e r t } } \\ & { \qquad \underbrace { \theta _ { n } = \mathsf { A c t i v e } ( g , \omega ) \quad \mathrm { t a r g e t } _ { n } ( \gamma ) \neq \omega } _ { \displaystyle \gamma \longrightarrow \gamma [ \theta _ { n } \mapsto \mathsf { U n l o a d i n g } ( g , \omega ) ] } \mathrm { L } \mathrm { \lrcorner c a v e } } \\ & { \qquad \underbrace { \theta _ { n } = \mathsf { U n l o a d i n g } ( g , \omega ) \quad \mathrm { ~ - r e l i e d } _ { n } ( \gamma ) \quad g ( \gamma ) = \delta } _ { \displaystyle \gamma \longrightarrow \delta [ \theta _ { n } \mapsto \mathsf { l n a c t i v e } ] } \mathrm { ~ } \mathrm { L } \mathrm { \cdot U n l o a d } } \end{array}
$$

L-Divert may fall between any two consecutive iterations of a transition, routing the fiber into Unloading with the inverses accumulated so far rather than applying them on the spot. Routing through Active instead would let the fiber provide its coeffects for the length of one step and oblige its dependents to activate against a component that is already leaving. The first of L-Divert's two alternatives aborts the iteration the fiber is holding, which only an iteration boundary makes possible, so the granularity at which a divert may fall is that of the iterator; the second lets that iteration land, serving the host Section 4.4 admits, in which an iteration in flight cannot be declined.

L-Leave records the decision to deactivate without acting on it, which stops the fiber providing its coeffects while leaving its own committed view and everyone else's intact. L-Unload applies the accumulator, discards the committed view, and leaves the fiber Inactive; it is the only rule in the calculus that applies an accumulator, an L-Divert routing here rather than applying one of its own.

The two requirements are then carried by different parts of the form: the consumer's reading by the committed view, which L-Unload discards as its last act, and the deferral of the withdrawal by the premise $\lnot \mathrm { r e l i e d } _ { n } ( \gamma )$ , which we call the guard and which holds a provider's withdrawal back until every consumer that resolves a key to n has gone. For a fiber L-Divert takes out of its first transition the guard is vacuous, a fiber that has never been Active providing nothing and appearing in no committed view. Theorem 70 establishes both requirements.

The guard is imposed per binding rather than per fiber: $\operatorname { r e l i e d } _ { n } ( \gamma )$ tests whether some committed view names $n ,$ so a fiber that declares none of n's keys is no obstacle, and neither is one that resolved a key of n's in another realm (Section 3.2.3). Under the single-source discipline of O-Insert the per-binding reading coincides with the coarser test $\exists m \neq n , k \in$ $d _ { m }$ $\mathrm { i n s t a l l e d } _ { m } ( \gamma ) \wedge k \in p _ { n } .$ , a key having one possible provider there.

A guard of this kind ordinarily deadlocks. What keeps it from doing so is Unloading together with $\sigma _ { \gamma }$ being the union over Active fibers alone: once L-Leave or L-Divert has marked $n ,$ its table leaves $\sigma _ { \gamma } ,$ so no target view can name n any longer, and every consumer that committed to n is itself on its way out. Theorem 73 turns that into the claim that the guard always releases.

The guard orders deactivations along coeffects and not along the fiber tree: a parent may run its inverse while a child of it is still Unloading, since relied speaks only of committed views. Parent and child are accordingly ordered more weakly than Theorem 70 orders a provider and its consumer, and a parent and a child whose effects meet at a shared key are governed by the pairwise independence of Lemma 66 instead.

The rules are nondeterministic: several fibers may hold a committed view differing from their target view, and the relation commits to no order among them. They are also reactive only, in that no rule mentions a scheduler; the steps are any sequence of rule applications, so a theorem proved over all such sequences holds for every scheduling policy a runtime might adopt.

## 4.2.3. Confinement

With instantiation the one exception in hand, the discipline an effect function is held to can be given. It bounds what an application of an iteration writes, so that the rule applying it accounts for every other change, and what it reads, so that a fiber sees the coeffects it declared and no more of the registry. Bounding the writes is what lets Section 4.3 read Table 1 as a complete inventory of them.

Definition 55. A map $f : \Gamma \to \Gamma$ is confined to n when for every $\gamma \in \Gamma$ with $n \in \mathrm { d o m } ( F _ { \gamma } )$ , writing $\delta = f ( \gamma )$

1. (Writes.) dom $( F _ { \delta } ) = \mathrm { d o m } \big ( F _ { \gamma } \big ) , \ \delta ( m )$ and $\gamma ( m )$ differ at most in $\sigma _ { m } | _ { d _ { n } }$ for every m $\in$ dom $\left( F _ { \gamma } \right)$ with m ≠ $n ,$ and $\delta ( n )$ and $\gamma ( n )$ differ in σ alone;

2. (Reads.) two states agreeing on $\sigma _ { n }$ and on the restrictions $\sigma _ { m } | _ { d _ { n } }$ for every $m \in \mathop { \mathrm { d o m } } \bigl ( F _ { \gamma } \bigr )$ are carried by f to states agreeing on the same two.

An effect function e is confined to n when every iterator $i \in \mathrm { r e a c h } ( e )$ either instantiates a component (Definition 52) or has both its state map $\operatorname { p r } _ { 1 } \circ i$ and every inverse it yields confined to $n .$

An instantiation writes the entry O-Insert writes, at the one name it draws, and nothing else; the O-Retire it yields as its inverse writes the τ of that name and nothing else. An application of either kind therefore writes no control field of a fiber already present, save that one $\tau ,$ and reads none at all.

Clause (1) permits a write outside the fiber's own table, and there is exactly one kind: the value at a declared key lives in the provider's table, so a component operating on a coeffect it declared moves $\sigma _ { m } | _ { d _ { n } }$ for the m providing it. Clause (2) is why a component may read the values it declared as well: an effect function that reads no table but $\sigma _ { n }$ would be unable to use its own coeffects. What it may neither read nor write is a table outside the two declarations, any control field, or anything no table holds, which is what keeps a component from branching on the lifecycle state of a fiber it did not declare.

The context paradigm fixes the form of an effect function — a sequence of stages, each a coeffect operation, a provision, or an instantiation — and confinement is a consequence of that form.

Definition 56. A stage of Definition 30 lifts along the coeffect projection: it acts on the one table that holds the binding at its key, over every fiber and not the Active ones alone as Definition 51 reads the tables, an extension landing in the table of the fiber acting, and it leaves the rest of the state as it stands. The context-mediated iterators for n form the least set $\Im _ { \Gamma } ^ { A } ( n )$ of iterators on Γ that contains the unit and, each continuation drawn from Nothing and the members, contains three iteration forms: the lift of an operation stage at a key of $d _ { n } \cup p _ { n } ,$ the lift of a provision stage at a key of $p _ { n } .$ , and an instantiation (Definition 52). Every fiber's effect function is required to lie in $\tilde { \mathfrak { I } } _ { \Gamma } ^ { \mathcal { A } } ( \bar { n } )$ at that fiber.

Lemma 57. A member of $\Im _ { \Gamma } ^ { A } ( n )$ is confined to $n ,$ and it lies in $\Im _ { \Gamma } ^ { d _ { n } \cup p _ { n } }$ (Definition 37) at the projection Definition 51 fixes, which is the witness Definition 48 requires of it.

Proof. For confinement, by induction on the construction. An instantiation is the exception Definition 55 carves out. The lift of a stage at k writes the binding at k and nothing else: at k ∈ $p _ { n }$ that binding lies in $\sigma _ { n } ,$ by disjointness of provisions, and at $k \in d _ { n }$ it lies in some $\sigma _ { m } | _ { d _ { n } } ,$ which is clause (1); the inverse it yields, the lift of the operation's inverse or the restriction at $k \in p _ { n } .$ , writes the same binding or removes it from $\sigma _ { n }$ . For clause (2), a stage reads the binding at its key and its presence, both determined by $\sigma _ { n }$ together with the $\sigma _ { m } | _ { d _ { n } }$ , and writes what it read into the same two parts.

For membership, the induction of Lemma 39 carries over stage by stage: at an operation or provision stage the argument there applies as it stands, the lift moving the tables that jointly carry $\sigma _ { \gamma } ^ { d _ { n } \cup p _ { r } }$ as the stage moves the projection and moving nothing else, so respect and witness $\mathsf { a t } \simeq _ { d _ { n } \cup p _ { \tau } }$ on Σ read as the same conditions on Γ at the projection of Definition 51; an instantiating iteration adds an entry holding an empty table and yields the O-Retire writing one $\tau ,$ both invisible to $\simeq _ { d _ { n } \cup p _ { n } } ,$ so its clauses hold outright. □

## 4.3. Metatheory

This section establishes the metatheory of the calculus: that every rule preserves the wellformedness of the registry (Section 4.3.1); that temporal and spatial composability hold in their global form, one fiber's guarantee surviving whatever the other fibers do in between (Section 4.3.2, Section 4.3.3); that the system quiesces (Section 4.3.4); and that it quiesces where a load of the same configuration from scratch would have left it (Section 4.3.5).

Every property below is a property of a sequence of steps, so we index the steps and read the fields of a state off that index.

Definition 58. Index the steps by $t ,$ so that $\gamma ^ { t }$ is the state the first t of them reach, and write

$$
\operatorname { s t e p } ^ { t } : = r ( n )\tag{51}
$$

for the step taken at $\gamma ^ { t } \colon$ the rule r it applies, one of the nine, and the name $n \in \mathfrak { N }$ it applies that rule at. The sequence starts at a $\gamma ^ { 0 }$ with dom $\left( F ^ { 0 } \right) = \emptyset$ , so every fiber comes into existence by an O-Insert, whether the orchestrator's or one an iteration takes (Definition 52). A field of $\gamma ^ { t }$ carries the index as a superscript, so that $\theta _ { n } ^ { t } , \omega _ { n } ^ { t } , \sigma _ { n } ^ { t } , g _ { n } ^ { t }$ , and $i _ { n } ^ { t }$ are the lifecycle state, committed view, table, accumulator, and remaining iterator of n at $\gamma ^ { t }$ , and $F ^ { t }$ and $\sigma ^ { t }$ the registry and coeffect context of $\gamma ^ { t }$ itself, the $F _ { \gamma }$ and $\sigma _ { \gamma }$ of Definition 50 read there. Predicates take the state as their argument and everything else as a subscript, so installed, target, relied, and quiett are the predicates of Definition 49, Definition 53, and Definition 54 at $\gamma ^ { t }$ . An episode of $_ n$ is a maximal interval [b, u] of indices throughout which installedt holds. It opens at $b ,$ where $b >$ 0 and $\neg \mathrm { i n s t a l l e d } _ { n } ^ { b - 1 }$ , the empty $F ^ { 0 }$ leaving no fiber installed at the outset; it closes at u when installedu and not $\mathrm { i n s t a l l e d } _ { n } ^ { u + 1 }$ , which a final episode need not do.

Every rule of Section 4.2 concludes in the shape $\gamma \longrightarrow \delta [ \cdots ] .$ , where the premises compute δ from γ and leave it as $\gamma$ where they compute nothing, and the bracket edits named fields of the registry. The two halves are named separately, and both are maps on all of Γ. The state map of a step taken at $\gamma ^ { t }$ by a rule acting on n is

$$
\Psi ^ { t } : = \left\{ \begin{array} { l l } { \mathrm { p r } _ { 1 } \circ i } & { \mathrm { a t ~ L \mathrm { - } I t e r , ~ L \mathrm { - } F i n i s h , ~ a n d ~ a ~ l a n d i n g ~ L \mathrm { - } D i v e r t } } \\ { g } & { \mathrm { a t ~ L \mathrm { - } U n l o a d } } \\ { \mathrm { i d } _ { \Gamma } } & { \mathrm { a t ~ e v e r y ~ o t h e r ~ r u l e } } \end{array} \right.\tag{52}
$$

where i and $g$ are the iterator and the accumulator that $\theta _ { n } ^ { t }$ carries, and the edit edi $\mathrm { t } ^ { t } : \Gamma \to \Gamma$ is the bracket read as a function, assigning to the fields it names the values the premises computed at $\gamma ^ { t }$ . Both are therefore fixed by stept together with $\gamma ^ { t }$ and defined at every state, which is what lets Theorem 68 and Lemma $7 8$ evaluate them away from $\gamma ^ { t }$ . Each step factors as

$$
\gamma ^ { t + 1 } = \mathrm { e d i t } ^ { t } \big ( \Psi ^ { t } \big ( \gamma ^ { t } \big ) \big )\tag{53}
$$

At L-Unload, for instance, editt is $[ \theta _ { n } \mapsto$ Inactive], and at O-Remove it is the removal $\setminus n ,$ which is why the second half is an edit rather than an assignment. The fields divide along the same seam: the tables $\sigma _ { m } ,$ which no editt writes once the O-Insert creating m has set it empty, and the control fields $\theta _ { m } , \tau _ { m } , \pi _ { m } , d _ { m } , p _ { m } , e _ { m }$ together with dom $\left( F _ { \gamma } \right)$ , which no $\Psi ^ { t }$ writes save through the primitive of Definition 52.

A rule reads the control fields to decide whether it applies, so the relation two whole states are compared at has to keep them. It is Definition 33 over the registry conjoined with agreement on the registry's domain and on every control field of every fiber:

$$
\begin{array} { r l l } { \gamma \simeq \delta } & { : = } & { \sigma _ { \gamma } ^ { K } \simeq \sigma _ { \delta } ^ { K } \wedge \mathrm { d o m } \big ( F _ { \gamma } \big ) = \mathrm { d o m } ( F _ { \delta } ) \wedge \forall n , c \in \{ \theta , \tau , \pi , d , p , e \} . c ( \gamma ( n ) ) \simeq c ( \delta ( n ) ) \mathbb { 5 } d ) } \end{array}
$$

A field of function type, as $e _ { n }$ and the $g$ inside $\theta _ { n }$ are, is compared as Definition 34 compares maps and iterators, and a field of any other type by equality. The results below compare states at the coarser readings Definition 51 gives, $\simeq _ { K }$ where every table is in question and $\simeq _ { d _ { n } \cup p _ { n } }$ where one fiber's is, and the three are nested rather than crosswise, ≈ implying $\simeq _ { K }$ and $\simeq _ { K }$ implying $\simeq _ { S }$ at every S. Lemma 60 establishes the first once for all nine rules.

Table 1 is the nine rules of Section 4.2 read as such writes. The accumulator, the committed view, and the remaining iterator are constituents of $\theta _ { n } .$ , so the third column records the writes to them as well, and h there names the inverse the iteration of the fourth column yields, id where L-Divert aborts that iteration. Where a $\Psi ^ { t }$ built from an iterator instantiates a fiber (Definition 52), that instantiation carries the writes of the O-Insert row at the name it draws, and an L-Unload whose accumulator retires one carries those of the O-Retire row. Every case analysis below is a lookup in the table, and five lookups recur often enough to name.
<table><tr><td>rule</td><td> $\theta _ { n } ^ { t }$ </td><td> $\theta _ { n } ^ { t + 1 }$ </td><td> $\Psi ^ { t }$ </td><td>control fields edited</td></tr><tr><td>O-Insert</td><td>undefined</td><td>Inactive</td><td> $\mathrm { i d } _ { \Gamma }$ </td><td> $\mathrm { d o m } \big ( F _ { \gamma } \big )$ </td></tr><tr><td>O-Retire</td><td>unconstrained</td><td>unchanged</td><td> $\mathrm { i d } _ { \Gamma }$ </td><td> $\tau _ { n }$ </td></tr><tr><td>O-Remove</td><td>Inactive</td><td>undefined</td><td> $\mathrm { i d } _ { \Gamma }$ </td><td> $\mathrm { d o m } \big ( F _ { \gamma } \big )$ </td></tr><tr><td>L-Begin</td><td>Inactive</td><td>Reloading  $( e _ { n } , \mathrm { i d } _ { \Gamma } , \omega )$ </td><td> $\mathrm { i d } _ { \Gamma }$ </td><td> $\theta _ { n }$ </td></tr><tr><td>L-Iter</td><td> $\mathsf { R e l o a d i n g } ( i , g , \omega )$ </td><td> $\mathtt { R e l o a d i n g } ( i ^ { \prime } , g \circ h , \omega )$ </td><td> $\operatorname { p r } _ { 1 } \circ i$ </td><td> $\theta _ { n }$ </td></tr><tr><td>L-Finish</td><td> $\mathsf { R e l o a d i n g } ( i , g , \omega )$ </td><td> $\mathsf { A c t i v e } ( g \circ h , \omega )$ </td><td> $\operatorname { p r } _ { 1 } \circ i$ </td><td> $\theta _ { n }$ </td></tr><tr><td>L-Divert</td><td> $\mathsf { R e l o a d i n g } ( i , g , \omega )$ </td><td> $\mathsf { U n l o a d i n g } ( g \circ h , \omega )$ </td><td> $\mathrm { i d } _ { \Gamma } \mathrm { o r } \mathrm { p r } _ { 1 } \circ i$ </td><td> $\theta _ { n }$ </td></tr><tr><td>L-Leave</td><td> $\mathsf { A c t i v e } ( g , \omega )$ </td><td> $\mathsf { U n l o a d i n g } ( g , \omega )$ </td><td> $\mathrm { i d _ { T } }$ </td><td> $\theta _ { n }$ </td></tr><tr><td>L-Unload</td><td> $\mathsf { U n l o a d i n g } ( g , \omega )$ </td><td>Inactive</td><td>g</td><td> $\theta _ { n }$ </td></tr></table>

Table 1 | The rules as writes on the fiber n they act on, where stept is that rule applied at n.

Lemma 59. Reading Table 1 together with Definition 55, for every step t and all fibers m, n present at $\gamma ^ { t } \colon$

1. a table moves only inside a $\Psi ^ { t } \colon \sigma _ { m } ^ { t + 1 } \neq \sigma _ { m } ^ { t }$ only where step t acts on m, or acts on an n $\neq$ m with dom $( \sigma _ { m } ^ { t } ) \cap d _ { n } \neq \emptyset ,$ , in which case the two tables differ in values at keys of $d _ { n }$ alone and dom $\left( \sigma _ { m } \right)$ is unchanged;

2. $\omega _ { n }$ comes into existence only where st $\mathrm { { \mathfrak { o p } } } ^ { t } = \mathrm { L } \mathrm { - B } \mathrm { e g i n } ( n )$ and ceases only where $\operatorname { s t e p } ^ { t } =$ L-Unload(n), so $\omega _ { n } ^ { t }$ is constant for t in an episode of n;

3. $\Psi ^ { t } = g _ { n } ^ { t }$ only where $\mathrm { s t e p } ^ { t } = \mathrm { L } \mathrm { - U n l o a d } ( n )$ , and no other step applies $g _ { n }$ to the state;

4. ¬ installedt ∧ installed $\mathfrak { l } _ { n } ^ { t + 1 } \Rightarrow \mathrm { s t e p } ^ { t } = \mathrm { L } \mathrm { - B e g i n } ( n )$ and installedt ∧ ¬ installedt+1 ⇒$\mathrm { s t e p } ^ { t } = \mathrm { L } \mathrm { - U n l o a d } ( n ) ;$

5. $\pi _ { n } , d _ { n } , p _ { n } ,$ and $e _ { n }$ come into existence with the entry of n and are never written again, and $\tau _ { n }$ is monotone, written only at T and only by an O-Retire.

Proof. Let step t apply r at n. By Definition 58 it factors as editt 。 Ψt, where editt writes the fields the fifth column of Table 1 names and nothing else, and $\Psi ^ { t }$ is $\mathrm { i d } _ { \Gamma } .$ , an application of one of n's iterations, or the accumulator $g _ { n } ^ { t } ,$ , which is a composite of the inverses those iterations yielded Each of the three is confined to n by Lemma $5 7 ,$ SO $\Psi ^ { t }$ writes no field of a fiber present at $\gamma ^ { t }$ but $\sigma _ { n }$ and the values other tables hold at keys of $d _ { n } ,$ their domains untouched, together with the entry an instantiation adds and the τ its inverse writes. The two halves therefore partition the writes, and each clause is that partition read at one field. One reading of the second and third columns is used twice: Inactive is the one lifecycle state carrying no committed view, L-Begin the one rule leading out of it, and L-Unload the one rule leading into it, while every other row carries the ω of its premise into its conclusion unchanged.

(1) An editt writes no table, the fifth column naming none, and what a $\Psi ^ { t }$ writes outside $\sigma _ { n }$ is values at keys of $d _ { n }$ in the tables holding them, the domains unchanged. So $\sigma _ { m }$ can move only inside a $\Psi ^ { t }$ , at the acting fiber or at the keys of $d _ { n }$ its table holds.

(2) $\omega _ { n }$ is a constituent of $\theta _ { n } ,$ which only an edit writes and only at the fiber the step acts on, so by the reading above $\omega _ { n }$ comes into existence at an L-Begin of n and ceases at an L-Unload of n. An episode of n is an interval on which installed holds, hence one throughout which $\omega _ { n }$ is defined, so neither rule falls in its interior.

(3) The fourth column, where an accumulator appears at L-Unload alone: the other rules take a forward map $\operatorname { p r } _ { 1 } \circ i$ or ${ \mathrm { i d } } _ { \Gamma } ,$ and no editt applies a map to the state at all.

(4) installed $\mathsf { l } _ { n }$ is $\theta _ { n } \neq$ Inactive, and by the reading above L-Begin and L-Unload are the only rules whose premise and conclusion differ in whether $\theta _ { n }$ is Inactive. A step acting on some m $\neq$ n writes no $\theta _ { n } ,$ and the entry an instantiation adds is at a name not present at $\gamma ^ { \bar { t } }$

(5) No row of the fifth column names a $\pi , d , p , \mathrm { o r } e ;$ those come into existence with the entry O-Insert adds, which its conclusion writes, as does the O-Insert an instantiation takes. Only O-Retire writes a τ, at T, whether taken by the orchestrator or as the inverse of an instantiation (Definition 52); O-Insert sets $\tau = \bot$ at a name not already present, so no step returns a τ to ⊥.

Three further lookups say what the rules cannot see. The first is that they read the state only through the observations above, so that the whole calculus descends to $\Gamma / \simeq$

Lemma 60. (≈-invariance.) Let $\gamma \simeq \gamma ^ { \prime }$ as read above. Then a rule of Section 4.2 applies at γ acting on n if and only if it applies at $\gamma ^ { \prime }$ acting on $n ,$ and the states the two applications reach are again related by $\simeq$

Proof. Every premise of Section 4.2 is of one of four kinds, and each reads a constituent the relation keeps. A premise matching $\theta _ { n }$ or $\tau _ { n }$ against a pattern, and the premise ∀m. $\pi _ { m } \neq n$ of O-Remove, read control fields. The premises $( d , p , e ) \in \mathfrak { C } _ { \Gamma }$ and ∀m. $p \cap p _ { m } = \mathcal { O }$ of O-Insert read $d , p ,$ and e. A premise mentioning $\mathrm { t a r g e t } _ { n }$ or rel $\operatorname { i e d } _ { n }$ reads $\tau _ { n } ,$ the committed views inside the $\theta _ { m } ,$ and dom $\left( \sigma _ { \gamma } \right)$ , which Definition 50 computes from the $\theta _ { m }$ and the $\mathrm { d o m } ( \sigma _ { m } )$ and Definition 33 relates two coeffect contexts only where their domains agree. The remaining premises read dom $\left( F _ { \gamma } \right)$ . Two ≈-related states have ≈-related $\sigma _ { \gamma } ,$ the relation comparing every table and the control fields deciding which of them $\sigma _ { \gamma }$ unions, and no premise reads a value $\sigma _ { \gamma } ( k )$ otherwise than up to $\simeq _ { k } ,$ so no premise separates two ≈-related states.

For the conclusion, $\gamma ^ { t + 1 } = \mathrm { e d i t } ^ { t } \big ( \Psi ^ { t } \big ( \gamma ^ { t } \big ) \big )$ by Definition 58. The values an $\operatorname { e d i t } ^ { t }$ assigns are the constituents of the premises it matched, related at the two states by the paragraph above and by the clause $e \simeq e$ of Definition $3 7 ,$ ,which relates the triples an iterator yields at related states. And $\Psi ^ { t }$ carries ≈-related states to ≈-related states: it is $\mathrm { i d } _ { \Gamma } ,$ , an iteration of $\boldsymbol { e } _ { n } ,$ or the accumulator inside $\theta _ { n } ,$ , and the latter two respect $\simeq _ { d _ { n } \cup p }$ by Lemma $5 7 _ { \cdot }$ ,which ≈ implies, while confinement leaves every binding outside the two declarations and every control field as they stand. □

The names a state carries are read by two of those observations, dom $\left( F _ { \gamma } \right)$ and the indexing of the control fields, and the rule that draws a name draws any name not already in use (Definition 52). Reading the results below up to $\simeq$ therefore also calls for reading them up to a renaming, which is the discipline of Section 4.1 cashed out.

Lemma 61. (Equivariance.) Let $\chi : \mathfrak { N } \to \mathfrak { N }$ be a bijection and let $\chi \cdot \gamma$ be the state carrying the registry $F _ { \gamma } \circ \chi ^ { - 1 }$ , with every name occurring in a $\pi _ { m }$ or an $\omega _ { m }$ replaced by its image. Then χ · γ is a state, well formed where $\gamma$ is, and ste $\mathbf { p } ^ { t } = r ( n )$ carries $\gamma ^ { t }$ to $\gamma ^ { t + 1 }$ if and only if $r ( \chi ( n ) )$ carries $\chi \cdot \gamma ^ { t }$ to $\chi \cdot \gamma ^ { t + 1 }$

Proof. A premise reads a name only by comparing it with another, whether directly, as in the freshness n $\notin$ dom $\left( F _ { \gamma } \right)$ of O-Insert and the ∀m. $\pi _ { m } \neq$ n of O-Remove, or through a table of names, as $\mathrm { t a r g e t } _ { n }$ and $\mathrm { r e l i e d } _ { n }$ read the $\pi _ { m }$ and the $\omega _ { m } . \mathrm { A }$ bijection preserves each such comparison. The only names a rule writes are the $\pi$ that O-Insert sets and the $\omega$ that L-Begin sets, both taken from what its premises read, so the writes commute with $\chi ;$ an effect function writes no name at all, drawing one only through the primitive of Definition 52, which Definition 55 confines to the entry that primitive adds. Well-formedness (Definition 63) is four conditions comparing names with names. □

A sequence and its renaming therefore take the same rules in the same order and reach states differing by $\chi$ alone. Two sequences agreeing save in the names their instantiations draw are accordingly identified, and the results below are read up to the renaming that identifies them.

The second lookup is that an entry stripped of everything but its name is invisible to the rules, which is what lets Definition $5 2$ retire a fiber where the state it recovers has none, and Lemma $^ Ḋ 7 9 Ḍ$ remove the fibers a deleted episode instantiated.

Lemma 62. (Vestigial entries.) Call n vestigial at γ when $\tau _ { n } = \top , \theta _ { n } = \mathsf { I n a c t i v e } , \sigma _ { n } = \emptyset ,$ and no m has $\pi _ { m } = n ;$ a vestigial entry satisfies $\gamma \simeq _ { K } \gamma \setminus n$ . If n is vestigial at γ then for every rule and every m $\neq n \colon$

1. a rule applying at γ acting on m applies at $\gamma \setminus$ n acting on m, and the states the two reach differ in the entry at n alone, which stays vestigial;

2. conversely a rule applying at $\gamma \setminus n$ acting on m applies at $\gamma ,$ unless it is an O-Insert drawing the name n or claiming a key of $p _ { n }$

Proof. A vestigial n contributes to no observation a premise of a rule acting on m $\neq$ n reads. It is not Active, so $\sigma _ { n }$ enters no $\sigma _ { \gamma }$ and n is the provider of no key, leaving γ F $d _ { m }$ and $\mathrm { t a r g e t } _ { m }$ unmoved; installed fails, so n contributes no disjunct to relied $_ { m } ;$ no $\pi _ { m ^ { \prime } }$ names $n ,$ so the premise $\forall m ^ { \prime } . \pi _ { m ^ { \prime } } \neq$ m of an O-Remove of $m$ is unmoved; and $\theta _ { n } , \tau _ { n } ,$ and $\pi _ { n }$ are read by rules acting on n alone. The two premises clause (2) excepts are the two the removal relaxes, an absent name being fresh and an absent provision meeting every other. By Lemma 59 no rule acting on m $\neq$ n writes a field of n save values at keys of $d _ { m }$ that $\sigma _ { n }$ holds, of which the empty $\sigma _ { n }$ holds none, so the entry survives vestigial. □

## 4.3.1. Preservation

Definition 50 fixes the shape of a registry, and the rules have to be checked against it before the results below can add to it. This subsection identifies the invariant the rules preserve, of which the first clause is that shape and the rest what those results assume.

Definition 63. A registry $F _ { \gamma }$ is well formed when, for all $m , n \in \mathop { \mathrm { d o m } } \bigl ( F _ { \gamma } \bigr )$ and all $k \in K$

1. πn ∈ dom $\left( F _ { \gamma } \right) \cup .$ {root};

2. $m \neq n \Rightarrow p _ { m } \cap p _ { n } = \emptyset ;$

3. installed ${ \bf \Phi } _ { n } ( \gamma ) \Rightarrow \omega _ { n }$ is total on $d _ { n }$ and valued in dom $\left( F _ { \gamma } \right)$

4. installed $_ { \cdot n } ( \gamma ) \wedge k \in d _ { n } \wedge \omega _ { n } ( k ) = m \Rightarrow \mathrm { i n s t a l l e d } _ { m } ( \gamma )$

Clause (1) is the tree of Definition 50 read one edge at a time, keeping a parent pointer landing in the registry. The acyclicity that definition also requires needs no clause, since the fiber a pointer names is introduced before the fiber naming it.

Theorem 64. (Preservation.) If $F ^ { t }$ is well formed then so is $F ^ { t + 1 }$ , whichever rule step t applies. Each clause is established at $\gamma ^ { t + 1 }$ from all four at $\gamma ^ { t }$

Proof. Let step t act on n.

(1) By Table 1 only O-Insert and O-Remove write a π or dom $\left( F _ { \gamma } \right)$ . O-Insert has $\pi _ { n } \in \operatorname { d o m } ( F ^ { t } ) \cup$ J {root} as a premise, which is the clause for the fiber it adds, and it leaves every other $\pi$ alone while enlarging dom $\left( F _ { \gamma } \right)$ . O-Remove has ∀m. $\pi _ { m } \neq n ,$ so no surviving $\pi _ { m }$ names the fiber it takes away.

(2) The last premise of O-Insert is ∀m. $p _ { n } \cap p _ { m } = \emptyset ,$ which is the clause for the fiber it adds, and by Table 1 no other rule writes a p or enlarges dom $\left( F _ { \gamma } \right)$ . Two consequences are used below: dom $( \sigma _ { m } ) \subseteq p _ { m }$ by Definition $^ { 4 8 , }$ so distinct tables are disjoint and $\sigma _ { \gamma }$ is a function; and $k \in p _ { m } \cap$ $p _ { m ^ { \prime } } \mathrm { f o r c e s } m = m ^ { \prime }$ , so k has at most one possible provider.

(3) By Lemma 59(2) the only rule that writes an $\omega _ { n }$ is L-Begin, whose premise $\omega = \mathrm { t a r g e t } _ { n } ^ { t } \neq \perp$ makes it total on $d _ { n }$ and valued in dom $\left( F ^ { t } \right)$ , target naming providers. By Table 1 the only rule that shrinks dom $\left( F _ { \gamma } \right)$ is O-Remove, whose premise $\theta _ { n } ^ { t } = \mathsf { I n a c t i v e \ g i v e s \to i n s t a l l e d } _ { n } ^ { t } .$ , whence by clause (4) at $\gamma ^ { t }$ no m has $\omega _ { m } ^ { t } ( k ) = n$ for a $k \in d _ { m }$ while $\mathrm { i n s t a l l e d } _ { m } ^ { t } ;$ and n itself carries no ω.

(4) By Lemma 59(2) and (4) the clause can fail at $\gamma ^ { t + 1 }$ only where some installed has fallen, some ω has been written, or a fiber some ω names has left dom $\left( F _ { \gamma } \right)$ . The last is an O-Remove, whose removed fiber is not installed and hence, by clause (4) at $\gamma ^ { t } ,$ is named by no $\omega _ { m } ^ { t }$ of an installed $m _ { \cdot }$ The first is an L-Unload of $n ,$ whose premise ¬ reliec $\operatorname { l } _ { n } ^ { t }$ reads

$$
\forall m \neq n , k \in d _ { m } . { \mathrm { ~ i n s t a l l e d } } _ { m } ^ { t } \Rightarrow \omega _ { m } ^ { t } ( k ) \neq n
$$

and which writes no $\omega _ { m }$ for m $\neq n$ and leaves $\neg { \mathrm { i n s t a l l e d } } _ { n } ^ { t + 1 }$ , so the clause holds of n as well. The second is an L-Begin of $n ,$ writing $\mathrm { t a r g e t } _ { n } ^ { t }$ , whose values are the providers of the keys of $d _ { n }$ and hence Active at $\gamma ^ { t } ;$ the step alters no other fiber's $\theta ,$ so they are installed at $\gamma ^ { t + 1 }$ too. □

The guard on L-Unload is what carries clauses (3) and (4). The premise $\forall m . \ \pi _ { m } \neq n$ of O-Remove speaks only of parent pointers; what keeps a committed view from naming a removed fiber is the guard, imposed several steps earlier and for a different reason. Two things follow. A name freed by O-Remove may be reissued by O-Insert, since no stale committed view can name it; and a fiber may be removed as soon as it is Inactive, without a separate check that nobody depends on it.

## 4.3.2. Temporal Composability

Local temporal composability reverts one sequence of effects with one accumulator (Section 3.1.2). The registry holds one accumulator per fiber and the fibers interleave: between the moment n composes an inverse onto $g _ { n }$ and the moment $g _ { n }$ runs, other fibers have moved the state. Whether $g _ { n }$ still undoes what it was built to undo there is what the global form of the guarantee asserts, and the condition it turns on is that the intervening steps commute with $g _ { n }$

Definition 65. Two iterators $i , j$ over Γ are independent when they are so in the sense of Definition $^ { 4 2 , }$ reading ≈ on maps, triples, and continuations as Definition 34 does, and an instantiating iteration (Definition 52) as agreement of the component it names. Fibers m and n are entangled when one's provision meets the other's declarations, $p _ { m } \cap ( d _ { n } \cup p _ { n } )$ ≠ ∅ or $p _ { n } \cap$ $( d _ { m } \cup p _ { m } )$ ≠ ∅. A sequence of steps is pairwise independent when for every two names m $\neq n$ it ever holds — one for each fiber the orchestrator inserts and each fiber an iteration instantiates — either $e _ { m }$ and $e _ { n }$ are independent, or m and n are entangled and every key at which operations of both occur is commutative (Definition 44).

Independence in this sense is what trace theory takes as primitive: commuting actions generate an equivalence on sequences under which reordering two adjacent independent actions preserves the endpoint [46], and Lemma 78 is that reordering for these rules. Quantifying over names rather than iterators is what keeps two fibers of one component in scope: such a pair requires that component's effect function to be independent of itself, which is to require that m(i) be commutative. Clause (1) of Definition 42 is what Theorem 68 uses and clause (2) what Theorem 80 needs in addition: reordering the steps of two fibers evaluates an iterator at a state the other fiber moved, and commuting the maps does not by itself say that the iterator yields the same inverse and the same continuation there. Checking clause (1) calls for no more than the iterations themselves, since Lemma 41(1) carries commutation from the generators to the monoids they generate.

The paradigm supplies both disjuncts:

Lemma 66. (Pairwise independence.) Every sequence of steps is pairwise independent.

Proof. Every key is commutative, its coeffect carrying the proof as its witness (Definition 46), which settles the second disjunct at an entangled pair. A pair that is not entangled has each member's provision outside the other's every key, which is the hypothesis $P _ { 1 } \cap S _ { 2 } = P _ { 2 } \cap S _ { 1 } =$ ∅ of Theorem 47 read at the underlying members of Definition 30, so those members are independent, the commutativity of every shared operation key again supplied by the witness; independence transfers along the lift of Definition 56, whose transformations move the tables as the stages move the projection, an instantiating iteration adding an entry no table map reads. Two fibers of one component fall under the same two cases, Theorem 47 holding at $i _ { 1 } = i _ { 2 }$ as well. □

Entangled fibers are the pairs independence cannot cover, and could not be expected to: a consumer's operation acts on the very value the provider's extension installs, so the two orders differ at every state the binding is absent from, whichever equivalence the difference is read up to. What stands in for independence there is the rules themselves, which never interleave the two maps in the order that separates them. Throughout the argument, a lift applied where its precondition fails produces no transition, per the convention of Section 3.2.1, so a map meeting a state its key has left is read as the identity.

Lemma 67. (Entangled steps.) Let an episode of n open at $b ,$ and let step $t \geq b$ in the episode act on an m $\neq n$ entangled with n. Then

1. where $p _ { m } \cap ( d _ { n } \cup p _ { n } ) \neq \emptyset , \Psi ^ { t } = \mathrm { i d } _ { \Gamma } ;$

2. otherwise $g _ { n } ^ { t } \bigl ( \Psi ^ { t } ( \gamma ^ { t } ) \bigr ) \simeq _ { K } \Psi ^ { t } ( g _ { n } ^ { t } ( \gamma ^ { t } ) ) ;$

3. where moreover $\theta _ { n } ^ { t } = \mathsf { R e l o a d i n g } ( - , - , - ) , \Psi ^ { t } = \mathrm { i d _ { \Gamma } }$ in either case.

Proof. (1) A key of $p _ { m } \cap p _ { n }$ would put two registered provisions in conflict with the premise of O-Insert, so some $k \in p _ { m } \cap d _ { n } ,$ and m is the one registered fiber whose provision carries k. The premise of n's L-Begin at $b - 1$ resolves k to an Active provider, so $\omega _ { n } ^ { b } ( k ) = m$ and $\theta _ { m } ^ { b - 1 } =$ $\mathsf { A c t i v e ( - , - ) } ; \omega _ { n }$ holds m for as long as the episode is open (Lemma $5 9 ( 2 ) )$ while installed $^ { - } n$ holds, which is relied $\mathbf { \sigma } _ { m } ( \gamma ^ { t } )$ at every such t. The guard therefore blocks every L-Unload of m there, so m never reaches Inactive, and a fiber standing at Active or Unloading is acted on only by L-Leave, O-Retire, and the blocked L-Unload, of which the first two have $\Psi ^ { t } = \mathrm { i d } _ { \Gamma } \left( \mathrm { T a b l e } 1 \right)$ .

(2) Here $p _ { m } \cap ( d _ { n } \cup p _ { n } ) = \emptyset$ and some k $\in { p _ { n } } \cap { d _ { m } } . \Psi ^ { t }$ is one of $m \mathrm { { s } }$ iterations or the accumulator $g _ { m } ^ { t } ,$ , in either case a composite of the maps Definition 56 admits for m: lifts of operation maps, forward or inverse, at keys of $d _ { m } \cup p _ { m } ,$ extensions and restrictions at keys of $p _ { m } ,$ instantiations, and the O-Retires those yield. The constituents of $g _ { n } ^ { t }$ are the inverses Definition 56 admits for n: lifts of operation inverses at keys of $d _ { n } \cup p _ { n } ,$ restrictions at keys of $p _ { n } ,$ and O-Retires. Commute the constituents of $\Psi ^ { t }$ past those of $g _ { n } ^ { t }$ one pair at a time. $\mathrm { A }$ pair at distinct keys is a pair of keylocal maps and commutes; an instantiation or an O-Retire writes a fresh entry or a control field, which no table map reads, and commutes with every constituent in sight; a pair of operation maps at one shared key is covered by that key's commutativity, which the witness of its coeffect supplies (Definition $4 6 )$ , read at the tables through the lift of Definition 56. What remains is an operation map of m at a key $k \in p _ { n } \cap d _ { m }$ against the extension or restriction of n at k. Such a map exists in $\Psi ^ { t }$ only under a committed view of m resolving k (Lemma $5 9 ( 2 ) )$ , whose L-Begin required an Active provider of $k ;$ the commitment pins that provider for as long as m is installed, by the argument of (1) read at $m ,$ and two registered provisions cannot share $k ,$ SO the provider is n and n was Active within the open episode. Its transition had therefore finished by $t ,$ and $g _ { n } ^ { t }$ carries the restriction at k the extension m resolved yielded, composed to the left of $n \mathrm { { ' s } }$ operation inverses at k by the LIFO order of Definition 18. On one side the operation map of m commutes leftward, past constituents at other keys and, by commutativity of $k ,$ past $n \mathrm { { ' s } }$ operation inverses at $k ,$ until the restriction absorbs it, a write to the value at $k$ followed by the removal of k being the removal alone; on the other side it meets a state $g _ { n } ^ { t }$ has removed k from and produces no transition. Both composites therefore agree at $\gamma ^ { t }$

(3) The provider case is (1). In the consumer case, a consumer of n is not installed while n is Reloading: its commitment resolving a key to n would have held relied and blocked the L-Unload closing n's previous episode, and a new commitment requires an Active provider. An uninstalled fiber is acted on only by L-Begin and the orchestration rules; the orchestration rules have $\Psi ^ { t } = \mathrm { i d } _ { \Gamma } .$ , and L-Begin is inapplicable, the key n provides lying outside dom $\left( \sigma _ { \gamma ^ { t } } \right)$ and the target of a fiber declaring it therefore ⊥. □

With every pair so covered, the single-accumulator invariant of Theorem 7 survives the interleaving, in the form that gives temporal composability its content: running an inverse withdraws the fiber's contribution and nothing else.

Theorem 68. (Recovery exactness.) Let an episode of n open at $b ,$ let $u \geq b$ lie in it, and let $t _ { 1 } <$ $\cdots < t _ { l }$ be the indices in $[ b , u )$ at which the acting fiber is not n. Then

$$
g _ { n } ^ { u } ( \gamma ^ { u } ) \simeq _ { K } ( \Psi ^ { t _ { l } } \circ \cdots \circ \Psi ^ { t _ { 1 } } ) \left( \gamma ^ { b } \right)\tag{55}
$$

That is, applying n's accumulator at $\gamma ^ { u }$ leaves every fiber's table where those same steps would have left it from $\gamma ^ { b } .$ , the control fields lying outside the comparison. Reading the right side as the state reached had n never begun assumes that no fiber n instantiates take a step in $[ b , u )$ since a fiber n instantiates is one that would not be there to take it.

Proof. By induction on $u ,$ over the indices u with $u + 1$ in the episode. At $u = b$ the step at $b -$ 1 is an L-Begin, the episode opening by Definition 58, so $g _ { n } ^ { b } = \mathrm { i d } _ { \Gamma }$ by Table 1, the index set is empty, and the claim is $\gamma ^ { b } \simeq _ { K } \bar { \gamma } ^ { b }$ . Two facts are used at each step. $\mathrm { \ A n \ e d i t } ^ { t }$ writes control fields alone, and the two rules that write dom $\left( F _ { \gamma } \right)$ leave the tables as they stand, an O-Insert adding an entry with an empty table and an O-Remove taking one away by its premise, so

$$
\gamma ^ { t + 1 } \simeq _ { K } \Psi ^ { t } ( \gamma ^ { t } )
$$

and, for every fiber $m ,$ every map in ${ \mathfrak { M } } ( e _ { m } )$ carries $\simeq _ { K }$ -related states to $\simeq _ { K }$ -related states, since $\simeq _ { K }$ implies $\simeq _ { d _ { m } \cup p _ { m } }$ , at which Lemma 57 makes such a map respect the relation, and since confinement leaves it moving no binding outside the two declarations, so that the keys outside the interface stay as related as it found them; an instantiation adds an empty entry by Definition 52.

Let step u act on n. Since the episode is open at u and $u + 1$ , Lemma $5 9 ( 4 )$ excludes an L-Begin and an L-Unload of $n ,$ and O-Insert and O-Remove read a $\theta _ { n }$ that installedu denies, leaving two cases. Where the rule is L-Iter, L-Finish, or a landing L-Divert, Table 1 gives $\Psi ^ { u } = \mathrm { p r } _ { 1 } \circ i _ { n } ^ { u }$ and $g _ { n } ^ { u + 1 } = g _ { n } ^ { u } \circ h$ for the inverse h that iteration yields. The witness condition of Definition 37 reads $\begin{array} { r } { h ( \Psi ^ { u } ( \gamma ^ { u } ) ) \simeq _ { d _ { n } \cup p _ { n } } \gamma ^ { u } } \end{array}$ , which is $\simeq _ { K }$ once Lemma 57 adds that neither map moves a binding outside the two declarations, and the instantiating iteration is the case where the two states differ in an entry with an empty table that $\simeq _ { K }$ does not compare. Since $g _ { n } ^ { u }$ carries $\simeq _ { K }$ by the paragraph above,

$$
g _ { n } ^ { u + 1 } \bigl ( \gamma ^ { u + 1 } \bigr ) \simeq _ { K } ^ { } \left( g _ { n } ^ { u } \circ h \right) \bigl ( \Psi ^ { u } ( \gamma ^ { u } ) \bigr ) \simeq _ { K } ^ { } g _ { n } ^ { u } \bigl ( \gamma ^ { u } \bigr )
$$

Where the rule is L-Leave, an aborting L-Divert, or an O-Retire of $n ,$ Table 1 gives $\Psi ^ { u } = \mathrm { i d } _ { \Gamma }$ and $g _ { n } ^ { u + 1 } = g _ { n } ^ { u } ,$ , so the same equation holds with $h = \mathrm { i d } _ { \Gamma }$ . Either way the induction hypothesis carries over with the index set unchanged, which is the computation of Theorem $7$ one step at a time.

Let step u act on m ≠ n. Then $g _ { n } ^ { u + 1 } = g _ { n } ^ { u }$ by Table 1, and $\Psi ^ { u } \in \mathfrak { M } ( e _ { m } )$ , or $\Psi ^ { u } = \mathrm { i d } _ { \Gamma }$ where the rule is an orchestration rule. Where m and n are not entangled, Lemma 66 makes $e _ { m }$ and $e _ { n }$ independent, and clause (1) of Definition 42, read at the finer ≈ of Definition 58 and hence at $\simeq _ { K } .$ , commutes $g _ { n } ^ { u }$ with $\Psi ^ { u } )$ where they are entangled, Lemma $6 7$ commutes the two at $\gamma ^ { u }$ , its first case outright. Either way

$$
g _ { n } ^ { u } \bigl ( \gamma ^ { u + 1 } \bigr ) \simeq _ { K } g _ { n } ^ { u } \bigl ( \Psi ^ { u } \bigl ( \gamma ^ { u } \bigr ) \bigr ) \simeq _ { K } \Psi ^ { u } \bigl ( g _ { n } ^ { u } \bigl ( \gamma ^ { u } \bigr ) \bigr )
$$

which is the induction hypothesis with $\Psi ^ { u }$ appended, $\Psi ^ { u }$ carrying $\simeq _ { K }$ -related states to $\simeq _ { K ^ { - } }$ related states by the paragraph above. □

Corollary 69. (Terminal recovery.) Let an episode of n open at b and close at u. Then, with $t _ { 1 } < \dots < t _ { l }$ as in Theorem 68,

$$
\gamma ^ { u + 1 } \simeq _ { K } \left( \Psi ^ { t _ { l } } \circ \cdots \circ \Psi ^ { t _ { 1 } } \right) \left( \gamma ^ { b } \right)\tag{56}
$$

In particular $\sigma _ { n } ^ { u + 1 } = \emptyset$ , which is the premise an O-Remove of n carries.

Proof. By Lemma 59(4) step u is an L-Unload of $n ,$ whose $\Psi ^ { u }$ is $g _ { n } ^ { u }$ by Lemma $5 9 ( 3 ) , \mathrm { s o } \gamma ^ { u + 1 } \simeq _ { K }$ $g _ { n } ^ { u } ( \gamma ^ { u } )$ and Theorem 68 applies. For the table, the fiber enters the episode with $\sigma _ { n }$ empty, and the keys of $p _ { n }$ enter $\operatorname { d o m } ( \sigma _ { n } )$ only by $n ^ { \prime } { \mathrm { s } }$ own extensions (Definition 56), of which the right side applies none, so the right side leaves $\sigma _ { n }$ empty; Definition 33 relates two coeffect contexts only where their domains agree, so a table it relates to the empty one is empty. □

What the two results compare is the tables, so what they assert is bounded by what the keys of a state bind, and inside each binding by the $\simeq _ { k }$ the key's operations induce: each binding is restored only up to what its key's equivalence forgets, so a monotone allocator is not rewound, a heap's layout free does not restore, and a message already sent stays sent. This is the bound Section 3.3.2 takes on Theorem 7 and for the same reason, the physical state not being recoverable as it stood; a location the system reifies at no key lies outside the calculus altogether (Definition 56), and Section 6.1 is where a system decides what to reify.

The results above therefore assume nothing of the sequence. The witness and respect conditions of ${ \mathfrak { I } } _ { \Gamma } ^ { d \cup p }$ are Lemma $5 7 ,$ pairwise independence is Lemma 66, and both rest on the components alone: Definition 56 fixes the form of every effect function, the effect function's witness holds each returned inverse to reverting, and the coeffect's witness holds each key to commutativity (Definition 46), an interface property Definition 31 turns into a design procedure.

## 4.3.3. Spatial Composability

Local spatial composability holds a component to its own specification, activating it only where its dependencies are provided and classifying every context change against them (Section 3.2.2). The global form adds what quantifies over other fibers: a provider withdraws a binding only after every dependent that resolved it has deactivated, and the resolution a transition installs its effects against does not shift under it. Two properties of the coeffect side deliver the two, and they are proved together, being two halves of one invariant, namely the fixity of $\omega _ { n }$ over an episode that Lemma 59(2) establishes. The ordering theorem is what that fixity delivers over the part of the episode in which n is Active and then Unloading, and the coherence theorem what it delivers over the part in which n is installing its effects.

Theorem 70. (Ordering.) A fiber begins a transition only where its dependencies are provided:

$$
{ \mathrm { s t e p } } ^ { t } = { \mathrm { L } } \mathrm { - B e g i n } ( m ) \Rightarrow \gamma ^ { t } \models d _ { m }\tag{57}
$$

Let further $[ b ^ { \prime } , u ^ { \prime } ]$ be an episode of m with $\omega _ { m } ^ { b ^ { \prime } } ( k ) = n$ for some m $\neq n$ and $k \in d _ { m } .$ , let $[ b , u ]$ be the episode of n containing $b ^ { \prime } .$ , and let t range over $[ b ^ { \prime } , u ^ { \prime } ]$ . Then

1. $\omega _ { m } ^ { t } ( k ) = n ;$

2. $b < b ^ { \prime }$ , and $u ^ { \prime } < u$ if [b, u] closes;

3. $k \in \mathrm { d o m } ( \sigma _ { n } ^ { t } )$ , and $\sigma _ { n } ^ { t } ( k )$ moves only by operations at k of fibers declaring k.

Proof. The first claim is the premise tai $\mathrm { r g e t } _ { m } ^ { t } \neq \perp$ of L-Begin, which by Definition 53 gives $\gamma ^ { t }$ F $d _ { m }$

(1) is Lemma 59(2).

For (2), the L-Begin at $b ^ { \prime } - 1$ writes $\omega _ { m } ^ { b ^ { \prime } } = \mathrm { t a r g e t } _ { m } ^ { b ^ { \prime } - 1 }$ , whose values are providers, so $\theta _ { n } ^ { b ^ { \prime } } =$ $\mathsf { A c t i v e } ( - , - ) ;$ the L-Begin at $b - 1$ leaves $\theta _ { n } ^ { b } = { \mathsf { R e l o a d i n g } } ( - , - , - )$ , SO $b \neq b ^ { \prime }$ and hence $b < b ^ { \prime } .$ both episodes opening by Definition 58. Let $[ b , u ]$ close and suppose $u \leq u ^ { \prime }$ . Then $u \in [ b ^ { \prime } , u ^ { \prime } ] ,$ so installedu and, by $( 1 ) , \omega _ { m } ^ { u } ( k ) = n ;$ that is $\mathrm { r e l i e d } _ { n } ^ { u } ,$ which the L-Unload at u denies. Hence $u ^ { \prime } < u$

For (3), n is the provider of k at $\gamma ^ { b ^ { \prime } }$ , SO $k \in \mathrm { d o m } \bigl ( \sigma _ { n } ^ { b ^ { \prime } } \bigr )$ . No L-Unload of n falls in $[ b ^ { \prime } , u ^ { \prime } ]$ : where $[ b , u ]$ closes it falls at $u > u ^ { \prime }$ by $( 2 )$ , and where it does not, Lemma $5 9 ( 4 )$ leaves n with no L-Unload at all. Since $\theta _ { n } ^ { b ^ { \prime } } = \mathsf { A c t i v e } ( - , - )$ , Table 1 therefore leaves L-Leave as the only rule n can be acted on by within $[ b ^ { \prime } , u ^ { \prime } ] ,$ , and its $\Psi ^ { t }$ is ${ \mathrm { i d } } _ { \Gamma } ,$ so n withdraws nothing and $\operatorname { d o m } ( \sigma _ { n } )$ is constant there by Lemma $5 9 ( 1 )$ . What a step of another fiber may move is values at keys its own declarations name (Definition 56), so a write to $\sigma _ { n } ( k )$ is an operation at k of a fiber with k in its specification. □

A transition spread over steps could otherwise install effects computed against a resolution that has changed under it, and two premises prevent that. L-Iter and L-Finish carry tar $\begin{array} { r } { \mathrm { g e t } _ { n } ( \gamma ) = \omega , } \end{array}$ so a transition proceeds only while its committed view is still its target view, and L-Divert carries the negation, so any change to the target view takes the fiber out of the transition. The two directions of change are not distinguished: a component whose dependency has gone and one whose dependency has been replaced leave by the same route, because a target view that has become ⊥ and one that has become some other fiber are equally unequal to ω.

The landing alternative of L-Divert is what stops this from being a guarantee about every step: the iteration it lands installs an effect computed against a resolution that no longer holds What the rules deliver is therefore a disjunction, and the second branch is what makes the first safe.

Theorem 71. (Resolution coherence.) Let an episode $[ b , u ]$ of n open at b with $\omega _ { n } ^ { b } = \omega .$ Then $\theta _ { n }$ is Reloading $\cdot ( - , - , - )$ on an initial interval $[ \bar { b } , r ]$ of the episode, and every iteration of the transition runs against the one resolution $\omega \mathrm { : }$

$$
\forall t \in [ b , r ] . \ \mathrm { s t e p } ^ { t } \in \ \{ \mathrm { L } \mathrm { - } \mathrm { I t e r } ( n ) , \mathrm { L } \mathrm { - } \mathrm { F i n i s h } ( n ) \} \Rightarrow \mathrm { t a r g e t } _ { n } ^ { t } = \omega\tag{58}
$$

Where the fiber leaves that interval, so that $r < u _ { \ast }$ , exactly one of the following holds:

1. $\operatorname { s t e p } ^ { r } = \operatorname { L - F i n i s h } ( n )$ and $\theta _ { n } ^ { r + 1 } = \mathsf { A c t i v e } ( - , \omega ) ;$

2. ste] $\mathsf { \Omega } _ { \mathrm { p } } ^ { r } = \mathrm { L } \mathrm { - D i v e r t } ( n ) .$ , and the episode closes at some $u > r$ with $\gamma ^ { u + 1 } \simeq _ { K } ( \Psi ^ { t _ { l } } \circ \cdots \circ$ $\Psi ^ { t _ { 1 } } \big ) \big ( \gamma ^ { b } \big )$ as in Corollary 69.

Proof. The L-Begin at $b - 1$ writes Reloading, and by Table 1 it is the one rule leading into that lifecycle state; its premise $\theta _ { n } = \mathsf { I n a c t i v e }$ and Lemma $5 9 ( 4 )$ put any second application of it outside the episode. So Reloading occupies an initial interval $[ b , r ]$ of $[ b , u ]$ and is not re-entered. The first claim is then the premise tar $\mathrm { g e t } _ { n } ( \gamma ) = \omega ^ { \prime }$ that Table 1 gives L-Iter and L-Finish, together with $\omega ^ { \prime } = \omega$ by Lemma $5 9 ( 2 )$

For the dichotomy, step" is a rule whose premise has $\theta _ { n } = { \mathsf { R e l o a d i n g } } ( - , - , - )$ and whose conclusion does not, of which Table 1 offers L-Finish and L-Divert; the first lands in $\mathsf { A c t i v e } ( - , \omega )$ and the second in $\mathsf { U n l o a d i n g } ( - , \omega )$ , from which Lemma $5 9 ( 4 )$ makes an L-Unload the only exit and Corollary 69 supplies the equation. The iteration a landing L-Divert contributes is one of $n \mathrm { { ' s } }$ own, hence among the maps that accumulator withdraws. Where instead $r = u ,$ the sequence ends with the transition still in flight and the first claim is all that is asserted. □

## 4.3.4. Progress

A guard that defers a provider's withdrawal until its dependents are gone delivers Theorem 70 only if it eventually releases. One relation on the fibers of a registry carries the argument.

Definition 72. The precedence relation on the names of a registry is

$$
n \prec m : = p _ { n } \cap d _ { m } \neq \emptyset\tag{59}
$$

so that n may provide a key m declares. It reads d and p alone, which by Lemma 59(5) come into existence with a fiber's entry and are never written again.

Theorem 73 and Theorem 80 are established on the hypothesis that < is acyclic, which is an assumption and not something the definition delivers, $n \prec n$ holding of a component that declares a key it provides itself. What < orders is the two fibers' activations and not their lifetimes: $n \prec$ m says that n has to become Active before m can, whereas that a provider outlives its consumer is Theorem $7 0 ( 2 )$ , a theorem about the guarded calculus.

A fiber's target view answers to the fiber that created it as well as to its providers. What a creator writes is $\tau _ { n } ,$ through the primitive of Definition 52, and τ is monotone by Lemma 59(5). A creator can therefore turn its child's target view at most once over that child's whole existence.

Progress is a claim that some rule applies, so it is formulated over the rules a host must offer: L-Begin, L-Leave, L-Unload, the landing rules L-Iter and L-Finish, and L-Divert. It appeals to the aborting alternative of L-Divert nowhere, which Section 4.4 puts to use.

Theorem 73. (Progress.) Assume  acyclic, len $( e _ { n } ) \leq K$ for every $n ,$ and the set N of names the sequence ever holds (Definition 65) finite; and let every step apply a lifecycle rule. Write $S ( n )$ for the number of steps acting on n and

$$
V ( n ) : = \left| \left\{ t : \mathrm { t a r g e t } _ { n } ^ { t } \neq \mathrm { t a r g e t } _ { n } ^ { t + 1 } \right\} \right|\tag{60}
$$

for the number of times its target view turns. Then

1. $( N o d e a d l o c k . ) \neg \mathrm { q u i e t } ^ { t }$ implies that some lifecycle rule applies at $\gamma ^ { t } ;$

2. (Termination.) $S ( n ) \leq ( K + 3 ) ( V ( n ) + 1 )$ , and both $V ( n )$ and $\textstyle \sum _ { n } S ( n )$ are finite. Consequently every maximal sequence of lifecycle steps ends in a quiescent state.

Proof. No deadlock. Let $\neg \mathrm { q u i e t } ^ { t } .$ , so some fiber n satisfies neither clause of the quiet of Definition 53. Reading Table 1 against the four kinds it can then be:

• θ = Inactive with target ≠ ⊥: L-Begin applies;

$\theta _ { n } ^ { t } = \mathsf { R e l o a d i n g } ( - , - , \omega _ { n } )$ with tal $\mathrm {  { ~ \cdot ~ } } \mathrm {  { g e t } } _ { n } ^ { t } = \omega _ { n }$ : whichever of L-Iter and L-Finish the value of $i _ { n } ^ { t } ( \gamma ^ { t } )$ selects applies;

$\theta _ { n } ^ { t } = \mathsf { R e l o a d i n g } ( - , - , \omega _ { n } )$ with targe $\mathrm { t } _ { n } ^ { t } \neq \omega _ { n } \mathrm { : }$ L-Divert applies, landing that iteration rather than aborting it;

$\theta _ { n } ^ { t } = \mathsf { A c t i v e } ( - , \omega _ { n } )$ with targe $\mathbf { t } _ { n } ^ { t } \neq \omega _ { n }$ : L-Leave applies.

Let no fiber be of any of these kinds, leaving some $m _ { 0 }$ with $\theta _ { m _ { \mathsf { n } } } ^ { t } = \mathsf { U n l o a d i n g } ( - , - )$ . Construct $m _ { 0 } , m _ { 1 } , \ldots$ as follows: given $m _ { j }$ in Unloading, either ¬ relied, in which case L-Unload applies to $m _ { j }$ and the construction stops, or there are $m _ { j + 1 } \neq m _ { j }$ and $k _ { j }$ with installed $\mathsf { l } _ { m _ { j + 1 } } ^ { t }$ and $\omega _ { m _ { j + 1 } } ^ { t } ( k _ { j } ) = m _ { j }$ . In the latter case

$$
k _ { j } \in d _ { m _ { j + 1 } } \cap \mathrm { d o m } \Big ( \sigma _ { m _ { j } } ^ { t } \Big ) \subseteq d _ { m _ { j + 1 } } \cap p _ { m _ { j } }
$$