
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Game.c,72 :: 		void interrupt(){
;Game.c,73 :: 		if(INTCON.INTF == 1 ){
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;Game.c,75 :: 		if( PORTD.F0)
	BTFSS      PORTD+0, 0
	GOTO       L_interrupt1
;Game.c,77 :: 		if(current_t == 0x00) Tank_Ptr = &t1;
	MOVF       _current_t+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
	MOVLW      _t1+0
	MOVWF      _Tank_Ptr+0
L_interrupt2:
;Game.c,78 :: 		if(current_t == 0xff) Tank_Ptr = &t2;
	MOVF       _current_t+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
	MOVLW      _t2+0
	MOVWF      _Tank_Ptr+0
L_interrupt3:
;Game.c,80 :: 		if(current_m == 0x00) Tank_Ptr->gun_angle ++;
	MOVF       _current_m+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	GOTO       L_interrupt5
L_interrupt4:
;Game.c,81 :: 		else Tank_Ptr->gun_power ++;
	MOVLW      11
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
L_interrupt5:
;Game.c,83 :: 		}
L_interrupt1:
;Game.c,84 :: 		if( PORTD.F1)
	BTFSS      PORTD+0, 1
	GOTO       L_interrupt6
;Game.c,87 :: 		if(current_t == 0x00) Tank_Ptr = &t1;
	MOVF       _current_t+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
	MOVLW      _t1+0
	MOVWF      _Tank_Ptr+0
L_interrupt7:
;Game.c,88 :: 		if(current_t == 0xff) Tank_Ptr = &t2;
	MOVF       _current_t+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt8
	MOVLW      _t2+0
	MOVWF      _Tank_Ptr+0
L_interrupt8:
;Game.c,90 :: 		if(current_m == 0x00)Tank_Ptr->gun_angle --;
	MOVF       _current_m+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt9
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      1
	SUBWF      R0+0, 1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	GOTO       L_interrupt10
L_interrupt9:
;Game.c,91 :: 		else Tank_Ptr->gun_power --;
	MOVLW      11
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVLW      1
	SUBWF      R0+0, 1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
L_interrupt10:
;Game.c,93 :: 		}
L_interrupt6:
;Game.c,94 :: 		if( PORTD.F2)
	BTFSS      PORTD+0, 2
	GOTO       L_interrupt11
;Game.c,96 :: 		current_m = ~current_m;
	COMF       _current_m+0, 1
;Game.c,97 :: 		}
L_interrupt11:
;Game.c,98 :: 		if( PORTD.F3)
	BTFSS      PORTD+0, 3
	GOTO       L_interrupt12
;Game.c,101 :: 		fire = 0x01;
	MOVLW      1
	MOVWF      _fire+0
;Game.c,102 :: 		}
L_interrupt12:
;Game.c,104 :: 		repaint = 0x01;
	MOVLW      1
	MOVWF      _repaint+0
;Game.c,105 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;Game.c,106 :: 		}
L_interrupt0:
;Game.c,107 :: 		}
L__interrupt92:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_draw_Labels:

;Game.c,109 :: 		void draw_Labels()
;Game.c,111 :: 		Glcd_Write_Text(t1.name,11,0,1);
	MOVF       _t1+7, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      11
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	CLRF       FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,112 :: 		if(current_t == 0x00) Glcd_Write_Char(t_indc,2,0,1);
	MOVF       _current_t+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_draw_Labels13
	MOVF       _t_indc+0, 0
	MOVWF      FARG_Glcd_Write_Char_chr+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Char_x_pos+0
	CLRF       FARG_Glcd_Write_Char_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Char_color+0
	CALL       _Glcd_Write_Char+0
L_draw_Labels13:
;Game.c,114 :: 		Glcd_Write_Text(t2.name,111,0,1);
	MOVF       _t2+7, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      111
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	CLRF       FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,115 :: 		if(current_t == 0xff) Glcd_Write_Char(t_indc,100,0,1);
	MOVF       _current_t+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_draw_Labels14
	MOVF       _t_indc+0, 0
	MOVWF      FARG_Glcd_Write_Char_chr+0
	MOVLW      100
	MOVWF      FARG_Glcd_Write_Char_x_pos+0
	CLRF       FARG_Glcd_Write_Char_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Char_color+0
	CALL       _Glcd_Write_Char+0
L_draw_Labels14:
;Game.c,116 :: 		Glcd_H_Line(0,127,8,t_color);
	CLRF       FARG_Glcd_H_Line_x_start+0
	MOVLW      127
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVLW      8
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVF       _t_color+0, 0
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;Game.c,118 :: 		}
	RETURN
; end of _draw_Labels

_draw_menu:

;Game.c,122 :: 		void draw_menu()
;Game.c,125 :: 		Glcd_Rectangle(14,11,114,13,1);
	MOVLW      14
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      11
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      114
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      13
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;Game.c,126 :: 		Glcd_Rectangle(14,15,114,17,1);
	MOVLW      14
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      15
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      114
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      17
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;Game.c,127 :: 		if(current_t ==0x00)
	MOVF       _current_t+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_draw_menu15
;Game.c,129 :: 		a = t1.gun_angle;
	MOVF       _t1+9, 0
	MOVWF      _a+0
	MOVF       _t1+10, 0
	MOVWF      _a+1
;Game.c,130 :: 		pw = t1.gun_power;
	MOVF       _t1+11, 0
	MOVWF      _pw+0
	MOVF       _t1+12, 0
	MOVWF      _pw+1
;Game.c,131 :: 		}
L_draw_menu15:
;Game.c,132 :: 		if(current_t == 0xff)
	MOVF       _current_t+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_draw_menu16
;Game.c,134 :: 		a =  180 - t2.gun_angle ;
	MOVF       _t2+9, 0
	SUBLW      180
	MOVWF      _a+0
	MOVF       _t2+10, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       _a+1
	SUBWF      _a+1, 1
;Game.c,135 :: 		pw = t2.gun_power;
	MOVF       _t2+11, 0
	MOVWF      _pw+0
	MOVF       _t2+12, 0
	MOVWF      _pw+1
;Game.c,136 :: 		}
L_draw_menu16:
;Game.c,137 :: 		Glcd_Line(15,12,15+a,12,1);
	MOVLW      15
	MOVWF      FARG_Glcd_Line_x_start+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_x_start+1
	MOVLW      12
	MOVWF      FARG_Glcd_Line_y_start+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_y_start+1
	MOVF       _a+0, 0
	ADDLW      15
	MOVWF      FARG_Glcd_Line_x_end+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _a+1, 0
	MOVWF      FARG_Glcd_Line_x_end+1
	MOVLW      12
	MOVWF      FARG_Glcd_Line_y_end+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_y_end+1
	MOVLW      1
	MOVWF      FARG_Glcd_Line_color+0
	CALL       _Glcd_Line+0
;Game.c,138 :: 		Glcd_Line(15,16,15+pw,16,1);
	MOVLW      15
	MOVWF      FARG_Glcd_Line_x_start+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_x_start+1
	MOVLW      16
	MOVWF      FARG_Glcd_Line_y_start+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_y_start+1
	MOVF       _pw+0, 0
	ADDLW      15
	MOVWF      FARG_Glcd_Line_x_end+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _pw+1, 0
	MOVWF      FARG_Glcd_Line_x_end+1
	MOVLW      16
	MOVWF      FARG_Glcd_Line_y_end+0
	MOVLW      0
	MOVWF      FARG_Glcd_Line_y_end+1
	MOVLW      1
	MOVWF      FARG_Glcd_Line_color+0
	CALL       _Glcd_Line+0
