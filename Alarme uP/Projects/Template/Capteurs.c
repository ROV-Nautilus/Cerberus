#include "stm32f4xx.h"
#include <stdio.h>
#include "stm32f429i_discovery.h"

void InitCapteur(){
	GPIO_InitTypeDef GPIO_Init2;
	GPIO_InitTypeDef GPIO_Init3;
	GPIO_InitTypeDef GPIO_Init4;
	
	//GPIO G Port 14
	GPIO_Init2.GPIO_Pin = GPIO_Pin_14;
  GPIO_Init2.GPIO_Mode = GPIO_Mode_IN;
  GPIO_Init2.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init2.GPIO_OType = GPIO_OType_PP;
	GPIO_Init2.GPIO_Speed = GPIO_High_Speed;
  GPIO_Init(GPIOG, &GPIO_Init2);
	
	//GPIO D Port 11
	GPIO_Init3.GPIO_Pin = GPIO_Pin_11;
  GPIO_Init3.GPIO_Mode = GPIO_Mode_IN;
  GPIO_Init3.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init3.GPIO_OType = GPIO_OType_PP;
	GPIO_Init3.GPIO_Speed = GPIO_High_Speed;
  GPIO_Init(GPIOD, &GPIO_Init3);
	
	//GPIO B Port 13
	GPIO_Init4.GPIO_Pin = GPIO_Pin_13;
  GPIO_Init4.GPIO_Mode = GPIO_Mode_IN;
  GPIO_Init4.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init4.GPIO_OType = GPIO_OType_PP;
	GPIO_Init4.GPIO_Speed = GPIO_High_Speed;
  GPIO_Init(GPIOB, &GPIO_Init4);
}

uint8_t Capteur1(){
	return GPIO_ReadInputDataBit(GPIOG, GPIO_Pin_14);
}

uint8_t Capteur2(){
	return GPIO_ReadInputDataBit(GPIOD, GPIO_Pin_11);
}

uint8_t Capteur3(){
	return GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_13);
}
