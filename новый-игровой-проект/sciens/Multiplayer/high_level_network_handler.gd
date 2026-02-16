extends Node

const IP_ADDRESS: String = "Localhost"
const PORT: int = 493

var peer: ENetMultiplayerPeer

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer


func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