;Game.c,141 :: 		if(current_m == 0x00)Glcd_Rectangle(6,11,8,13,1);
	MOVF       _current_m+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_draw_menu17
	MOVLW      6
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      11
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      8
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      13
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
L_draw_menu17:
;Game.c,142 :: 		if(current_m == 0xff)Glcd_Rectangle(6,15,8,17,1);
	MOVF       _current_m+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_draw_menu18
	MOVLW      6
	MOVWF      FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      15
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      8
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      17
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
L_draw_menu18:
;Game.c,144 :: 		Glcd_H_Line(0,127,20,t_color);
	CLRF       FARG_Glcd_H_Line_x_start+0
	MOVLW      127
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVLW      20
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVF       _t_color+0, 0
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;Game.c,145 :: 		}
	RETURN
; end of _draw_menu

_draw_Tank:

;Game.c,149 :: 		void draw_Tank(Tank* t)
;Game.c,151 :: 		ux = t->x - (t->body_width/2);
	MOVLW      5
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      R7+0
	MOVF       R7+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVF       FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	SUBWF      R3+0, 0
	MOVWF      R6+0
	MOVF       R6+0, 0
	MOVWF      _ux+0
;Game.c,152 :: 		uy = 63 -  (t->y + (t->body_height));
	MOVLW      6
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      R5+0
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	SUBLW      63
	MOVWF      R4+0
	MOVF       R4+0, 0
	MOVWF      _uy+0
;Game.c,153 :: 		lx =  t->x + (t->body_width/2) ;
	MOVF       R7+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVF       FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	ADDWF      R3+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _lx+0
;Game.c,154 :: 		ly =  63 - ( t->y );
	MOVF       R5+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBLW      63
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _ly+0
;Game.c,156 :: 		Glcd_Box(ux,uy,lx,ly,1);
	MOVF       R6+0, 0
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       R4+0, 0
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVF       R1+0, 0
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVF       R0+0, 0
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Game.c,157 :: 		Glcd_Dot(ux + t->wheel_dis,ly + 1,t_color);
	MOVLW      4
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      _ux+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       _ly+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       _t_color+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Game.c,158 :: 		Glcd_Dot(lx - t->wheel_dis,ly + 1,t_color);
	MOVLW      4
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      _lx+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       _ly+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       _t_color+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Game.c,160 :: 		hd = (t->body_width - t->head_width)/2;
	MOVF       FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      2
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R0+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      _hd+0
;Game.c,161 :: 		Glcd_Box(ux + hd,uy - t->head_height,lx - hd,uy,1);
	MOVF       R0+0, 0
	ADDWF      _ux+0, 0
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      3
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      _uy+0, 0
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVF       R0+0, 0
	SUBWF      _lx+0, 0
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVF       _uy+0, 0
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Game.c,163 :: 		g_x = (cosE3(t->gun_angle) * t->gun_length) /1000;
	MOVLW      9
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_cosE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_cosE3_angle_deg+1
	CALL       _cosE3+0
	MOVLW      8
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _g_x+0
	MOVF       R0+1, 0
	MOVWF      _g_x+1
;Game.c,164 :: 		g_y = (sinE3(t->gun_angle) * t->gun_length) /1000;
	MOVLW      9
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+1
	CALL       _sinE3+0
	MOVLW      8
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _g_y+0
	MOVF       R0+1, 0
	MOVWF      _g_y+1
;Game.c,166 :: 		Glcd_Line(t->x,63 - (t->y + t->body_height + t->head_height + 1),t->x + g_x,63 - (t->y + t->body_height + g_y +  t->head_height + 1),1);
	MOVLW      5
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R7+0
	MOVF       R7+0, 0
	MOVWF      FARG_Glcd_Line_x_start+0
	CLRF       FARG_Glcd_Line_x_start+1
	MOVLW      6
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	INCF       FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R2+0, 0
	MOVWF      R5+0
	CLRF       R5+1
	BTFSC      STATUS+0, 0
	INCF       R5+1, 1
	MOVLW      3
	ADDWF      FARG_draw_Tank_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R4+0
	MOVF       R4+0, 0
	ADDWF      R5+0, 0
	MOVWF      R2+0
	MOVF       R5+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
	MOVF       R2+0, 0
	SUBLW      63
	MOVWF      FARG_Glcd_Line_y_start+0
	MOVF       R2+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_Glcd_Line_y_start+1
	SUBWF      FARG_Glcd_Line_y_start+1, 1
	MOVF       _g_x+0, 0
	ADDWF      R7+0, 0
	MOVWF      FARG_Glcd_Line_x_end+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _g_x+1, 0
	MOVWF      FARG_Glcd_Line_x_end+1
	MOVF       R5+0, 0
	ADDWF      R0+0, 1
	MOVF       R5+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R4+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	SUBLW      63
	MOVWF      FARG_Glcd_Line_y_end+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_Glcd_Line_y_end+1
	SUBWF      FARG_Glcd_Line_y_end+1, 1
	MOVLW      1
	MOVWF      FARG_Glcd_Line_color+0
	CALL       _Glcd_Line+0
;Game.c,168 :: 		}
	RETURN
; end of _draw_Tank

_draw_ob:

;Game.c,170 :: 		void draw_ob()
;Game.c,172 :: 		ux = ob1.x - (ob1.width/2);
	MOVF       _ob1+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	MOVF       R1+0, 0
	SUBWF      _ob1+2, 0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      _ux+0
;Game.c,173 :: 		uy = 63 -  (ob1.y + (ob1.height));
	MOVF       _ob1+1, 0
	ADDWF      _ob1+3, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBLW      63
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      _uy+0
;Game.c,174 :: 		lx =  ob1.x + (ob1.width/2) ;
	MOVF       _ob1+2, 0
	ADDWF      R1+0, 1
	MOVF       R1+0, 0
	MOVWF      _lx+0
;Game.c,175 :: 		ly =  63 - ( ob1.y);
	MOVF       _ob1+3, 0
	SUBLW      63
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _ly+0
;Game.c,177 :: 		Glcd_Box(ux,uy,lx,ly,1);
	MOVF       R3+0, 0
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       R2+0, 0
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVF       R1+0, 0
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVF       R0+0, 0
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Game.c,178 :: 		}
	RETURN
; end of _draw_ob

_draw_win:

;Game.c,181 :: 		void draw_win()
;Game.c,184 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Game.c,185 :: 		Glcd_Rectangle(0,0,127,63,1);
	CLRF       FARG_Glcd_Rectangle_x_upper_left+0
	CLRF       FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      127
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      63
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;Game.c,186 :: 		Glcd_Write_Text(Tank_Ptr->name,57,3,1);
	MOVLW      7
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      57
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      3
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,187 :: 		Glcd_Write_Text("Won",52,4,1);
	MOVLW      ?lstr1_Game+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      52
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,189 :: 		}
	RETURN
; end of _draw_win

_detect_collision:

;Game.c,191 :: 		unsigned short detect_collision(int x , int y)
;Game.c,197 :: 		if(current_t == 0xFF) Tank_Ptr2 = & t1;
	MOVF       _current_t+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_detect_collision19
	MOVLW      _t1+0
	MOVWF      _Tank_Ptr2+0
L_detect_collision19:
;Game.c,198 :: 		if(current_t == 0x00) Tank_Ptr2 = & t2;
	MOVF       _current_t+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_detect_collision20
	MOVLW      _t2+0
	MOVWF      _Tank_Ptr2+0
L_detect_collision20:
;Game.c,200 :: 		y =  63 - y;
	MOVF       FARG_detect_collision_y+0, 0
	SUBLW      63
	MOVWF      R1+0
	MOVF       FARG_detect_collision_y+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R1+1
	SUBWF      R1+1, 1
	MOVF       R1+0, 0
	MOVWF      FARG_detect_collision_y+0
	MOVF       R1+1, 0
	MOVWF      FARG_detect_collision_y+1
;Game.c,201 :: 		results = 0x00;
	CLRF       _results+0
;Game.c,203 :: 		if(y <= 0) results = 0x02;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision93
	MOVF       R1+0, 0
	SUBLW      0
