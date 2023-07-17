class_name Character extends Control

@onready var panel_container = $VBoxContainer/PanelContainer
@onready var char_name = $VBoxContainer/HBoxContainer/CharName
@onready var view_option:OptionButton = $VBoxContainer/HBoxContainer/ViewOption
@onready var health_bar = $VBoxContainer/HealthBar

signal character_made

var res: CharacterMod = null
#var char_node: Control = null

func _ready():
	character_made.connect(_add_char_details)
	view_option.item_selected.connect(func(index:int): res.view = index)
	view_option.add_item("Front")
	view_option.add_item("Side")
	view_option.add_item("Back")
	health_bar.value_changed.connect(func(val): res.health = val)
	
	# Remove this line after debug
#	make_character("Drac",CharacterStats.TYPES.NPC)

## create and add character sprite in node.
## `Note:` Make sure to run this function after instance is added to scene try
func make_character(_name: StringName, type: CharacterStats.TYPES) -> void:
	res = CharacterMod.new()
	connect_char_signal()
	res.genrate_stats(_name,type)
	res.load_config(G.mod_player_selected)
	res.add_base_mod()
	res.add_tags()
	
	character_made.emit()

func save_data():
	pass

func connect_char_signal():
	if !res:
		return
	print_debug("In connect char signal function")
	res.attack_changed.connect(_discription_update_attack)
	res.strength_changed.connect(_discription_update_strength)
	res.defense_changed.connect(_discription_update_defense)
	res.agility_changed.connect(_discription_update_agility)
	res.intelligence_changed.connect(_discription_update_intelligence)
	res.magic_power_changed.connect(_discription_update_magicpower)
	res.role_reputation_changed.connect(_discription_update_rolereputation)
	res.fertility_changed.connect(_discription_update_fertility)
	res.virility_changed.connect(_discription_update_virility)
	res.pregnancy_changed.connect(_discription_update_pregnancy)
	res.pregnancy_duration_changed.connect(_discription_update_pregnancy)
	res.relationship_with_player_changed.connect(func():
		_discription_update_rwp()
		_discription_update_attack()
		_discription_update_strength()
		_discription_update_defense()
		_discription_update_agility()
		_discription_update_intelligence()
		_discription_update_magicpower()
		_discription_update_rolereputation()
		_discription_update_fertility()
		_discription_update_virility()
		_discription_update_pregnancy()
		_discription_update_children()
		_discription_update_monsterchildren()
		_discription_update_eggsduration()
		)
	res.depositable_eggs_changed.connect(_discription_update_depositableeggs)
#	res.eggs_duration_changed.connect(_discription_update_eggsduration)
	res.eggs_in_vagina_changed.connect(_discription_update_eggsduration)
	res.eggs_in_vagina_duration_changed.connect(_discription_update_eggsduration)
	res.eggs_in_ass_changed.connect(_discription_update_eggsduration)
	res.eggs_in_ass_duration_changed.connect(_discription_update_eggsduration)
	res.children_changed.connect(_discription_update_children)
	res.monster_children_changed.connect(_discription_update_monsterchildren)

func _add_char_details():
	for sprite in res.base_sprites:
		var sp: Sprite2D = res.base_sprites[sprite]
		sp.position.x = 75
		panel_container.add_child(sp)
	view_option.select(0)
	char_name.text = res.name
	health_bar.value = res.health
	_discription_update_gender()
	_discription_update_race()
	_discription_update_role()
	_discription_update_job()

func _discription_update_gender():
	$VBoxContainer/SC/Diss/Gender.text = "Gender: %s"%CharacterStats.GENDER.find_key(res.gender)

func _discription_update_race():
	$VBoxContainer/SC/Diss/Race.text = "Race: %s"%CharacterStats.RACE.find_key(res.race)

func _discription_update_role():
	$VBoxContainer/SC/Diss/Role.text = "Role: %s"%CharacterStats.ROLES.find_key(res.role)

func _discription_update_job():
	$VBoxContainer/SC/Diss/Job.text = "Job: %s"%res.job.get_job_name()

