#include "stm32f4xx.h"
#include <stdio.h>
#include "stm32f4xx_dac.h"
#include "LEDs.h"
#include "stm32f429i_discovery.h"
#include "stm32f429i_discovery_lcd.h"
#include "stm32f429i_discovery_ioe.h"


void PremierMenu(void)
{
  
  /* Configure the IO Expander */
  if (IOE_Config() == IOE_OK)
  {   
		//Affichage Titre
		LCD_DisplayStringLine(LINE(1), (uint8_t*)"    Cerberus   ");
    LCD_DrawRect(10, 10, 48, 220);
		
		//Affichage Bouton On et Off
		LCD_SetTextColor(LCD_COLOR_GREEN);
		LCD_DrawFullRect(30, 130, 70, 70);
		LCD_SetTextColor(LCD_COLOR_RED);
		LCD_DrawFullRect(140, 130, 70, 70);
		LCD_SetColors(LCD_COLOR_BLACK,LCD_COLOR_GREEN);
		LCD_DisplayChar(155, 47, 0x4F);
		LCD_DisplayChar(155, 65, 0x6E);
		
		LCD_SetColors(LCD_COLOR_BLACK,LCD_COLOR_RED);
		LCD_DisplayChar(155, 151, 0x4F);
		LCD_DisplayChar(155, 169, 0x66);
		LCD_DisplayChar(155, 187, 0x66);
		
		//Remise au Blanc
		LCD_SetColors(LCD_COLOR_BLACK,LCD_COLOR_WHITE);
		LCD_ClearLine(LINE(10));
		LCD_ClearLine(LINE(11));
		
  }  
  else
  {
    LCD_Clear(LCD_COLOR_RED);
    LCD_SetTextColor(LCD_COLOR_BLACK); 
    LCD_DisplayStringLine(LCD_LINE_6,(uint8_t*)"Problem Init.");
    LCD_DisplayStringLine(LCD_LINE_7,(uint8_t*)"Reset the board   ");
    LCD_DisplayStringLine(LCD_LINE_8,(uint8_t*)"and try again     ");
  }
}

void DeuxiemeMenu(void)
{
  
  /* Configure the IO Expander */
  if (IOE_Config() == IOE_OK)
  {   
		//Affichage
		LCD_SetColors(LCD_COLOR_RED,LCD_COLOR_WHITE);
		LCD_DisplayStringLine(LINE(10), (uint8_t*)"   Alarme en   ");
		LCD_DisplayStringLine(LINE(11), (uint8_t*)"    Attente    ");
		
		//Remise au Blanc
		LCD_SetColors(LCD_COLOR_BLACK,LCD_COLOR_WHITE);
		
  }  
  else
  {
    LCD_Clear(LCD_COLOR_RED);
    LCD_SetTextColor(LCD_COLOR_BLACK); 
    LCD_DisplayStringLine(LCD_LINE_6,(uint8_t*)"Problem Init.");
    LCD_DisplayStringLine(LCD_LINE_7,(uint8_t*)"Reset the board   ");
    LCD_DisplayStringLine(LCD_LINE_8,(uint8_t*)"and try again     ");
  }
}

void TroisiemeMenu(void)
{
  
  /* Configure the IO Expander */
  if (IOE_Config() == IOE_OK)
  {   
		//Affichage
		LCD_SetColors(LCD_COLOR_GREEN,LCD_COLOR_WHITE);
		LCD_DisplayStringLine(LINE(10), (uint8_t*)"   Alarme en   ");
		LCD_DisplayStringLine(LINE(11), (uint8_t*)"    Marche     ");
		
		//Remise au Blanc
		LCD_SetColors(LCD_COLOR_BLACK,LCD_COLOR_WHITE);
		
  }  
  else
  {
    LCD_Clear(LCD_COLOR_RED);
    LCD_SetTextColor(LCD_COLOR_BLACK); 
    LCD_DisplayStringLine(LCD_LINE_6,(uint8_t*)"Problem Init.");
    LCD_DisplayStringLine(LCD_LINE_7,(uint8_t*)"Reset the board   ");
    LCD_DisplayStringLine(LCD_LINE_8,(uint8_t*)"and try again     ");
  }
}

void Debut(void){
	/* LCD initialization */
  LCD_Init();
	
  /* LCD Layer initialization */
  LCD_LayerInit();
    
  /* Enable the LTDC */
  LTDC_Cmd(ENABLE);
  
  /* Set LCD foreground layer */
  LCD_SetLayer(LCD_FOREGROUND_LAYER);
  
	/* Clear the LCD */ 
  LCD_Clear(LCD_COLOR_WHITE);
	
	/*Initialisation Sortie */
	InitSortie();
	EnvoiSortie0();
}