L__detect_collision93:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision21
	MOVLW      2
	MOVWF      _results+0
	GOTO       L_detect_collision22
L_detect_collision21:
;Game.c,204 :: 		else   results = 0x00;
	CLRF       _results+0
L_detect_collision22:
;Game.c,206 :: 		if(x >= (Tank_Ptr2->x - (Tank_Ptr2->body_width / 2))  &&
	MOVLW      5
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVF       _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	SUBWF      R3+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
;Game.c,207 :: 		x <= (Tank_Ptr2->x + (Tank_Ptr2->body_width / 2)) )
	MOVLW      128
	XORWF      FARG_detect_collision_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision94
	MOVF       R1+0, 0
	SUBWF      FARG_detect_collision_x+0, 0
L__detect_collision94:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision25
	MOVLW      5
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVF       _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	ADDWF      R3+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_detect_collision_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision95
	MOVF       FARG_detect_collision_x+0, 0
	SUBWF      R1+0, 0
L__detect_collision95:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision25
L__detect_collision87:
;Game.c,210 :: 		if(y >= (Tank_Ptr2->y)  &&
	MOVLW      6
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
;Game.c,211 :: 		y <= (Tank_Ptr2->y + (Tank_Ptr2->body_height)) )
	MOVLW      128
	XORWF      FARG_detect_collision_y+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision96
	MOVF       R1+0, 0
	SUBWF      FARG_detect_collision_y+0, 0
L__detect_collision96:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision28
	MOVLW      6
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_detect_collision_y+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision97
	MOVF       FARG_detect_collision_y+0, 0
	SUBWF      R1+0, 0
L__detect_collision97:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision28
L__detect_collision86:
;Game.c,212 :: 		results = 0x01;
	MOVLW      1
	MOVWF      _results+0
L_detect_collision28:
;Game.c,213 :: 		}
L_detect_collision25:
;Game.c,215 :: 		if(x >= (Tank_Ptr2->x - (Tank_Ptr2->head_width / 2))  &&
	MOVLW      5
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVLW      2
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	SUBWF      R3+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
;Game.c,216 :: 		x <= (Tank_Ptr2->x + (Tank_Ptr2->head_width / 2)) )
	MOVLW      128
	XORWF      FARG_detect_collision_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision98
	MOVF       R1+0, 0
	SUBWF      FARG_detect_collision_x+0, 0
L__detect_collision98:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision31
	MOVLW      5
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R3+0
	MOVLW      2
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	ADDWF      R3+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_detect_collision_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision99
	MOVF       FARG_detect_collision_x+0, 0
	SUBWF      R1+0, 0
L__detect_collision99:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision31
L__detect_collision85:
;Game.c,219 :: 		if(y >= (Tank_Ptr2->body_height)  &&
	INCF       _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
;Game.c,220 :: 		y <= (Tank_Ptr2->body_height + (Tank_Ptr2->head_height)) )
	MOVLW      128
	XORWF      FARG_detect_collision_y+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision100
	MOVF       R1+0, 0
	SUBWF      FARG_detect_collision_y+0, 0
L__detect_collision100:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision34
	INCF       _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      3
	ADDWF      _Tank_Ptr2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_detect_collision_y+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision101
	MOVF       FARG_detect_collision_y+0, 0
	SUBWF      R1+0, 0
L__detect_collision101:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision34
L__detect_collision84:
;Game.c,221 :: 		results = 0x01;
	MOVLW      1
	MOVWF      _results+0
L_detect_collision34:
;Game.c,222 :: 		}
L_detect_collision31:
;Game.c,224 :: 		if(x >= (ob1.x - (ob1.width / 2))  &&
	MOVF       _ob1+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	SUBWF      _ob1+2, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
;Game.c,225 :: 		x <= (ob1.x + (ob1.width / 2)) )
	MOVLW      128
	XORWF      FARG_detect_collision_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision102
	MOVF       R1+0, 0
	SUBWF      FARG_detect_collision_x+0, 0
L__detect_collision102:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision37
	MOVF       _ob1+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	ADDWF      _ob1+2, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_detect_collision_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision103
	MOVF       FARG_detect_collision_x+0, 0
	SUBWF      R1+0, 0
L__detect_collision103:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision37
L__detect_collision83:
;Game.c,228 :: 		y <= (ob1.y + (ob1.height)) )
	MOVLW      128
	XORWF      FARG_detect_collision_y+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision104
	MOVF       _ob1+3, 0
	SUBWF      FARG_detect_collision_y+0, 0
L__detect_collision104:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision40
	MOVF       _ob1+1, 0
	ADDWF      _ob1+3, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_detect_collision_y+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__detect_collision105
	MOVF       FARG_detect_collision_y+0, 0
	SUBWF      R1+0, 0
L__detect_collision105:
	BTFSS      STATUS+0, 0
	GOTO       L_detect_collision40
L__detect_collision82:
;Game.c,229 :: 		results = 0x03;
	MOVLW      3
	MOVWF      _results+0
L_detect_collision40:
;Game.c,230 :: 		}
L_detect_collision37:
;Game.c,232 :: 		return results;
	MOVF       _results+0, 0
	MOVWF      R0+0
;Game.c,233 :: 		}
	RETURN
; end of _detect_collision

_draw_fire:

;Game.c,239 :: 		void draw_fire()
;Game.c,241 :: 		if(current_t == 0x00) Tank_Ptr = & t1;
	MOVF       _current_t+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire41
	MOVLW      _t1+0
	MOVWF      _Tank_Ptr+0
L_draw_fire41:
;Game.c,242 :: 		if(current_t == 0xFF) Tank_Ptr = & t2;
	MOVF       _current_t+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire42
	MOVLW      _t2+0
	MOVWF      _Tank_Ptr+0
L_draw_fire42:
;Game.c,243 :: 		cont_fire = 0x01;
	MOVLW      1
	MOVWF      _cont_fire+0