func _discription_update_attack():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$VBoxContainer/SC/Diss/Attack.text = "Attack: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Attack.text = "Attack: %s"%res.attack

func _discription_update_strength():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$VBoxContainer/SC/Diss/Strength.text = "Strength: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Strength.text = "Strength: %s"%res.strength

func _discription_update_defense():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$VBoxContainer/SC/Diss/Defense.text = "Defense: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Defense.text = "Defense: %s"%res.defense

func _discription_update_agility():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$VBoxContainer/SC/Diss/Agility.text = "Agility: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Agility.text = "Agility: %s"%res.agility

func _discription_update_intelligence():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$VBoxContainer/SC/Diss/Intelligence.text = "Intelligence: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Intelligence.text = "Intelligence: %s"%res.intelligence

func _discription_update_magicpower():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$VBoxContainer/SC/Diss/MagicPower.text = "Magic Power: %s"%"?"
		return
	$VBoxContainer/SC/Diss/MagicPower.text = "Magic Power: %s"%res.magic_power

func _discription_update_rolereputation():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 70:
		$VBoxContainer/SC/Diss/RoleReputation.text = "Role Reputation:: %s"%"?"
		return
	$VBoxContainer/SC/Diss/RoleReputation.text = "Role Reputation: %s"%res.role_reputation

func _discription_update_fertility():
	if res.gender == CharacterStats.GENDER.MALE:
		$VBoxContainer/SC/Diss/Fertility.visible = false
		return
	$VBoxContainer/SC/Diss/Fertility.visible = true
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 80:
		$VBoxContainer/SC/Diss/Fertility.text = "Fertility: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Fertility.text = "Fertility: %s"%res.fertility

func _discription_update_virility():
	if res.gender == CharacterStats.GENDER.MALE:
		$VBoxContainer/SC/Diss/Virility.visible = false
		return
	$VBoxContainer/SC/Diss/Virility.visible = true
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 80:
		$VBoxContainer/SC/Diss/Virility.text = "Virility: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Virility.text = "Virility: %s"%res.virility

func _discription_update_pregnancy():
	if res.gender == CharacterStats.GENDER.MALE :
		$VBoxContainer/SC/Diss/Pregnancy.visible=false
		return
	if not res.pregnancy :
		$VBoxContainer/SC/Diss/Pregnancy.visible=false
		return
	$VBoxContainer/SC/Diss/Pregnancy.visible=true
	$VBoxContainer/SC/Diss/Pregnancy.text = "Pregnancy: %s"%res.pregnancy
	$VBoxContainer/SC/Diss/Pregnancy/PregnancyDuration.text = "Pregnancy Duration: %s"%res.pregnancy_duration

func _discription_update_rwp():
	if res.type == CharacterStats.TYPES.PLAYER:
		$VBoxContainer/SC/Diss/RelationshipWithPlayer.visible = false
	$VBoxContainer/SC/Diss/RelationshipWithPlayer.visible = true
	$VBoxContainer/SC/Diss/RelationshipWithPlayer.text = "Relationship With Player: %s"%res.relationship_with_player

func _discription_update_depositableeggs():
	if res.race == CharacterStats.RACE.MOTHKIN:
		$VBoxContainer/SC/Diss/DepositableEggs.visible = true
		if res.type == CharacterStats.TYPES.NPC:
			$VBoxContainer/SC/Diss/DepositableEggs.text = "Depositable Eggs: ?"
			return
		$VBoxContainer/SC/Diss/DepositableEggs.text = "Depositable Eggs: %s"%res.depositable_eggs
	$VBoxContainer/SC/Diss/DepositableEggs.visible = false

