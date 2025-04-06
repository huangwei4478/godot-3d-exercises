@tool

class_name TriggerTest
extends Area3D

func _init() -> void:
	connect("body_entered", _on_ent_entered)

func _on_ent_entered(ent: Node) -> void:
	print("Hello world from Trenchbroom!")
