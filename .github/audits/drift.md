Type : drift. Titre : « Audit de dérive du <date> ».

Lis d'abord .github/audits/COMMON.md et applique-le.

Compare ce qui est écrit à ce qui est livré :
- chaque spec `docs/specs/*.md` en statut `livrée` ou `validée` : ses critères
  d'acceptation sont-ils couverts par le code et un test ? Cite le test ;
- les ADR `accepted` : le code les respecte-t-il encore ?
- AGENTS.md et README : chaque commande, chemin et règle cités existent-ils ?
- docs/architecture : les composants décrits existent-ils encore, en
  manque-t-il de nouveaux ?
- une feature livrée dont la spec annonce une mesure de valeur : la mesure
  existe-t-elle ?
