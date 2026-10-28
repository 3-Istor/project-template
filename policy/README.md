# Policies

Règles imposées par la CI (`.github/workflows/platform.yml`) sur les manifests
Kubernetes rendus, avec [conftest](https://www.conftest.dev/). C'est la moitié
« sensor » de « utiliser les services de la plateforme » : `AGENTS.md` le dit
à l'agent, ces règles refusent la PR qui ne le fait pas.

- `kubernetes.rego` : pas d'image sans tag ni `:latest`, pas de conteneur
  privilégié, une limite mémoire partout.
- Ajouter une règle : un `deny` de plus, avec un message qui dit quoi corriger.
  Une remarque de review qui revient deux fois sur l'infra finit ici.
- Tester en local : `helm template . | conftest test -` ou
  `conftest test k8s/`.
