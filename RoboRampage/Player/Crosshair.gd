@tool
extends Control

func _draw():
	draw_circle(Vector2.ZERO, 5.0, Color.DARK_BLUE)
	draw_circle(Vector2.ZERO, 3.0, Color.AZURE)
	
	draw_line(
		Vector2(16, 0),
		Vector2(24, 0),
		Color.AZURE,
		3
	)
	
	draw_line(
		Vector2(-16, 0),
		Vector2(-24, 0),
		Color.AZURE,
		3
	)
	
	draw_line(
		Vector2(0, 16),
		Vector2(0, 24),
		Color.AZURE,
		3
	)
	
	draw_line(
		Vector2(0, -16),
		Vector2(0, -24),
		Color.AZURE,
		3
	)
