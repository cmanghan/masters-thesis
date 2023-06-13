extends Control


func _ready():
	MainMusicController.play_music()
	
	$CreditsBody.set_text("Hallway, Bedroom, and Classroom images courtesy of: \n https://www.freepik.com/vectors/school'>School vector created by upklyak - www.freepik.com \n\nLocker Room imgae courtesy of:\n https://www.freepik.com/vectors/sports'>Sports vector created by brgfx - www.freepik.com \n\nForest Background courtesy of: https://digitalmoons.itch.io/parallax-forest-background?download \n\nSports Equipment images courtesy of:\n http://clipart-library.com/clipart/432135.htm \n http://clipart-library.com/clipart/k8TxjpRip.htm \n\nPhone clipart courtesy of: \n http://clipart-library.com/clipart/gTeEKy4xc.htm\n http://clipart-library.com/clipart/gTeEKy4xc.htm\n\nFireworks courtesy of: \nhttps://www.pikpng.com/downpngs/hihiTxJ_fireworks-circle-clipart/ \n\nBanner courtesy of: \nhttps://pngtree.com/so/yellow'>yellow png from pngtree.com \n\nFonts courtesy of: \n www.download-free-fonts.com \n Kenney.nl \n\nBully Blob assets & music courtesy of: \n Kenney.nl\n\nBackground, Platforms, & GUI elements courtesy of: \n FANTASY PLATFORMER GAME KIT PIXEL ART https://craftpix.net/product/fantasy-platformer-game-kit-pixel-art/\n\nDragon art courtesy of: \n https://cubebrush.co/mikailain/products/xihynq/purple-dragon-game-sprites by Mahmud Fajar \n\nCharacter art designed using:\n Fantasy Heroes: Character Editor by hippogames")

func _on_MainMenu_pressed():
		get_tree().change_scene_to_file("res://TitleMenu.tscn")