;Game.c,245 :: 		for (i = 1;i<=Tank_Ptr->gun_power  && cont_fire ==0x01;i++){
	MOVLW      1
	MOVWF      _i+0
L_draw_fire43:
	MOVLW      11
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire106
	MOVF       _i+0, 0
	SUBWF      R1+0, 0
L__draw_fire106:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire44
	MOVF       _cont_fire+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire44
L__draw_fire91:
;Game.c,247 :: 		f_x = cosE3(Tank_Ptr->gun_angle);
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_cosE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_cosE3_angle_deg+1
	CALL       _cosE3+0
	MOVF       R0+0, 0
	MOVWF      _f_x+0
	MOVF       R0+1, 0
	MOVWF      _f_x+1
	MOVLW      0
	BTFSC      _f_x+1, 7
	MOVLW      255
	MOVWF      _f_x+2
	MOVWF      _f_x+3
;Game.c,248 :: 		f_x = f_x * i;
	MOVF       _f_x+0, 0
	MOVWF      R0+0
	MOVF       _f_x+1, 0
	MOVWF      R0+1
	MOVF       _f_x+2, 0
	MOVWF      R0+2
	MOVF       _f_x+3, 0
	MOVWF      R0+3
	MOVF       _i+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _f_x+0
	MOVF       R0+1, 0
	MOVWF      _f_x+1
	MOVF       R0+2, 0
	MOVWF      _f_x+2
	MOVF       R0+3, 0
	MOVWF      _f_x+3
;Game.c,249 :: 		f_x = f_x / 1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _f_x+0
	MOVF       R0+1, 0
	MOVWF      _f_x+1
	MOVF       R0+2, 0
	MOVWF      _f_x+2
	MOVF       R0+3, 0
	MOVWF      _f_x+3
;Game.c,251 :: 		f_y = sinE3(Tank_Ptr->gun_angle);
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+1
	CALL       _sinE3+0
	MOVF       R0+0, 0
	MOVWF      _f_y+0
	MOVF       R0+1, 0
	MOVWF      _f_y+1
	MOVLW      0
	BTFSC      _f_y+1, 7
	MOVLW      255
	MOVWF      _f_y+2
	MOVWF      _f_y+3
;Game.c,252 :: 		f_y = f_y * i;
	MOVF       _f_y+0, 0
	MOVWF      R0+0
	MOVF       _f_y+1, 0
	MOVWF      R0+1
	MOVF       _f_y+2, 0
	MOVWF      R0+2
	MOVF       _f_y+3, 0
	MOVWF      R0+3
	MOVF       _i+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _f_y+0
	MOVF       R0+1, 0
	MOVWF      _f_y+1
	MOVF       R0+2, 0
	MOVWF      _f_y+2
	MOVF       R0+3, 0
	MOVWF      _f_y+3
;Game.c,253 :: 		f_y = f_y / 1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _f_y+0
	MOVF       R0+1, 0
	MOVWF      _f_y+1
	MOVF       R0+2, 0
	MOVWF      _f_y+2
	MOVF       R0+3, 0
	MOVWF      _f_y+3
;Game.c,255 :: 		l_x = Tank_Ptr->x;
	MOVLW      5
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _l_x+0
	CLRF       _l_x+1
	CLRF       _l_x+2
	CLRF       _l_x+3
	MOVLW      0
	MOVWF      _l_x+1
	MOVWF      _l_x+2
	MOVWF      _l_x+3
;Game.c,256 :: 		l_y = 63 - (Tank_Ptr->y + Tank_Ptr->body_height + Tank_Ptr->head_height);
	MOVLW      6
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 1
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      3
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	SUBLW      63
	MOVWF      _l_y+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       _l_y+1
	SUBWF      _l_y+1, 1
	MOVLW      0
	BTFSC      _l_y+1, 7
	MOVLW      255
	MOVWF      _l_y+2
	MOVWF      _l_y+3
;Game.c,258 :: 		if((l_x + f_x)<=127 && (l_x + f_x)>=0 && (l_y - f_y)>=0  && (l_y - f_y)<=63)
	MOVF       _l_x+0, 0
	MOVWF      R1+0
	MOVF       _l_x+1, 0
	MOVWF      R1+1
	MOVF       _l_x+2, 0
	MOVWF      R1+2
	MOVF       _l_x+3, 0
	MOVWF      R1+3
	MOVF       _f_x+0, 0
	ADDWF      R1+0, 1
	MOVF       _f_x+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+1, 0
	ADDWF      R1+1, 1
	MOVF       _f_x+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+2, 0
	ADDWF      R1+2, 1
	MOVF       _f_x+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+3, 0
	ADDWF      R1+3, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire107
	MOVF       R1+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire107
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire107
	MOVF       R1+0, 0
	SUBLW      127
L__draw_fire107:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire50
	MOVF       _l_x+0, 0
	MOVWF      R1+0
	MOVF       _l_x+1, 0
	MOVWF      R1+1
	MOVF       _l_x+2, 0
	MOVWF      R1+2
	MOVF       _l_x+3, 0
	MOVWF      R1+3
	MOVF       _f_x+0, 0
	ADDWF      R1+0, 1
	MOVF       _f_x+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+1, 0
	ADDWF      R1+1, 1
	MOVF       _f_x+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+2, 0
	ADDWF      R1+2, 1
	MOVF       _f_x+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+3, 0
	ADDWF      R1+3, 1
	MOVLW      128
	XORWF      R1+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire108
	MOVLW      0
	SUBWF      R1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire108
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire108
	MOVLW      0
	SUBWF      R1+0, 0
L__draw_fire108:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire50
	MOVF       _l_y+0, 0
	MOVWF      R1+0
	MOVF       _l_y+1, 0
	MOVWF      R1+1
	MOVF       _l_y+2, 0
	MOVWF      R1+2
	MOVF       _l_y+3, 0
	MOVWF      R1+3
	MOVF       _f_y+0, 0
	SUBWF      R1+0, 1
	MOVF       _f_y+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+1, 0
	SUBWF      R1+1, 1
	MOVF       _f_y+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+2, 0
	SUBWF      R1+2, 1
	MOVF       _f_y+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+3, 0
	SUBWF      R1+3, 1
	MOVLW      128
	XORWF      R1+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire109
	MOVLW      0
	SUBWF      R1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire109
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire109
	MOVLW      0
	SUBWF      R1+0, 0
L__draw_fire109:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire50
	MOVF       _l_y+0, 0
	MOVWF      R1+0
	MOVF       _l_y+1, 0
	MOVWF      R1+1
	MOVF       _l_y+2, 0
	MOVWF      R1+2
	MOVF       _l_y+3, 0
	MOVWF      R1+3
	MOVF       _f_y+0, 0
	SUBWF      R1+0, 1
	MOVF       _f_y+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+1, 0
	SUBWF      R1+1, 1
	MOVF       _f_y+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+2, 0
	SUBWF      R1+2, 1
	MOVF       _f_y+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+3, 0
	SUBWF      R1+3, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire110
	MOVF       R1+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire110
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire110
	MOVF       R1+0, 0
	SUBLW      63
L__draw_fire110:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire50
L__draw_fire90:
;Game.c,259 :: 		Glcd_Line(l_x,l_y,l_x + f_x, l_y - f_y,1);
	MOVF       _l_x+0, 0
	MOVWF      FARG_Glcd_Line_x_start+0
	MOVF       _l_x+1, 0
	MOVWF      FARG_Glcd_Line_x_start+1
	MOVF       _l_y+0, 0
	MOVWF      FARG_Glcd_Line_y_start+0
	MOVF       _l_y+1, 0
	MOVWF      FARG_Glcd_Line_y_start+1
	MOVF       _f_x+0, 0
	ADDWF      _l_x+0, 0
	MOVWF      FARG_Glcd_Line_x_end+0
	MOVF       _l_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _f_x+1, 0
	MOVWF      FARG_Glcd_Line_x_end+1
	MOVF       _f_y+0, 0
	SUBWF      _l_y+0, 0
	MOVWF      FARG_Glcd_Line_y_end+0
	MOVLW      0
	BTFSC      _f_y+3, 7
	MOVLW      255
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_Glcd_Line_y_end+1
	SUBWF      FARG_Glcd_Line_y_end+1, 1
	MOVLW      0
	BTFSC      _l_y+3, 7
	MOVLW      255
	ADDWF      FARG_Glcd_Line_y_end+1, 1
	MOVLW      1
	MOVWF      FARG_Glcd_Line_color+0
	CALL       _Glcd_Line+0
L_draw_fire50:
;Game.c,261 :: 		collision = detect_collision(l_x + f_x,l_y - f_y);
	MOVF       _f_x+0, 0
	ADDWF      _l_x+0, 0
	MOVWF      FARG_detect_collision_x+0
	MOVF       _l_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _f_x+1, 0
	MOVWF      FARG_detect_collision_x+1
	MOVF       _f_y+0, 0
	SUBWF      _l_y+0, 0
	MOVWF      FARG_detect_collision_y+0
	MOVLW      0
	BTFSC      _f_y+3, 7
	MOVLW      255
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_detect_collision_y+1
	SUBWF      FARG_detect_collision_y+1, 1
	MOVLW      0
	BTFSC      _l_y+3, 7
	MOVLW      255
	ADDWF      FARG_detect_collision_y+1, 1
	CALL       _detect_collision+0
	MOVF       R0+0, 0
	MOVWF      _collision+0
;Game.c,264 :: 		if (collision == 0x01)
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire51
;Game.c,266 :: 		draw_win();
	CALL       _draw_win+0
;Game.c,267 :: 		cont_fire = 0x00;
	CLRF       _cont_fire+0
;Game.c,268 :: 		started = 0x00;
	CLRF       _started+0
;Game.c,269 :: 		}
L_draw_fire51:
;Game.c,271 :: 		if (collision == 0x03)
	MOVF       _collision+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire52
