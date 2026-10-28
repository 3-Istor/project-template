# Règles de review

Lu par la review IA (skill `code-review`, workflow `ai-review`) et par les
relecteurs humains. Court exprès : chaque remarque de review qui revient deux
fois devient une ligne ici.

## Ce qu'est un échec dans ce projet

[À REMPLIR, 3 lignes max. Exemples : une donnée accessible sans être connecté ;
une migration non réversible ; un secret dans un log.]

## Ce que [Important] veut dire ici

Réservé à ce qui casse un comportement, fuit une donnée ou empêche un retour
arrière : logique fausse, requête non filtrée par propriétaire, donnée
personnelle dans un log, migration non réversible, violation d'un ADR
`accepted` ou d'une règle d'`AGENTS.md`. Nommage, style et refactoring : `[Nit]`
au plus.

## Toujours vérifier

- Une nouvelle route ou un nouveau parcours utilisateur a un test E2E.
- Les contrôles d'accès sont côté serveur.
- [À COMPLÉTER : les règles propres au projet, une par ligne.]

## Niveaux de risque, par chemin

| Niveau | Chemins | Review |
|---|---|---|
| high | `src/auth/**`, `.github/workflows/**`, `infra/**`, `**/migrations/**` | profonde + sécurité, 2 humains |
| low | `docs/**`, `*.md` | passe rapide, IA seule |
| medium | tout le reste | standard, 1 humain |

Le niveau le plus haut touché par le diff l'emporte. L'approbation d'un bot ne
remplace jamais celle d'un humain.

## Format attendu

- Première ligne : le niveau et le chemin qui le fixe. Puis le nombre de problèmes.
- Chaque finding : `fichier:ligne` et ce qui casse. Pas de supposition à partir
  d'un nom.
- Tags : `[Important]`, `[Nit]`, `[Pre-existing]` (non bloquant, pas introduit
  par la PR).
- 3 nits maximum. Rien de ce qu'un linter ou un formatter attrape.
- Rien à corriger : écrire `0 issues`.

## Ne pas signaler

- Ce que la CI impose déjà : lint, format, types, secrets (gitleaks), policies.
- `vendor/`, fichiers générés, `*.lock`.
- Dans `scripts/` : seulement si c'est quasi certain et grave.

## Convergence

- Après 3 allers-retours sur une PR : remettre en question l'approche.
- À partir du 3e round : ne relire que les nouveaux commits.
- Ne jamais répéter un finding déjà posté.
- Chaque commentaire IA est corrigé, ou fermé avec une raison.
