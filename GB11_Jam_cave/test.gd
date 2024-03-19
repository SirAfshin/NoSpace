extends Node2D

var tunnelSectionScene = preload("res://Tunnel.tscn")
var player
var tunnelSections = []
var sectionLength = 500  # Adjust as needed
var tunnelScale = 1.0

func _ready():
	player = $Player  # Replace with your player node
	generateInitialTunnel()

func generateInitialTunnel():
	var startPosition = player.position.x
	while startPosition < player.position.x + get_viewport_rect().size.x:
		var section = tunnelSectionScene.instance()
		add_child(section)
		tunnelSections.append(section)
		startPosition += sectionLength

func _process(delta):
	#generateNewSections()
	print($Player.position)
	if $Player.position.x > 155:
		var section = tunnelSectionScene.instance()
		section.position.x = 160
		add_child(section)

func generateNewSections():
	var lastSection = tunnelSections[-1]
	while lastSection.position.x < player.position.x + get_viewport_rect().size.x:
		var newSection = tunnelSectionScene.instance()
		newSection.position.x = lastSection.position.x + sectionLength
		newSection.scale.x = tunnelScale
		add_child(newSection)
		tunnelSections.append(newSection)
		lastSection = newSection

	# Remove sections that are out of view
	for section in tunnelSections:
		if section.position.x + sectionLength < player.position.x - get_viewport_rect().size.x:
			section.queue_free()
			tunnelSections.remove(section)
