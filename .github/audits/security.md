Type : security. Titre : « Audit sécurité du <date> ».

Lis d'abord .github/audits/COMMON.md et applique-le.

Cherche dans tout le repo, pas seulement le dernier diff :
- secrets, jetons, mots de passe dans le code, la config, les fixtures, l'historique récent (`git log -p --since="1 month ago"`) ;
- contrôles d'accès absents ou seulement côté front, entrées non validées vers SQL, shell, chemins, URL (SSRF) ;
- workflows CI : `pull_request_target` avec secrets, actions tierces non épinglées, permissions trop larges ;
- dépendances : versions non épinglées, paquets abandonnés ou au nom suspect ;
- agents et IA : un même agent qui a à la fois accès à des données privées, lit du contenu non fiable et peut envoyer vers l'extérieur ;
- `.claude/settings.json` : deny rules et sandbox toujours présentes.
