class_name Character extends Control

@onready var panel_container = $PanelContainer
@onready var char_name = $CharName
@onready var view_option:OptionButton = $HBoxContainer/ViewOption
@onready var health_bar = $HBoxContainer/HealthBar

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
#	make_character("Drac", CharacterStats.GENDER.MALE, CharacterStats.TYPES.NPC)

## create and add character sprite in node.
## `Note:` Make sure to run this function after instance is added to scene try
func make_character(_name: StringName, _gender: CharacterStats.GENDER, type: CharacterStats.TYPES) -> void:
	res = CharacterMod.new()
	connect_char_signal()
	res.genrate_stats(_name, _gender, type)
	res.load_config(G.mod_player_selected)
	res.add_base_mod()
	res.add_tags()
	
	character_made.emit()

func save_data():
	pass

func connect_char_signal():
	if !res:
		return
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
	$SC/Diss/Gender.text = "Gender: %s"%CharacterStats.GENDER.find_key(res.gender)

func _discription_update_race():
	$SC/Diss/Race.text = "Race: %s"%CharacterStats.RACE.find_key(res.race)

func _discription_update_role():
	$SC/Diss/Role.text = "Role: %s"%CharacterStats.ROLES.find_key(res.role)

func _discription_update_job():
	$SC/Diss/Job.text = "Job: %s"%res.job.get_job_name()

func _discription_update_attack():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$SC/Diss/Attack.text = "Attack: %s"%"?"
		return
	$SC/Diss/Attack.text = "Attack: %s"%res.attack

func _discription_update_strength():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$SC/Diss/Strength.text = "Strength: %s"%"?"
		return
	$SC/Diss/Strength.text = "Strength: %s"%res.strength

func _discription_update_defense():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$SC/Diss/Defense.text = "Defense: %s"%"?"
		return
	$SC/Diss/Defense.text = "Defense: %s"%res.defense

func _discription_update_agility():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$SC/Diss/Agility.text = "Agility: %s"%"?"
		return
	$SC/Diss/Agility.text = "Agility: %s"%res.agility

func _discription_update_intelligence():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$SC/Diss/Intelligence.text = "Intelligence: %s"%"?"
		return
	$SC/Diss/Intelligence.text = "Intelligence: %s"%res.intelligence

func _discription_update_magicpower():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 40:
		$SC/Diss/MagicPower.text = "Magic Power: %s"%"?"
		return
	$SC/Diss/MagicPower.text = "Magic Power: %s"%res.magic_power

func _discription_update_rolereputation():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 70:
		$SC/Diss/RoleReputation.text = "Role Reputation:: %s"%"?"
		return
	$SC/Diss/RoleReputation.text = "Role Reputation: %s"%res.role_reputation

func _discription_update_fertility():
	if res.gender == CharacterStats.GENDER.MALE:
		$SC/Diss/Fertility.visible = false
		return
	$SC/Diss/Fertility.visible = true
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 80:
		$SC/Diss/Fertility.text = "Fertility: %s"%"?"
		return
	$SC/Diss/Fertility.text = "Fertility: %s"%res.fertility

func _discription_update_virility():
	if res.gender == CharacterStats.GENDER.MALE:
		$SC/Diss/Virility.visible = false
		return
	$SC/Diss/Virility.visible = true
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 80:
		$SC/Diss/Virility.text = "Virility: %s"%"?"
		return
	$SC/Diss/Virility.text = "Virility: %s"%res.virility

func _discription_update_pregnancy():
	if res.gender == CharacterStats.GENDER.MALE :
		$SC/Diss/Pregnancy.visible=false
		return
	if not res.pregnancy :
		$SC/Diss/Pregnancy.visible=false
		return
	$SC/Diss/Pregnancy.visible=true
	$SC/Diss/Pregnancy.text = "Pregnancy: %s"%res.pregnancy
	$SC/Diss/Pregnancy/PregnancyDuration.text = "Pregnancy Duration: %s"%res.pregnancy_duration

func _discription_update_rwp():
	if res.type == CharacterStats.TYPES.PLAYER:
		$SC/Diss/RelationshipWithPlayer.visible = false
	$SC/Diss/RelationshipWithPlayer.visible = true
	$SC/Diss/RelationshipWithPlayer.text = "Relationship With Player: %s"%res.relationship_with_player

