extends Node
## Minimalny fundament multiplayer ENet.
## Do publicznej gry potrzebny będzie osiągalny serwer/relay oraz synchronizacja postaci.

signal status_changed(message: String)
const PORT := 2456
const MAX_CLIENTS := 8

func host_game() -> Error:
	var peer := ENetMultiplayerPeer.new()
	var result := peer.create_server(PORT, MAX_CLIENTS)
	if result != OK:
		status_changed.emit("Nie udało się uruchomić serwera: %s" % error_string(result))
		return result
	multiplayer.multiplayer_peer = peer
	status_changed.emit("Serwer uruchomiony na porcie %d" % PORT)
	return OK

func join_game(address: String) -> Error:
	var peer := ENetMultiplayerPeer.new()
	var result := peer.create_client(address.strip_edges(), PORT)
	if result != OK:
		status_changed.emit("Nie udało się połączyć: %s" % error_string(result))
		return result
	multiplayer.multiplayer_peer = peer
	status_changed.emit("Łączenie z %s..." % address)
	return OK

func leave_game() -> void:
	multiplayer.multiplayer_peer = null
	status_changed.emit("Rozłączono")
