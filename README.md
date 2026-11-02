# WIEŚ.EXE 🍞
Mobilna, absurdalna gra 3D o chlebku na polskiej wsi. Godot 4, renderer Compatibility/OpenGL.

## Prototyp 0.2
- Mapa 3D z domami, drogą i drzewami.
- Chlebek z oczami, sterowanie klawiaturą i dotykowym joystickiem.
- Przycisk SKOK.
- Zadanie: zbierz 8 bułek dla babci.
- ENet bootstrap (bez matchmakingu i synchronizacji postaci).

## Otwieranie
Otwórz folder projektu w Godot 4.4 lub nowszym.

## Budowanie APK
Repo zawiera Android export preset i GitHub Actions:
1. Wejdź w Actions.
2. Uruchom Build Android APK przez Run workflow.
3. Po zakończeniu pobierz artefakt wies-exe-android.
Eksport wymaga Android SDK/JDK i zgodnych Android export templates w środowisku CI. Jeśli obraz CI nie ma pasujących szablonów, workflow może wymagać dopasowania.

## Sterowanie
Android: joystick po lewej, SKOK po prawej.
PC: WASD / strzałki i spacja.

## Ograniczenia
To wczesny prototyp. Multiplayer nie ma jeszcze lobby, matchmakingu, synchronizacji graczy ani serwera 24/7. APK nie zostało jeszcze zweryfikowane na urządzeniu.
