extends Timer

func _ready():
	self.wait_time = Global.reloadSpeed
	
func _process(delta):
	self.wait_time = Global.reloadSpeed