;Game.c,274 :: 		cont_fire = 0x00;
	CLRF       _cont_fire+0
;Game.c,275 :: 		Glcd_Write_Text("You O Missed",25,4,1);
	MOVLW      ?lstr2_Game+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,276 :: 		}
L_draw_fire52:
;Game.c,279 :: 		l_x += f_x;
	MOVF       _f_x+0, 0
	ADDWF      _l_x+0, 1
	MOVF       _f_x+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+1, 0
	ADDWF      _l_x+1, 1
	MOVF       _f_x+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+2, 0
	ADDWF      _l_x+2, 1
	MOVF       _f_x+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+3, 0
	ADDWF      _l_x+3, 1
;Game.c,280 :: 		l_y -= f_y;
	MOVF       _f_y+0, 0
	SUBWF      _l_y+0, 1
	MOVF       _f_y+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+1, 0
	SUBWF      _l_y+1, 1
	MOVF       _f_y+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+2, 0
	SUBWF      _l_y+2, 1
	MOVF       _f_y+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _f_y+3, 0
	SUBWF      _l_y+3, 1
;Game.c,281 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_draw_fire53:
	DECFSZ     R13+0, 1
	GOTO       L_draw_fire53
	DECFSZ     R12+0, 1
	GOTO       L_draw_fire53
	DECFSZ     R11+0, 1
	GOTO       L_draw_fire53
	NOP
	NOP
;Game.c,245 :: 		for (i = 1;i<=Tank_Ptr->gun_power  && cont_fire ==0x01;i++){
	INCF       _i+0, 1
;Game.c,282 :: 		}
	GOTO       L_draw_fire43
L_draw_fire44:
;Game.c,285 :: 		if(cont_fire = 0x01)
	MOVLW      1
	MOVWF      _cont_fire+0
;Game.c,287 :: 		ex = 1000 * (f_y + Tank_Ptr->head_height + Tank_Ptr->body_height + Tank_Ptr->y);
	MOVLW      3
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       _f_y+0, 0
	MOVWF      R4+0
	MOVF       _f_y+1, 0
	MOVWF      R4+1
	MOVF       _f_y+2, 0
	MOVWF      R4+2
	MOVF       _f_y+3, 0
	MOVWF      R4+3
	MOVF       R0+0, 0
	ADDWF      R4+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      R4+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      R4+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      R4+3, 1
	INCF       _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       R0+0, 0
	ADDWF      R4+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      R4+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      R4+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      R4+3, 1
	MOVLW      6
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       R4+0, 0
	ADDWF      R0+0, 1
	MOVF       R4+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+1, 0
	ADDWF      R0+1, 1
	MOVF       R4+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+2, 0
	ADDWF      R0+2, 1
	MOVF       R4+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+3, 0
	ADDWF      R0+3, 1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _ex+0
	MOVF       R0+1, 0
	MOVWF      _ex+1
	MOVF       R0+2, 0
	MOVWF      _ex+2
	MOVF       R0+3, 0
	MOVWF      _ex+3
;Game.c,288 :: 		ex = ex / sinE3(Tank_Ptr->gun_angle);
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+1
	CALL       _sinE3+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	BTFSC      R4+1, 7
	MOVLW      255
	MOVWF      R4+2
	MOVWF      R4+3
	MOVF       _ex+0, 0
	MOVWF      R0+0
	MOVF       _ex+1, 0
	MOVWF      R0+1
	MOVF       _ex+2, 0
	MOVWF      R0+2
	MOVF       _ex+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _ex+0
	MOVF       R0+1, 0
	MOVWF      _ex+1
	MOVF       R0+2, 0
	MOVWF      _ex+2
	MOVF       R0+3, 0
	MOVWF      _ex+3
;Game.c,292 :: 		for (i = 1;i<=ex  && cont_fire ==0x01;i++){;
	MOVLW      1
	MOVWF      _i+0
L_draw_fire55:
	MOVLW      128
	XORWF      _ex+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire111
	MOVLW      0
	SUBWF      _ex+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire111
	MOVLW      0
	SUBWF      _ex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire111
	MOVF       _i+0, 0
	SUBWF      _ex+0, 0
L__draw_fire111:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire56
	MOVF       _cont_fire+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire56
L__draw_fire89:
;Game.c,294 :: 		f_x = cosE3(Tank_Ptr->gun_angle);
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_cosE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_cosE3_angle_deg+1
	CALL       _cosE3+0
	MOVF       R0+0, 0
	MOVWF      _f_x+0
	MOVF       R0+1, 0
	MOVWF      _f_x+1
	MOVLW      0
	BTFSC      _f_x+1, 7
	MOVLW      255
	MOVWF      _f_x+2
	MOVWF      _f_x+3
;Game.c,295 :: 		f_x = f_x * i;
	MOVF       _f_x+0, 0
	MOVWF      R0+0
	MOVF       _f_x+1, 0
	MOVWF      R0+1
	MOVF       _f_x+2, 0
	MOVWF      R0+2
	MOVF       _f_x+3, 0
	MOVWF      R0+3
	MOVF       _i+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _f_x+0
	MOVF       R0+1, 0
	MOVWF      _f_x+1
	MOVF       R0+2, 0
	MOVWF      _f_x+2
	MOVF       R0+3, 0
	MOVWF      _f_x+3
;Game.c,296 :: 		f_x = f_x / 1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _f_x+0
	MOVF       R0+1, 0
	MOVWF      _f_x+1
	MOVF       R0+2, 0
	MOVWF      _f_x+2
	MOVF       R0+3, 0
	MOVWF      _f_x+3
;Game.c,298 :: 		f_y = sinE3(Tank_Ptr->gun_angle);
	MOVLW      9
	ADDWF      _Tank_Ptr+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_sinE3_angle_deg+1
	CALL       _sinE3+0
	MOVF       R0+0, 0
	MOVWF      _f_y+0
	MOVF       R0+1, 0
	MOVWF      _f_y+1
	MOVLW      0
	BTFSC      _f_y+1, 7
	MOVLW      255
	MOVWF      _f_y+2
	MOVWF      _f_y+3
;Game.c,299 :: 		f_y = f_y * i;
	MOVF       _f_y+0, 0
	MOVWF      R0+0
	MOVF       _f_y+1, 0
	MOVWF      R0+1
	MOVF       _f_y+2, 0
	MOVWF      R0+2
	MOVF       _f_y+3, 0
	MOVWF      R0+3
	MOVF       _i+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _f_y+0
	MOVF       R0+1, 0
	MOVWF      _f_y+1
	MOVF       R0+2, 0
	MOVWF      _f_y+2
	MOVF       R0+3, 0
	MOVWF      _f_y+3
;Game.c,300 :: 		f_y = f_y / 1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _f_y+0
	MOVF       R0+1, 0
	MOVWF      _f_y+1
	MOVF       R0+2, 0
	MOVWF      _f_y+2
	MOVF       R0+3, 0
	MOVWF      _f_y+3
;Game.c,302 :: 		if((l_x + f_x)<=127 && (l_x + f_x)>=0 )
	MOVF       _l_x+0, 0
	MOVWF      R1+0
	MOVF       _l_x+1, 0
	MOVWF      R1+1
	MOVF       _l_x+2, 0
	MOVWF      R1+2
	MOVF       _l_x+3, 0
	MOVWF      R1+3
	MOVF       _f_x+0, 0
	ADDWF      R1+0, 1
	MOVF       _f_x+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+1, 0
	ADDWF      R1+1, 1
	MOVF       _f_x+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+2, 0
	ADDWF      R1+2, 1
	MOVF       _f_x+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+3, 0
	ADDWF      R1+3, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire112
	MOVF       R1+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire112
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire112
	MOVF       R1+0, 0
	SUBLW      127
L__draw_fire112:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire62
	MOVF       _l_x+0, 0
	MOVWF      R1+0
	MOVF       _l_x+1, 0
	MOVWF      R1+1
	MOVF       _l_x+2, 0
	MOVWF      R1+2
	MOVF       _l_x+3, 0
	MOVWF      R1+3
	MOVF       _f_x+0, 0
	ADDWF      R1+0, 1
	MOVF       _f_x+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+1, 0
	ADDWF      R1+1, 1
	MOVF       _f_x+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+2, 0
	ADDWF      R1+2, 1
	MOVF       _f_x+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+3, 0
	ADDWF      R1+3, 1
	MOVLW      128
	XORWF      R1+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire113
	MOVLW      0
	SUBWF      R1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire113
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__draw_fire113
	MOVLW      0
	SUBWF      R1+0, 0
L__draw_fire113:
	BTFSS      STATUS+0, 0
	GOTO       L_draw_fire62
L__draw_fire88:
;Game.c,306 :: 		Glcd_Line(l_x,l_y,l_x + f_x, l_y + f_y,1);
	MOVF       _l_x+0, 0
	MOVWF      FARG_Glcd_Line_x_start+0
	MOVF       _l_x+1, 0
	MOVWF      FARG_Glcd_Line_x_start+1
	MOVF       _l_y+0, 0
	MOVWF      FARG_Glcd_Line_y_start+0
	MOVF       _l_y+1, 0
	MOVWF      FARG_Glcd_Line_y_start+1
	MOVF       _f_x+0, 0
	ADDWF      _l_x+0, 0
	MOVWF      FARG_Glcd_Line_x_end+0
	MOVF       _l_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _f_x+1, 0
	MOVWF      FARG_Glcd_Line_x_end+1
	MOVF       _f_y+0, 0
	ADDWF      _l_y+0, 0
	MOVWF      FARG_Glcd_Line_y_end+0
	MOVF       _l_y+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _f_y+1, 0
	MOVWF      FARG_Glcd_Line_y_end+1
	MOVLW      1
	MOVWF      FARG_Glcd_Line_color+0
	CALL       _Glcd_Line+0
;Game.c,307 :: 		}
L_draw_fire62:
;Game.c,309 :: 		collision = detect_collision(l_x + f_x,l_y + f_y);
	MOVF       _f_x+0, 0
	ADDWF      _l_x+0, 0
	MOVWF      FARG_detect_collision_x+0
	MOVF       _l_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _f_x+1, 0
	MOVWF      FARG_detect_collision_x+1
	MOVF       _f_y+0, 0
	ADDWF      _l_y+0, 0
	MOVWF      FARG_detect_collision_y+0
	MOVF       _l_y+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _f_y+1, 0
	MOVWF      FARG_detect_collision_y+1
	CALL       _detect_collision+0
	MOVF       R0+0, 0
	MOVWF      _collision+0
