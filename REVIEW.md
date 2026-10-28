# Règles de review

Lu par la review IA (skill `code-review`, workflow `ai-review`) et par les
relecteurs humains. Court exprès : chaque remarque de review qui revient deux
fois devient une ligne ici.

## Ce qu'est un échec dans ce projet

[À REMPLIR, 3 lignes max. Exemples : une donnée accessible sans être connecté ;
une migration non réversible ; un secret dans un log.]

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

## À ignorer

- `vendor/`, fichiers générés, `*.lock`

## Convergence

- Après 3 allers-retours sur une PR : remettre en question l'approche.
- À partir du 3e round : ne relire que les nouveaux commits.
- Ne jamais répéter un finding déjà posté.
- Chaque commentaire IA est corrigé, ou fermé avec une raison.
