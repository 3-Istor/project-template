# Décisions d'architecture (ADR)

Une décision structurante = un fichier `NNNN-titre-court.md`, copié depuis
[TEMPLATE.md](TEMPLATE.md). Numéros uniques, jamais réutilisés.

## Statuts

| Statut | Sens |
|---|---|
| `proposed` | en discussion |
| `accepted` | en vigueur : le code et la review la respectent |
| `superseded` | remplacée : `superseded_by` donne le numéro qui la remplace |
| `deprecated` | plus en vigueur, sans remplaçant |
| `rejected` | étudiée puis écartée (on garde la trace) |

## Changer une décision

On ne réécrit pas un ADR `accepted`. On en écrit un nouveau avec
`supersedes: NNNN`, et on passe l'ancien en `superseded` avec
`superseded_by: MMMM`. `make adr-lint` (et la CI) vérifie ces liens.
