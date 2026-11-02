# WIEŚ.EXE 🍞

Polski, absurdalny sandbox 3D. Chlebek, wieś, dziwne zadania i fizyka.

## Status
**Prototyp 0.1:** bazowy świat 3D, sterowanie WASD, skok, proste domy i drzewa. Projekt jest na wczesnym etapie. APK nie jest jeszcze zbudowane.

## Uruchomienie
1. Zainstaluj Godot 4.3 lub nowszy.
2. Otwórz plik project.godot.
3. Uruchom projekt (F6/F5).

Renderer: Godot Compatibility / OpenGL, wybrany z myślą o słabszych urządzeniach i Androidzie.

## Sterowanie
- WASD: ruch
- Spacja: skok

## Multiplayer
Plik scripts/network.gd zawiera bazowy host/join przez ENet. To jeszcze nie jest gotowy matchmaking. Do publicznej gry potrzebny będzie osiągalny serwer/relay oraz synchronizacja postaci, świata i zabezpieczenia.

## Plan
- [x] Pierwszy szkielet świata 3D
- [x] Postać chlebka i podstawowy ruch
- [x] Fundament połączeń ENet
- [ ] Kamera i sterowanie dotykowe Android
- [ ] Interakcje, zadania i NPC
- [ ] Synchronizacja multiplayer i lobby
- [ ] Eksport APK oraz testy na telefonach

## Zawartość repo
Oryginalny plik AstralSwords Texture Pack.zip pozostaje zachowany.
