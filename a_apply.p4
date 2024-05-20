BOOL_T lstart;

if (hdr.genhdr_uid1.isValid()){
	hdr.genhdr_uid2.setValid();
	#define OUTPUT_HEADER_SIZE 41
	
	BOOL_T l1;
	BOOL_T l2;	
	
	bit<64> start_game;
	bit<64> jog1;
	bit<64> jog2;
	
	start_game = 0x302030203020300A;
	
	bit<96> msg_tmp;
	msg_tmp = 0x48656c6c6f20576f726c6421;
	bit<672> jog_inv;
	jog_inv = 0x696e76616c6964206d6f7665202020202020202020202020202020202020202020202020200A;
	
	bit<672> not_your_turn;
	not_your_turn = (bit<672>) 0x6E6F7420796F7572207475726E0A;

	lstart = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == start_game);

	bit<1> a = 0;
	bit<1> b = 1;
	bit<1> teste;
	checkers_turn.read(teste, 0);
	BOOL_T turn = (BOOL_T)(bit<1>) teste ;
	
	//Verifica se o jogo já foi iniciado
	bit<1> teste_jogo_iniciado;
	jogo_iniciado.read(teste_jogo_iniciado, 0);
	if(teste_jogo_iniciado == 0){
		if(lstart == 1){
			iniciarmapa();
			jogo_iniciado.write(0, 1);
			bit<672> saida;
			gerarsaida(saida);
			hdr.genhdr_uid2.msg_out = saida;
			meta.postprocessing = SENDBACK;
		}
		else{
			//Aviso de precisar começar o jogo
			bit<672> aviso = (bit<672>) 0x796F75206D7573742074797065203020302030203020746F2073746172740A;
			hdr.genhdr_uid2.msg_out = aviso;
			meta.postprocessing = SENDBACK;
		}
	}
	else{
		if(lstart == 1){
			bit<672> saida;
			gerarsaida(saida);
			hdr.genhdr_uid2.msg_out = saida;
			meta.postprocessing = SENDBACK;
		}
		else{
			//Vez das Brancas
			if(turn == 0 ){
				//verificar jogada
				BOOL_T jogada_valida;
				jogada_valida = 0;
				log_msg("Chamou verificar jogada");
				verificarjogada(jogada_valida, hdr.genhdr_uid1.msg_in);
				
				if (jogada_valida == 1) {
					log_msg("Jogada VALIDA");
					jogar(hdr.genhdr_uid1.msg_in);
					bit<672> saida;
					gerarsaida(saida);
					hdr.genhdr_uid2.msg_out = saida;
					checkers_turn.write(0, 1);
				}
				else{
					log_msg("Jogada INVALIDA");
					hdr.genhdr_uid2.msg_out = jog_inv;
					meta.postprocessing = SENDBACK;
				}
			}
			else{
				hdr.genhdr_uid2.msg_out = not_your_turn;
				meta.postprocessing = SENDBACK;
			}
		}
	}
	//Não é a vez
	hdr.genhdr_uid1.setInvalid();
	meta.size_growth = 76;
	meta.size_loss = 0;
	#undef OUTPUT_HEADER_SIZE
}
else{
	if (hdr.genhdr_uid3.isValid()){
		hdr.genhdr_uid2.setValid();
		#define OUTPUT_HEADER_SIZE 41
		BOOL_T l;
	
		bit<64> start_game;
		start_game = 0x302030203020300A;
		
		bit<96> msg_tmp;
		msg_tmp = 0x48656c6c6f20576f726c6421;
		bit<672> jog_inv;
		jog_inv = (bit<672>)0x6A6F6761646120696E76616C696461202020202020202020202020202020202020202020202020200A;
		
		bit<672> not_your_turn;
		not_your_turn = (bit<672>)0x6E6F7420796F7572207475726E0A;
	
		//l = (BOOL_T)(bit<1>)(hdr.genhdr_uid1.msg_in == msg_tmp);
		lstart = (BOOL_T)(bit<1>)(hdr.genhdr_uid3.msg_in == start_game);
		bit<1> a = 0;
		bit<1> b = 1;
		bit<1> teste;
		checkers_turn.read(teste, 0);
		BOOL_T turn = (BOOL_T)(bit<1>) teste ;
		
		//Verifica se o jogo já foi iniciado
		bit<1> teste_jogo_iniciado;
		jogo_iniciado.read(teste_jogo_iniciado, 0);
		
		if(teste_jogo_iniciado == 1){
			if(lstart == 1){
				bit<672> saida;
				gerarsaida(saida);
				hdr.genhdr_uid2.msg_out = saida;
				meta.postprocessing = SENDBACK;
			}
			else{
				//Vez das Pretas
				if(turn == 1 ){
					//verificar jogada
					BOOL_T jogada_valida;
					jogada_valida = 0;
					log_msg("Chamou verificar jogada");
					verificarjogada(jogada_valida, hdr.genhdr_uid3.msg_in);
					if (jogada_valida == 1) {
						log_msg("Jogada VALIDA");
						jogar(hdr.genhdr_uid3.msg_in);
						bit<672> saida;
						gerarsaida(saida);
						hdr.genhdr_uid2.msg_out = saida;
						checkers_turn.write(0, 0);
					}
					else{
						log_msg("Jogada INVALIDA");
						hdr.genhdr_uid2.msg_out = jog_inv;
						meta.postprocessing = SENDBACK;
					}
				}
				else{
					hdr.genhdr_uid2.msg_out = not_your_turn;
					meta.postprocessing = SENDBACK;
				}
			}
		}
		hdr.genhdr_uid3.setInvalid();
		meta.size_growth = 76;
		meta.size_loss = 0;
		#undef OUTPUT_HEADER_SIZE
	}
}

