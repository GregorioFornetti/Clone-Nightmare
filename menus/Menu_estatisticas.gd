extends Control


func _ready():
	var tabela_info = $ScrollContainer/GridContainer
	var info_atual
	var dic_total = {"tentativas": 0, "derrotas": 0, "tempoGasto": 0, "melhorTempo": 0}
	var atributos_comuns = ["tentativas", "derrotas"]  # Atributos que não precisam de uma lógica para display
	var atributos_tempo = ["tempoGasto", "melhorTempo"]
	
	for i in range(1, 21):
		info_atual = SaveStats.dados_save["fase" + str(i)]
		
		for atributo in dic_total.keys():
			dic_total[atributo] += info_atual[atributo]
		
		for atributo in atributos_comuns:
			tabela_info.get_node("Lbl_" + str(atributo) + "_" + str(i)).text = str(info_atual[atributo])
		for atributo in atributos_tempo:
			if info_atual[atributo]:
				tabela_info.get_node("Lbl_" + str(atributo) + "_" + str(i)).text = ComandosGerais.formatar_tempo(info_atual[atributo])
			else:
				tabela_info.get_node("Lbl_" + str(atributo) + "_" + str(i)).text = "XX:XX"
	
	for atributo in atributos_comuns:
		tabela_info.get_node("Lbl_" + str(atributo) + "Geral").text = str(dic_total[atributo])
	for atributo in atributos_tempo:
		if dic_total[atributo]:
			tabela_info.get_node("Lbl_" + str(atributo) + "Geral").text = ComandosGerais.formatar_tempo(dic_total[atributo])
		else:
			tabela_info.get_node("Lbl_" + str(atributo) + "Geral").text = "XX:XX"