;Game.c,311 :: 		if (collision == 0x01)
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire63
;Game.c,313 :: 		draw_win();
	CALL       _draw_win+0
;Game.c,314 :: 		cont_fire = 0x00;
	CLRF       _cont_fire+0
;Game.c,315 :: 		started = 0x00;
	CLRF       _started+0
;Game.c,316 :: 		}
	GOTO       L_draw_fire64
L_draw_fire63:
;Game.c,317 :: 		else if (collision == 0x02)
	MOVF       _collision+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire65
;Game.c,319 :: 		Glcd_Write_Text("You Missed",25,4,1);
	MOVLW      ?lstr3_Game+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,320 :: 		}
	GOTO       L_draw_fire66
L_draw_fire65:
;Game.c,321 :: 		else if (collision == 0x03)
	MOVF       _collision+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_draw_fire67
;Game.c,324 :: 		cont_fire = 0x00;
	CLRF       _cont_fire+0
;Game.c,325 :: 		Glcd_Write_Text("You Missed",25,4,1);
	MOVLW      ?lstr4_Game+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	MOVLW      25
	MOVWF      FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Game.c,326 :: 		}
L_draw_fire67:
L_draw_fire66:
L_draw_fire64:
;Game.c,330 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_draw_fire68:
	DECFSZ     R13+0, 1
	GOTO       L_draw_fire68
	DECFSZ     R12+0, 1
	GOTO       L_draw_fire68
	DECFSZ     R11+0, 1
	GOTO       L_draw_fire68
	NOP
	NOP
;Game.c,292 :: 		for (i = 1;i<=ex  && cont_fire ==0x01;i++){;
	INCF       _i+0, 1
;Game.c,331 :: 		}
	GOTO       L_draw_fire55
L_draw_fire56:
;Game.c,332 :: 		l_x += f_x;
	MOVF       _f_x+0, 0
	ADDWF      _l_x+0, 1
	MOVF       _f_x+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+1, 0
	ADDWF      _l_x+1, 1
	MOVF       _f_x+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+2, 0
	ADDWF      _l_x+2, 1
	MOVF       _f_x+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_x+3, 0
	ADDWF      _l_x+3, 1
;Game.c,333 :: 		l_y += f_y;
	MOVF       _f_y+0, 0
	ADDWF      _l_y+0, 1
	MOVF       _f_y+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_y+1, 0
	ADDWF      _l_y+1, 1
	MOVF       _f_y+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_y+2, 0
	ADDWF      _l_y+2, 1
	MOVF       _f_y+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _f_y+3, 0
	ADDWF      _l_y+3, 1
;Game.c,337 :: 		Delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_draw_fire69:
	DECFSZ     R13+0, 1
	GOTO       L_draw_fire69
	DECFSZ     R12+0, 1
	GOTO       L_draw_fire69
	DECFSZ     R11+0, 1
	GOTO       L_draw_fire69
	NOP
;Game.c,338 :: 		current_t = ~ current_t;
	COMF       _current_t+0, 1
;Game.c,339 :: 		repaint = 0x01;
	MOVLW      1
	MOVWF      _repaint+0
;Game.c,340 :: 		}
	RETURN
; end of _draw_fire

_Init_Level:

;Game.c,344 :: 		void Init_Level()
;Game.c,346 :: 		current_l ++;
	INCF       _current_l+0, 1
;Game.c,347 :: 		if (current_l == 0x01)
	MOVF       _current_l+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Init_Level70
;Game.c,350 :: 		t1.body_width = 15;
	MOVLW      15
	MOVWF      _t1+0
;Game.c,351 :: 		t1.body_height = 4;
	MOVLW      4
	MOVWF      _t1+1
;Game.c,352 :: 		t1.head_width = 6;
	MOVLW      6
	MOVWF      _t1+2
;Game.c,353 :: 		t1.head_height = 2;
	MOVLW      2
	MOVWF      _t1+3
;Game.c,354 :: 		t1.x = 7;
	MOVLW      7
	MOVWF      _t1+5
;Game.c,355 :: 		t1.y = 1;
	MOVLW      1
	MOVWF      _t1+6
;Game.c,356 :: 		t1.wheel_dis = 2;
	MOVLW      2
	MOVWF      _t1+4
;Game.c,357 :: 		t1.name  = "T1";
	MOVLW      ?lstr5_Game+0
	MOVWF      _t1+7
;Game.c,358 :: 		t1.gun_angle = 30;
	MOVLW      30
	MOVWF      _t1+9
	MOVLW      0
	MOVWF      _t1+10
;Game.c,359 :: 		t1.gun_power = 30;
	MOVLW      30
	MOVWF      _t1+11
	MOVLW      0
	MOVWF      _t1+12
;Game.c,360 :: 		t1.gun_length = 12;
	MOVLW      12
	MOVWF      _t1+8
