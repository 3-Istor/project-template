# Architecture

Le modèle d'architecture vit ici, en code, avec [Noodle](https://github.com/TheGostsniperfr/Noodle)
(plugin `noodle@team-ai`) : un modèle (ce qui existe), des vues (ce que chaque
diagramme montre).

```
noodle render docs/architecture -view runtime                  # vérifier (lint)
noodle render docs/architecture -view runtime -o runtime.drawio # rendre
```

Le diagramme est mis à jour dans la PR qui change l'architecture.
