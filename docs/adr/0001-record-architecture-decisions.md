---
status: accepted
date: 2026-10-28
deciders: [équipe]
---

# 0001. Les décisions d'architecture sont écrites en ADR dans le repo

## Contexte

Les décisions prises en réunion ou dans une conversation avec un agent se
perdent, et un agent qui reprend une tâche ne peut pas les deviner.

## Options

1. **Notes dans un outil externe** : pratique, mais hors de portée des agents
   et de la review.
2. **ADR dans `docs/adr/`** : versionnés avec le code, lus par les agents et la
   review IA.

## Décision

Option 2. Chaque décision structurante est un ADR ; `make adr-lint` vérifie les
statuts et les remplacements.

## Conséquences

Un changement de décision passe par un nouvel ADR. La review IA signale le code
qui va contre un ADR `accepted`.