#func _discription_update_eggsduration():
#	if res.eggs_in_ass or res.eggs_in_vagina:
#		if res.relationship_with_player < 50:
#			$VBoxContainer/SC/Diss/EggsDuration.text = "Eggs Duration: ?"
#			$VBoxContainer/SC/Diss/EggsDuration/EggsInVagina.visible = false
#			$VBoxContainer/SC/Diss/EggsDuration/EggsInAss.visible = false
#			return
#		$VBoxContainer/SC/Diss/EggsDuration.text = "Eggs Duration: %s"%res.eggs_duration
#		if res.eggs_in_vagina:
#			$VBoxContainer/SC/Diss/EggsDuration/EggsInVagina.visible = true
#			$VBoxContainer/SC/Diss/EggsDuration/EggsInVagina.text = "Eggs In Vagina"%res.eggs_in_vagina
#		if res.eggs_in_ass:
#			$VBoxContainer/SC/Diss/EggsDuration/EggsInAss.visible = true
#			$VBoxContainer/SC/Diss/EggsDuration/EggsInAss.text = "Eggs In Ass"%res.eggs_in_ass
#		return
#	$VBoxContainer/SC/Diss/EggsDuration.visible = false
#	return
#	if not res.eggs_duration or res.relationship_with_player < 50:
#		$VBoxContainer/SC/Diss/EggsDuration.visible = false
#		return
#	$VBoxContainer/SC/Diss/EggsDuration.visible = true
#	$VBoxContainer/SC/Diss/EggsDuration.text = "Eggs Duration: %s"%res.eggs_duration
#	if res.gender == CharacterStats.GENDER.MALE and not res.eggs_in_vagina:
#		$VBoxContainer/SC/Diss/EggsDuration/EggsInVagina.visible = false
#		$VBoxContainer/SC/Diss/EggsDuration/EggsInVaginaDuration.visible = false
#	$VBoxContainer/SC/Diss/EggsDuration/EggsInVagina.visible = true
#	$VBoxContainer/SC/Diss/EggsDuration/EggsInVagina.text = "Eggs In Vagina"%res.eggs_in_vagina
#	$VBoxContainer/SC/Diss/EggsDuration/EggsInVaginaDuration.visible = true
#	$VBoxContainer/SC/Diss/EggsDuration/EggsInVaginaDuration.text = "Eggs In Vagina Duration"%res.eggs_in_ass_duration
	
#	if res.eggs_in_ass:
#		$VBoxContainer/SC/Diss/EggsDuration/EggsInAss.visible = true
#		$VBoxContainer/SC/Diss/EggsDuration/EggsInAss.text = "Eggs In Ass %s"%res.eggs_in_ass
#		$VBoxContainer/SC/Diss/EggsDuration/EggsInAssDuration.visible = true
#		$VBoxContainer/SC/Diss/EggsDuration/EggsInAssDuration.text = "Eggs In Ass Duration %s"%res.eggs_in_ass_duration
#

func _discription_update_eggsduration():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 50:
		$VBoxContainer/SC/Diss/EggsInVagina.text = "Eggs In Vagina: ?"
		$VBoxContainer/SC/Diss/EggsInVaginaDuration.text = "Eggs In Vagina Duration: ?"
		$VBoxContainer/SC/Diss/EggsInAss.text = "Eggs In Ass: ?"
		$VBoxContainer/SC/Diss/EggsInAssDuration.text = "Eggs In Ass Duration: ?"
		return
	
	$VBoxContainer/SC/Diss/EggsInVagina.text = "Eggs In Vagina: %s"%res.eggs_in_vagina
	$VBoxContainer/SC/Diss/EggsInVaginaDuration.text = "Eggs In Vagina Duration: %s"%res.eggs_in_vagina_duration
	$VBoxContainer/SC/Diss/EggsInAss.text = "Eggs In Ass: %s"%res.eggs_in_ass
	$VBoxContainer/SC/Diss/EggsInAssDuration.text = "Eggs In Ass Duration: %s"%res.eggs_in_ass_duration
	

func _discription_update_children():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 70:
		$VBoxContainer/SC/Diss/Children.text = "Children: %s"%"?"
		return
	$VBoxContainer/SC/Diss/Children.text = "Children: %s"%res.children

func _discription_update_monsterchildren():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 70:
		$VBoxContainer/SC/Diss/MonsterChildren.text = "Monster Children: %s"%"?"
		return
	$VBoxContainer/SC/Diss/MonsterChildren.text = "Monster Children: %s"%res.monster_children
