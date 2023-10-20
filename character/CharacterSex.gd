extends Resource
class_name CharacterSex
## Updated for Sara stats default vaule for all was 0
@export var blowjob_giver: = 14
@export var blowjob_receiver: =0
@export var handjob_giver: = 20
@export var handjob_receiver: =0
@export var cunnilingus_giver: = 10
@export var cunnilingus_receiver: = 20
@export var rimjob_giver: = 7
@export var rimjob_receiver: = 8
@export var fingering_vagina_giver: = 12
@export var fingering_vagina_receiver: = 26
@export var fingering_anus_giver: = 6
@export var fingering_anus_receiver: = 14
@export var boobjob_giver: = 9
@export var boobjob_receiver: = 0
@export var vaginal_giver: =0
@export var vaginal_receiver: = 9
@export var anal_giver: =0
@export var anal_receiver: = 6
@export var tribbing_giver: = 5
@export var tribbing_receiver: = 5
@export var been_raped: = 1
@export var have_raped: =0
@export var tailjob_giver: =0
@export var tailjob_receiver: =0
@export var ovipositor_giver: =0
@export var ovipositor_receiver: =0
@export var domination: = 30:
	get: return domination
	set(val):
		domination = val
		domination_changed.emit()
@export var submissive: = 30 :
	get: return submissive
	set(val):
		submissive = val
		submissive_changed.emit()
@export var lesbian: = 25:
	get: return lesbian
	set(val):
		lesbian = val
		lesbian_changed.emit()
@export var gay: =0:
	get: return gay
	set(val):
		gay = val
		gay_changed.emit()
@export var bi := 0:
	get: return bi
	set(val):
		bi = val
		bi_changed.emit()
@export var femdom_giver: = 1
@export var femdom_receiver: = 2

signal gay_changed
signal lesbian_changed
signal bi_changed
signal domination_changed
signal submissive_changed

func _to_string():
	return "
CharacterSex Stats {
	Blowjob Giver: {BG}
	Blowjob Receiver: {BR}
	Handjob Giver: {HG}
	Handjob Receiver: {HR}
	Cunnilingus Giver: {CG}
	Cunnilingus Receiver: {CR}
	Rimjob Giver: {RG}
	Rimjob Receiver: {RR}
	Fingering Vagina Giver: {FVG}
	Fingering Vagina Receiver: {FVR}
	Fingering Anus Giver: {FAG}
	Fingering Anus Receiver: {FAR}
	Boobjob Giver: {BbG}
	Boobjob Receiver: {BbR}
	Vaginal Giver: {VG}
	Vaginal Receiver: {VR}
	Anal Giver: {AG}
	Anal Receiver: {AR}
	Tribbing Giver: {TG}
	Tribbing Receiver: {TR}
	Been Raped: {BeR}
	Have Raped: {HaR}
	Tailjob Giver: {TaG}
	Tailjob Receiver: {TaR}
	Ovipositor Giver: {OG}
	Ovipositor Receiver: {OR}
	Domination: {D}
	Submissive: {S}
	Lesbian: {L}
	Gay: {G}
	Bi: {B}
	Femdom Giver: {FG}
	Femdom Receiver: {FR}
}".format({
	"BG": self.blowjob_giver,
	"BR": self.blowjob_receiver,
	"HG": self.handjob_giver,
	"HR": self.handjob_receiver,
	"CG": self.cunnilingus_giver,
	"CR": self.cunnilingus_receiver,
	"RG": self.rimjob_giver,
	"RR": self.rimjob_receiver,
	"FVG": self.fingering_vagina_giver,
	"FVR": self.fingering_vagina_receiver,
	"FAG": self.fingering_anus_giver,
	"FAR": self.fingering_anus_receiver,
	"BbG": self.boobjob_giver,
	"BbR": self.blowjob_receiver,
	"VG": self.vaginal_giver,
	"VR": self.vaginal_receiver ,
	"AG": self.anal_giver ,
	"AR": self.anal_receiver ,
	"TG": self.tribbing_giver ,
	"TR": self.tribbing_receiver ,
	"BeR": self.been_raped ,
	"HaR": self.have_raped ,
	"TaG": self.tailjob_giver ,
	"TaR": self.tailjob_receiver ,
	"OG": self.ovipositor_giver ,
	"OR": self.ovipositor_receiver ,
	"D": self.domination ,
	"S": self.submissive ,
	"L": self.lesbian ,
	"G": self.gay ,
	"B": self.bi ,
	"FG": self.femdom_giver ,
	"FR": self.femdom_receiver ,
})

func set_default(res: CharacterStats):
	match res.sex_ori:
		CharacterStats.SEXORI.GAY:
			gay = randi_range(70,100)
		CharacterStats.SEXORI.LESBIAN:
			lesbian = randi_range(60,100)
		CharacterStats.SEXORI.BI:
			bi = randf_range(30, max(gay,lesbian))
		CharacterStats.SEXORI.DOMINATE:
			domination = randi_range(70,100)
		CharacterStats.SEXORI.SUBMISSIVE:
			submissive = randi_range(70,100)
	
	print_debug("Here is a good place to connect signals")