;Game.c,362 :: 		t2.body_width = t1.body_width;
	MOVLW      15
	MOVWF      _t2+0
;Game.c,363 :: 		t2.body_height = t1.body_height;
	MOVLW      4
	MOVWF      _t2+1
;Game.c,364 :: 		t2.head_width = t1.head_width ;
	MOVLW      6
	MOVWF      _t2+2
;Game.c,365 :: 		t2.head_height = t1.head_height ;
	MOVLW      2
	MOVWF      _t2+3
;Game.c,366 :: 		t2.x = 120;
	MOVLW      120
	MOVWF      _t2+5
;Game.c,367 :: 		t2.y = 1;
	MOVLW      1
	MOVWF      _t2+6
;Game.c,368 :: 		t2.wheel_dis = t1.wheel_dis;
	MOVLW      2
	MOVWF      _t2+4
;Game.c,369 :: 		t2.name  = "T2";
	MOVLW      ?lstr6_Game+0
	MOVWF      _t2+7
;Game.c,370 :: 		t2.gun_angle = 180 - t1.gun_angle ;
	MOVLW      150
	MOVWF      _t2+9
	MOVLW      0
	MOVWF      _t2+10
;Game.c,371 :: 		t2.gun_power = 80;
	MOVLW      80
	MOVWF      _t2+11
	MOVLW      0
	MOVWF      _t2+12
;Game.c,372 :: 		t2.gun_length = t1.gun_length;
	MOVLW      12
	MOVWF      _t2+8
;Game.c,374 :: 		ob1.x = 64;
	MOVLW      64
	MOVWF      _ob1+2
;Game.c,375 :: 		ob1.y = 0;
	CLRF       _ob1+3
;Game.c,376 :: 		ob1.width = 10;
	MOVLW      10
	MOVWF      _ob1+0
;Game.c,377 :: 		ob1.height = 30;
	MOVLW      30
	MOVWF      _ob1+1
;Game.c,378 :: 		}
	GOTO       L_Init_Level71
L_Init_Level70:
;Game.c,379 :: 		else if (current_l == 0x02)
	MOVF       _current_l+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_Init_Level72
;Game.c,382 :: 		t1.body_width = 15;
	MOVLW      15
	MOVWF      _t1+0
;Game.c,383 :: 		t1.body_height = 4;
	MOVLW      4
	MOVWF      _t1+1
;Game.c,384 :: 		t1.head_width = 6;
	MOVLW      6
	MOVWF      _t1+2
;Game.c,385 :: 		t1.head_height = 2;
	MOVLW      2
	MOVWF      _t1+3
;Game.c,386 :: 		t1.x = 7;
	MOVLW      7
	MOVWF      _t1+5
;Game.c,387 :: 		t1.y = 1;
	MOVLW      1
	MOVWF      _t1+6
;Game.c,388 :: 		t1.wheel_dis = 2;
	MOVLW      2
	MOVWF      _t1+4
;Game.c,389 :: 		t1.name  = "T1";
	MOVLW      ?lstr7_Game+0
	MOVWF      _t1+7
;Game.c,390 :: 		t1.gun_angle = 50;
	MOVLW      50
	MOVWF      _t1+9
	MOVLW      0
	MOVWF      _t1+10
;Game.c,391 :: 		t1.gun_power = 65;
	MOVLW      65
	MOVWF      _t1+11
	MOVLW      0
	MOVWF      _t1+12
;Game.c,392 :: 		t1.gun_length = 12;
	MOVLW      12
	MOVWF      _t1+8
;Game.c,394 :: 		t2.body_width = t1.body_width;
	MOVLW      15
	MOVWF      _t2+0
;Game.c,395 :: 		t2.body_height = t1.body_height;
	MOVLW      4
	MOVWF      _t2+1
;Game.c,396 :: 		t2.head_width = t1.head_width ;
	MOVLW      6
	MOVWF      _t2+2
;Game.c,397 :: 		t2.head_height = t1.head_height ;
	MOVLW      2
	MOVWF      _t2+3
;Game.c,398 :: 		t2.x = 120;
	MOVLW      120
	MOVWF      _t2+5
;Game.c,399 :: 		t2.y = 1;
	MOVLW      1
	MOVWF      _t2+6
;Game.c,400 :: 		t2.wheel_dis = t1.wheel_dis;
	MOVLW      2
	MOVWF      _t2+4
;Game.c,401 :: 		t2.name  = "T2";
	MOVLW      ?lstr8_Game+0
	MOVWF      _t2+7
;Game.c,402 :: 		t2.gun_angle = 180 - 40 ;
	MOVLW      140
	MOVWF      _t2+9
	CLRF       _t2+10
;Game.c,403 :: 		t2.gun_power = 30;
	MOVLW      30
	MOVWF      _t2+11
	MOVLW      0
	MOVWF      _t2+12
;Game.c,404 :: 		t2.gun_length = t1.gun_length;
	MOVLW      12
	MOVWF      _t2+8
;Game.c,406 :: 		ob1.x = 80;
	MOVLW      80
	MOVWF      _ob1+2
;Game.c,407 :: 		ob1.y = 10;
	MOVLW      10
	MOVWF      _ob1+3
;Game.c,408 :: 		ob1.width = 10;
	MOVLW      10
	MOVWF      _ob1+0
;Game.c,409 :: 		ob1.height = 20;
	MOVLW      20
	MOVWF      _ob1+1
;Game.c,410 :: 		}
	GOTO       L_Init_Level73
L_Init_Level72:
;Game.c,411 :: 		else if (current_l == 0x03)
	MOVF       _current_l+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_Init_Level74
;Game.c,414 :: 		t1.body_width = 15;
	MOVLW      15
	MOVWF      _t1+0
;Game.c,415 :: 		t1.body_height = 4;
	MOVLW      4
	MOVWF      _t1+1
;Game.c,416 :: 		t1.head_width = 6;
	MOVLW      6
	MOVWF      _t1+2
;Game.c,417 :: 		t1.head_height = 2;
	MOVLW      2
	MOVWF      _t1+3
;Game.c,418 :: 		t1.x = 7;
	MOVLW      7
	MOVWF      _t1+5
;Game.c,419 :: 		t1.y = 1;
	MOVLW      1
	MOVWF      _t1+6
;Game.c,420 :: 		t1.wheel_dis = 2;
	MOVLW      2
	MOVWF      _t1+4
;Game.c,421 :: 		t1.name  = "T1";
	MOVLW      ?lstr9_Game+0
	MOVWF      _t1+7
;Game.c,422 :: 		t1.gun_angle = 15;
	MOVLW      15
	MOVWF      _t1+9
	MOVLW      0
	MOVWF      _t1+10
;Game.c,423 :: 		t1.gun_power = 50;
	MOVLW      50
	MOVWF      _t1+11
	MOVLW      0
	MOVWF      _t1+12
;Game.c,424 :: 		t1.gun_length = 12;
	MOVLW      12
	MOVWF      _t1+8
;Game.c,426 :: 		t2.body_width = t1.body_width;
	MOVLW      15
	MOVWF      _t2+0
;Game.c,427 :: 		t2.body_height = t1.body_height;
	MOVLW      4
	MOVWF      _t2+1
;Game.c,428 :: 		t2.head_width = t1.head_width ;
	MOVLW      6
	MOVWF      _t2+2
;Game.c,429 :: 		t2.head_height = t1.head_height ;
	MOVLW      2
	MOVWF      _t2+3
;Game.c,430 :: 		t2.x = 120;
	MOVLW      120
	MOVWF      _t2+5
;Game.c,431 :: 		t2.y = 10;
	MOVLW      10
	MOVWF      _t2+6
;Game.c,432 :: 		t2.wheel_dis = t1.wheel_dis;
	MOVLW      2
	MOVWF      _t2+4
