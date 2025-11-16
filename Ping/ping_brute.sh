#!/bin/bash

# Fichiers de sortie
REPORT_SUMMARY="rapport_ping.txt"
REPORT_RAW="rapport_ping_brut.txt"

# Nettoyer les anciens rapports
echo "Rapport de ping (résumé) - $(date)" > "$REPORT_SUMMARY"
echo "==============================" >> "$REPORT_SUMMARY"

echo "Rapport de ping (brut) - $(date)" > "$REPORT_RAW"
echo "==============================" >> "$REPORT_RAW"

# Demander combien d'IP
read -p "Combien d'adresses IP voulez-vous tester ? " count

# Boucle pour saisir les IP
for ((i=1; i<=count; i++)); do
    read -p "Entrez l'adresse IP #$i : " ip
    echo -n "Ping $ip... "
    
    # Exécuter le ping et stocker le résultat brut
    PING_RESULT=$(ping -c 6 -W 3 "$ip")
    
    # Vérifier si le ping a réussi
    if [ $? -eq 0 ]; then
        echo "$ip est accessible ✅" | tee -a "$REPORT_SUMMARY"
    else
        echo "$ip est injoignable ❌" | tee -a "$REPORT_SUMMARY"
    fi
    
    # Ajouter le résultat brut dans le rapport détaillé
    echo -e "\n===== Ping vers $ip =====" >> "$REPORT_RAW"
    echo "$PING_RESULT" >> "$REPORT_RAW"
done

echo -e "\nRapport terminé."
echo "Résumé : $REPORT_SUMMARY"
echo "Détails bruts : $REPORT_RAW"
