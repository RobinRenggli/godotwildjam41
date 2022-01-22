extends Area2D

func _on_Stats_full_health():
	var mask = get_collision_mask()
	mask = disable_bit(mask, 6)
	set_collision_mask(mask)

func _on_Stats_not_full_health():
	var mask = get_collision_mask()
	mask = enable_bit(mask, 6)
	set_collision_mask(mask)
	
func enable_bit(mask: int, index: int) -> int:
	return mask | (1 << index)
	
func disable_bit(mask: int, index: int) -> int:
	return mask & ~(1 << index)
