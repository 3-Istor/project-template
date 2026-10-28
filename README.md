# project-template

Le point de départ de chaque projet 3-Istor : le repo naît avec le contexte
pour les agents (Claude Code et Codex), les règles imposées, la review et la
CI. Bouton **Use this template** sur GitHub, puis la checklist ci-dessous.

## Ce qu'il y a dedans

| Fichier | Rôle |
|---|---|
| `AGENTS.md` (+ `CLAUDE.md` en lien) | Contexte lu par les agents à chaque session |
| `REVIEW.md` | Ce qui compte pour la review IA et humaine, niveaux de risque |
| `docs/specs/`, `docs/adr/`, `docs/architecture/`, `docs/postmortems/` | Specs, décisions, archi en code (Noodle), postmortems |
| `docs/PROGRESS.md` | Où en est le travail ; point de départ de la session suivante |
| `.claude/settings.json` | Deny rules (`.env`, secrets, force push), sandbox, hook de rappel doc, plugins team-ai |
| `.pre-commit-config.yaml` | Format, gitleaks, lint des ADR, nom de branche (pour tous les outils) |
| `Makefile` | `make check` : la seule commande de vérification, archi en couches comprise (`make arch`) |
| `policy/` | Règles plateforme vérifiées par conftest sur les manifests Kubernetes |
| `.github/workflows/` | `ci`, `ai-review`, `security-review`, `platform` (policies + drift d'archi Noodle), `audits` (mensuels) |
| `.github/audits/` | Consignes des audits planifiés : sécurité, prise en main, dérive specs/code |
| `.github/` | Template de PR, CODEOWNERS |

## Checklist après création

1. **`AGENTS.md`** : remplir les `[À REMPLIR]` (projet, commandes).
2. **`Makefile`** : remplacer `LINT`, `TYPECHECK`, `TEST`, `BUILD`, `ARCH` par les vrais outils.
3. **`REVIEW.md`** : écrire « ce qu'est un échec ici », ajuster les chemins à risque.
4. **`CODEOWNERS`** : décommenter avec de vrais handles.
5. **Protection de `main`** (Settings › Branches) : PR obligatoire, checks `ci`
   requis, 1 approbation (2 via CODEOWNERS sur les chemins sensibles), « Dismiss
   stale approvals », « Require review from Code Owners ».
6. **Secret `ANTHROPIC_API_KEY`** (repo ou org) pour activer `ai-review` et
   `security-review`. Sans lui, ces jobs sont ignorés.
7. **Variable `K8S_MANIFESTS`** (si le projet se déploie sur Kubernetes) :
   dossier de YAML ou chart Helm. Active `policy` (bloquant) et
   `architecture-drift` (avertissement) ; au premier run, commiter la sortie
   dans `docs/architecture/discovered/k8s.yaml`.
8. **Variable `TICKET_PATTERN`** (facultatif) si vos clés de ticket ne sont ni
   `PROJ-42` ni un numéro d'issue.
9. **Chaque personne**, une fois : `pip install pre-commit && pre-commit install
   --hook-type pre-commit --hook-type pre-push`. Côté Codex :
   `team-ai/scripts/sync-codex.sh .` pour avoir les skills de l'équipe.

## Ce qui tourne tout seul

| Quand | Quoi |
|---|---|
| Pendant la session | Hook `Stop` : code changé sans doc touchée → l'agent repart une fois |
| Commit, push | pre-commit : format, gitleaks, ADR, nom de branche |
| Chaque PR | `make check`, secrets, nom de branche, policies, drift d'archi, review IA, revue sécurité |
| Le 1er du mois | Audits sécurité, prise en main, dérive : un ticket `audit` chacun, à trier |

## Ce qui est imposé, ce qui est conseillé

- **Imposé par l'outil** : deny rules, sandbox, pre-commit, CI, protection de
  branche. L'agent ne peut pas les ignorer.
- **Conseillé au modèle** : `AGENTS.md`, `REVIEW.md`, les skills. Une règle de
  ces fichiers ignorée deux fois devient un hook ou un check de CI.
