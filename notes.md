# Organização NEANDER

## TODO

* [ ] ATIVIDADE 04 rushar

### Modulo - ULA

* reg AC
	* sinal (~r)w para ~leitura/escrita
	* sinais de controle clk e cl
	* sinal de dados de entrada data_in com 8 bits
	* sinal de dados de entrada data_out com 8 bits
* reg flags
	* registrador com sinal de carga para palavras de 2 bits
	* sinais de controle e dados iguais ao reg ac
	* OBS: Sempre eh carregado quando AC eh carregado, sinal de controle ~r/w eh compartilhado entre AC e FLAGS
* ULA
	* componente que executa as operações logicas e operação aritmetica
	* entradas:
		* dados `x` e `y` com 8 bits
		* controle `ULA_op` com 3 bits que determinan operação
	* saidas:
		* dados `s` com 8 bits e estados `NZ` com 2 bits
	* armadilha in-out
	* instruções bidirecionais
		* MEM -> ULA: LDA, ADD, AND, OR
		* ULA -> MEM: STA

### Modulo - Memoria

### Modulo - Controle
