extends ConfirmationDialog


func _projectcreator() -> void:
	popup_centered(G.TEST_POPUP_AREA)


func _ready() -> void:
	yield(get_tree(), "idle_frame")
	popup_centered(G.TEST_POPUP_AREA)
	_create_option_list()
	

class Template:
	var x: int
	var y: int
	var name: String

	func _init(_x: int, _y: int, _name : String = "") -> void:
		x = _x
		y = _y
		name = _name

# An array that holds objects made using the class Template.
var templates := [
	# Basic
	Template.new(16, 16),
	Template.new(32, 32),
	Template.new(64, 64),
	Template.new(128, 128),
	# Nintendo
	Template.new(160, 144, "GB"),
	Template.new(240, 160, "GBA"),
	Template.new(256, 224, "NES (NTSC)"),
	Template.new(256, 240, "NES (PAL)"),
	Template.new(512, 448, "SNES (NTSC)"),
	Template.new(512, 480, "SNES (PAL)"),
	Template.new(646, 486, "N64 (NTSC)"),
	Template.new(786, 576, "N64 (PAL)"),
	# Sega
	Template.new(256, 192, "SMS (NTSC)"),
	Template.new(256, 224, "SMS (PAL)"),
	Template.new(160, 144, "GG"),
	Template.new(320, 224, "MD (NTSC)"),
	Template.new(320, 240, "MD (PAL)"),
	# NEC
	Template.new(256, 239, "PC Engine"),  #256×224 to 512×242 (mostly 256×239)
	# DOS
	Template.new(320, 200, "DOS EGA"),
	Template.new(320, 200, "DOS VGA"),
	Template.new(620, 480, "DOS SVGA"),
	Template.new(640, 200, "DOS CGA (2-Colour)"),
	Template.new(320, 200, "DOS CGA (4-Colour)"),
	Template.new(160, 240, "DOS CGA (Composite)"),
	Template.new(160, 240, "Tandy"),
	# Commodore
	Template.new(320, 200, "Amiga OCS LowRes (NTSC)"),
	Template.new(320, 256, "Amiga OCS LowRes (PAL)"),
	Template.new(640, 200, "Amiga OCS HiRes  (NTSC)"),
	Template.new(640, 256, "Amiga OCS HiRes  (PAL)"),
	Template.new(1280, 200, "Amiga ECS Super-HiRes  (NTSC)"),
	Template.new(1280, 256, "Amiga ECS SuperHiRes  (PAL)"),
	Template.new(640, 480, "Amiga ECS Multiscan"),
	Template.new(320, 200, "C64"),
	# Sinclair
	Template.new(256, 192, "ZX Spectrum"),
]


onready var PRESET_OPTIONS := $"VBC/ProjectPresets/PresetOptions"
func _create_option_list() -> void:
	var i := 1
	for template in templates:
		if template.name != "":
			PRESET_OPTIONS.add_item(
				"{width} x {height} - {name}".format( { "width": template.x, "height": template.y, "name": template.name }),
				i
			)
		else:
			PRESET_OPTIONS.add_item(
				"{width} x {height}".format({"width": template.x, "height": template.y}),
				i
			)
		i += 1

onready var VALUE_X : = $"VBC/ManualSize/size_x/value" as SpinBox
onready var VALUE_Y : = $"VBC/ManualSize/size_y/value" as SpinBox
onready var PROJECT_PRESET_OPTIONS : = $"VBC/ProjectPresets/PresetOptions"
onready var PROJECT_PRESET_MODE : = $"VBC/ProjectPresets/PresetMode"

func _on_PresetOptions_item_selected(index: int) -> void:
	match PROJECT_PRESET_MODE.selected:
		0:
			if templates[index].x >= templates[index].y:
				_keep(index)
			else:
				_flip(index)
		1:
			if templates[index].x >= templates[index].y:
				_flip(index)
			else:
				_keep(index)

func _keep(index: int) -> void:
	VALUE_X.value = templates[index].x
	VALUE_Y.value = templates[index].y
	
func _flip(index: int) -> void:
	VALUE_X.value = templates[index].y
	VALUE_Y.value = templates[index].x


func _on_PresetMode_item_selected(_index: int) -> void:
#	meaning if option not is unselected.
#	i.e. if an option is selected
	if PROJECT_PRESET_OPTIONS.selected != -1: 
		_on_PresetOptions_item_selected(PROJECT_PRESET_OPTIONS.selected)
		

onready var SCREEN := $"../../System/ViewContainer/Viewport/Screen" as Node2D
onready var RESOLUTION := $"../Bar/Resolution" as Label
onready var VIEW := $"../../System/ViewContainer/Viewport/view" as Camera2D

func _on_ProjectCreator_confirmed() -> void:
	print("ProjectCreator at flaut here.")
	SCREEN.img_storage = Image.new()
	SCREEN.img_storage.create(VALUE_X.value, VALUE_Y.value, false, Image.FORMAT_RGBA8)
	SCREEN.img_storage.lock()
	SCREEN.update()
#	Recalculate the screen rect, based on the loaded pic, that is being used as a boundry for the input i.e. cross to draw in.
	G.stored_img_x = SCREEN.img_storage.get_size().x
	G.stored_img_y = SCREEN.img_storage.get_size().y
	SCREEN.update_screen_rect()
	RESOLUTION.update_info()
#	reactivatie the screen and textedit
#	SCREEN.create_mode(7) # DELETE the signal does the job better
	VIEW.reset_zoom()



