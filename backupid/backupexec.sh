#!/bin/bash

# Lihtne kasutajate varukoopia skript

KODUKATALOOG="/home"
VARU_KATALOOG="/home_bcp"
LOGIFAIL="/var/log/home_backup.log"
KUUPAEV=$(date +%d.%m.%Y)

# Loo varukoopia kataloog
mkdir -p "$VARU_KATALOOG"

# Logi algus
echo "[ $(date '+%F %T') ] VARUNDAMINE ALGAS" >> "$LOGIFAIL"

# Käi läbi kõik kasutajakataloogid
for kataloog in "$KODUKATALOOG"/*; do
    KASUTAJA="$(basename "$kataloog")"
    
    # Välista lost+found
    [[ "$KASUTAJA" == "lost+found" ]] && continue
    
    # Kontrolli kas on kataloog
    [[ ! -d "$kataloog" ]] && continue
    
    echo "[ $(date '+%F %T') ] Varundan: $KASUTAJA" >> "$LOGIFAIL"
    
    # Arhiivi nimi
    ARHIIV="$VARU_KATALOOG/${KASUTAJA}_${KUUPAEV}.tar.gz"
    
    # Vaba ruumi kontroll
    VAJA=$(du -sb "$kataloog" | awk '{print $1}')
    VABA=$(df -B1 "$VARU_KATALOOG" | awk 'NR==2{print $4}')
    
    if [ "$VABA" -lt "$VAJA" ]; then
        echo "[ $(date '+%F %T') ] VIGA: Ei piisa ruumi" >> "$LOGIFAIL"
        continue
    fi
    
    # Tee varukoopia
    tar -czf "$ARHIIV" -C "$KODUKATALOOG" "$KASUTAJA"
    
    # Kontrolli arhiivi
    tar -tzf "$ARHIIV" >/dev/null
    
    # SHA-256 kontrollsumma
    sha256sum "$ARHIIV" > "$ARHIIV.sha256"
    
done

# Hoia alles ainult 3 viimast koopiat iga kasutaja kohta
cd "$VARU_KATALOOG"
ls -1t *.tar.gz 2>/dev/null | awk -F_ '{print $1}' | uniq | while read kasutaja; do
    ls -1t ${kasutaja}_*.tar.gz | tail -n +4 | xargs -r rm -f
done

# Logi lõpp
echo "[ $(date '+%F %T') ] VARUNDAMINE LÕPPES" >> "$LOGIFAIL"