func _discription_update_depositableeggs():
	if res.race == CharacterStats.RACE.MOTHKIN:
		$SC/Diss/DepositableEggs.visible = true
		if res.type == CharacterStats.TYPES.NPC:
			$SC/Diss/DepositableEggs.text = "Depositable Eggs: ?"
			return
		$SC/Diss/DepositableEggs.text = "Depositable Eggs: %s"%res.depositable_eggs
	$SC/Diss/DepositableEggs.visible = false

#func _discription_update_eggsduration():
#	if res.eggs_in_ass or res.eggs_in_vagina:
#		if res.relationship_with_player < 50:
#			$SC/Diss/EggsDuration.text = "Eggs Duration: ?"
#			$SC/Diss/EggsDuration/EggsInVagina.visible = false
#			$SC/Diss/EggsDuration/EggsInAss.visible = false
#			return
#		$SC/Diss/EggsDuration.text = "Eggs Duration: %s"%res.eggs_duration
#		if res.eggs_in_vagina:
#			$SC/Diss/EggsDuration/EggsInVagina.visible = true
#			$SC/Diss/EggsDuration/EggsInVagina.text = "Eggs In Vagina"%res.eggs_in_vagina
#		if res.eggs_in_ass:
#			$SC/Diss/EggsDuration/EggsInAss.visible = true
#			$SC/Diss/EggsDuration/EggsInAss.text = "Eggs In Ass"%res.eggs_in_ass
#		return
#	$SC/Diss/EggsDuration.visible = false
#	return
#	if not res.eggs_duration or res.relationship_with_player < 50:
#		$SC/Diss/EggsDuration.visible = false
#		return
#	$SC/Diss/EggsDuration.visible = true
#	$SC/Diss/EggsDuration.text = "Eggs Duration: %s"%res.eggs_duration
#	if res.gender == CharacterStats.GENDER.MALE and not res.eggs_in_vagina:
#		$SC/Diss/EggsDuration/EggsInVagina.visible = false
#		$SC/Diss/EggsDuration/EggsInVaginaDuration.visible = false
#	$SC/Diss/EggsDuration/EggsInVagina.visible = true
#	$SC/Diss/EggsDuration/EggsInVagina.text = "Eggs In Vagina"%res.eggs_in_vagina
#	$SC/Diss/EggsDuration/EggsInVaginaDuration.visible = true
#	$SC/Diss/EggsDuration/EggsInVaginaDuration.text = "Eggs In Vagina Duration"%res.eggs_in_ass_duration
	
#	if res.eggs_in_ass:
#		$SC/Diss/EggsDuration/EggsInAss.visible = true
#		$SC/Diss/EggsDuration/EggsInAss.text = "Eggs In Ass %s"%res.eggs_in_ass
#		$SC/Diss/EggsDuration/EggsInAssDuration.visible = true
#		$SC/Diss/EggsDuration/EggsInAssDuration.text = "Eggs In Ass Duration %s"%res.eggs_in_ass_duration
#

func _discription_update_eggsduration():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 50:
		$SC/Diss/EggsInVagina.text = "Eggs In Vagina: ?"
		$SC/Diss/EggsInVaginaDuration.text = "Eggs In Vagina Duration: ?"
		$SC/Diss/EggsInAss.text = "Eggs In Ass: ?"
		$SC/Diss/EggsInAssDuration.text = "Eggs In Ass Duration: ?"
		return
	
	$SC/Diss/EggsInVagina.text = "Eggs In Vagina: %s"%res.eggs_in_vagina
	$SC/Diss/EggsInVaginaDuration.text = "Eggs In Vagina Duration: %s"%res.eggs_in_vagina_duration
	$SC/Diss/EggsInAss.text = "Eggs In Ass: %s"%res.eggs_in_ass
	$SC/Diss/EggsInAssDuration.text = "Eggs In Ass Duration: %s"%res.eggs_in_ass_duration
	

func _discription_update_children():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 70:
		$SC/Diss/Children.text = "Children: %s"%"?"
		return
	$SC/Diss/Children.text = "Children: %s"%res.children

func _discription_update_monsterchildren():
	if res.type == CharacterStats.TYPES.NPC and res.relationship_with_player < 70:
		$SC/Diss/MonsterChildren.text = "Monster Children: %s"%"?"
		return
	$SC/Diss/MonsterChildren.text = "Monster Children: %s"%res.monster_children