;Game.c,433 :: 		t2.name  = "T2";
	MOVLW      ?lstr10_Game+0
	MOVWF      _t2+7
;Game.c,434 :: 		t2.gun_angle = 180 - t1.gun_angle ;
	MOVLW      165
	MOVWF      _t2+9
	MOVLW      0
	MOVWF      _t2+10
;Game.c,435 :: 		t2.gun_power = 80;
	MOVLW      80
	MOVWF      _t2+11
	MOVLW      0
	MOVWF      _t2+12
;Game.c,436 :: 		t2.gun_length = t1.gun_length;
	MOVLW      12
	MOVWF      _t2+8
;Game.c,438 :: 		ob1.x = 50;
	MOVLW      50
	MOVWF      _ob1+2
;Game.c,439 :: 		ob1.y = 0;
	CLRF       _ob1+3
;Game.c,440 :: 		ob1.width = 10;
	MOVLW      10
	MOVWF      _ob1+0
;Game.c,441 :: 		ob1.height = 30;
	MOVLW      30
	MOVWF      _ob1+1
;Game.c,442 :: 		}
	GOTO       L_Init_Level75
L_Init_Level74:
;Game.c,446 :: 		t1.body_width = 15;
	MOVLW      15
	MOVWF      _t1+0
;Game.c,447 :: 		t1.body_height = 4;
	MOVLW      4
	MOVWF      _t1+1
;Game.c,448 :: 		t1.head_width = 6;
	MOVLW      6
	MOVWF      _t1+2
;Game.c,449 :: 		t1.head_height = 2;
	MOVLW      2
	MOVWF      _t1+3
;Game.c,450 :: 		t1.x = 7;
	MOVLW      7
	MOVWF      _t1+5
;Game.c,451 :: 		t1.y = 15;
	MOVLW      15
	MOVWF      _t1+6
;Game.c,452 :: 		t1.wheel_dis = 2;
	MOVLW      2
	MOVWF      _t1+4
;Game.c,453 :: 		t1.name  = "T1";
	MOVLW      ?lstr11_Game+0
	MOVWF      _t1+7
;Game.c,454 :: 		t1.gun_angle = 30;
	MOVLW      30
	MOVWF      _t1+9
	MOVLW      0
	MOVWF      _t1+10
;Game.c,455 :: 		t1.gun_power = 65;
	MOVLW      65
	MOVWF      _t1+11
	MOVLW      0
	MOVWF      _t1+12
;Game.c,456 :: 		t1.gun_length = 12;
	MOVLW      12
	MOVWF      _t1+8
;Game.c,458 :: 		t2.body_width = t1.body_width;
	MOVLW      15
	MOVWF      _t2+0
;Game.c,459 :: 		t2.body_height = t1.body_height;
	MOVLW      4
	MOVWF      _t2+1
;Game.c,460 :: 		t2.head_width = t1.head_width ;
	MOVLW      6
	MOVWF      _t2+2
;Game.c,461 :: 		t2.head_height = t1.head_height ;
	MOVLW      2
	MOVWF      _t2+3
;Game.c,462 :: 		t2.x = 100;
	MOVLW      100
	MOVWF      _t2+5
;Game.c,463 :: 		t2.y = 1;
	MOVLW      1
	MOVWF      _t2+6
;Game.c,464 :: 		t2.wheel_dis = t1.wheel_dis;
	MOVLW      2
	MOVWF      _t2+4
;Game.c,465 :: 		t2.name  = "T2";
	MOVLW      ?lstr12_Game+0
	MOVWF      _t2+7
;Game.c,466 :: 		t2.gun_angle = 180 - t1.gun_angle ;
	MOVLW      150
	MOVWF      _t2+9
	MOVLW      0
	MOVWF      _t2+10
;Game.c,467 :: 		t2.gun_power = 80;
	MOVLW      80
	MOVWF      _t2+11
	MOVLW      0
	MOVWF      _t2+12
;Game.c,468 :: 		t2.gun_length = t1.gun_length;
	MOVLW      12
	MOVWF      _t2+8
;Game.c,470 :: 		current_l = 0x00;
	CLRF       _current_l+0
;Game.c,471 :: 		}
L_Init_Level75:
L_Init_Level73:
L_Init_Level71:
;Game.c,472 :: 		}
	RETURN
; end of _Init_Level

_main:

;Game.c,474 :: 		void main() {
;Game.c,475 :: 		TRISB = 0x01;
	MOVLW      1
	MOVWF      TRISB+0
;Game.c,476 :: 		TRISD = 0xff;
	MOVLW      255
	MOVWF      TRISD+0
;Game.c,477 :: 		Glcd_Init();
	CALL       _Glcd_Init+0
;Game.c,478 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Game.c,479 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);
	MOVLW      _Character8x7+0
	MOVWF      FARG_Glcd_Set_Font_activeFont+0
	MOVLW      hi_addr(_Character8x7+0)
	MOVWF      FARG_Glcd_Set_Font_activeFont+1
	MOVLW      8
	MOVWF      FARG_Glcd_Set_Font_aFontWidth+0
	MOVLW      7
	MOVWF      FARG_Glcd_Set_Font_aFontHeight+0
	MOVLW      32
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+0
	MOVLW      0
	MOVWF      FARG_Glcd_Set_Font_aFontOffs+1
	CALL       _Glcd_Set_Font+0
;Game.c,482 :: 		intLevel:
___main_intLevel:
;Game.c,483 :: 		if(started == 0x00)
	MOVF       _started+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main76
;Game.c,486 :: 		Init_Level();
	CALL       _Init_Level+0
;Game.c,487 :: 		INTCON = 0x90;
	MOVLW      144
	MOVWF      INTCON+0
;Game.c,488 :: 		started = 0x01;
	MOVLW      1
	MOVWF      _started+0
;Game.c,489 :: 		}
L_main76:
;Game.c,490 :: 		while(1)
L_main77:
;Game.c,492 :: 		if(started != 0x01) goto intLevel;
	MOVF       _started+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main79
	GOTO       ___main_intLevel
L_main79:
;Game.c,493 :: 		if(repaint == 0x01)
	MOVF       _repaint+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main80
;Game.c,495 :: 		Glcd_Fill(0x00);
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Game.c,496 :: 		Glcd_Rectangle(0,8,127,63,1);
	CLRF       FARG_Glcd_Rectangle_x_upper_left+0
	MOVLW      8
	MOVWF      FARG_Glcd_Rectangle_y_upper_left+0
	MOVLW      127
	MOVWF      FARG_Glcd_Rectangle_x_bottom_right+0
	MOVLW      63
	MOVWF      FARG_Glcd_Rectangle_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Rectangle_color+0
	CALL       _Glcd_Rectangle+0
;Game.c,498 :: 		draw_Labels();
	CALL       _draw_Labels+0
;Game.c,499 :: 		draw_menu();
	CALL       _draw_menu+0
;Game.c,500 :: 		draw_Tank(&t1);
	MOVLW      _t1+0
	MOVWF      FARG_draw_Tank_t+0
	CALL       _draw_Tank+0
;Game.c,501 :: 		draw_Tank(&t2);
	MOVLW      _t2+0
	MOVWF      FARG_draw_Tank_t+0
	CALL       _draw_Tank+0
;Game.c,502 :: 		draw_ob();
	CALL       _draw_ob+0
;Game.c,503 :: 		repaint = 0x00;
	CLRF       _repaint+0
;Game.c,505 :: 		if(fire == 0x01)
	MOVF       _fire+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main81
;Game.c,507 :: 		draw_fire();
	CALL       _draw_fire+0
;Game.c,508 :: 		fire = 0x00;
	CLRF       _fire+0
;Game.c,509 :: 		}
L_main81:
;Game.c,511 :: 		}
L_main80:
;Game.c,512 :: 		}
	GOTO       L_main77
;Game.c,513 :: 		}
	GOTO       $+0
; end of _main
